#!/usr/bin/env bash
# Propagate canonical dependabot config + auto-merge workflow to forgesworn repos.
#
# Strategy: for each repo, create a branch, commit updated .github/dependabot.yml
# and .github/workflows/dependabot-auto-merge.yml, push, open a PR. Never direct-commits
# to main -- the PR lets CI validate the change.
#
# Usage:
#   ./propagate.sh                    # dry-run: prints what it would do
#   ./propagate.sh --apply            # actually create branches + PRs
#   ./propagate.sh --apply --repo X   # just one repo

set -euo pipefail

APPLY=0
ONLY_REPO=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) APPLY=1; shift ;;
    --repo)  ONLY_REPO="$2"; shift 2 ;;
    *) echo "unknown arg: $1"; exit 2 ;;
  esac
done

TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

# Skip-list: space-separated repo names that must not be touched.
# Populate via env var so private/archive rules stay out of the public template.
# Example: DEPENDABOT_SKIP_REPOS="foo bar baz" ./propagate.sh --apply
read -ra SKIP_REPOS <<< "${DEPENDABOT_SKIP_REPOS:-}"

# Fetch the live repo list from the org; filter archived + forks.
REPOS=$(gh api "/orgs/forgesworn/repos?per_page=100" --paginate \
  -q '.[] | select(.archived == false and .fork == false) | .name')

# Echoes every ecosystem the repo actually contains, space separated, e.g.
# "npm cargo". Deliberately NOT first-match-wins: charter carries a package.json
# for its console AND two cargo workspaces, and the old first-match version
# labelled it "npm", so its whole Rust tree went unmanaged. Sixteen cargo PRs
# opened and then sat unrebased for seven weeks before anyone noticed.
detect_ecosystems() {
  local repo="$1" found=""
  gh api "/repos/forgesworn/$repo/contents/go.mod"       >/dev/null 2>&1 && found="$found gomod"
  gh api "/repos/forgesworn/$repo/contents/package.json" >/dev/null 2>&1 && found="$found npm"
  gh api "/repos/forgesworn/$repo/contents/Cargo.toml"   >/dev/null 2>&1 && found="$found cargo"
  # Cargo crates often live in subdirectories rather than at the root. Look one
  # level down before concluding there is no Rust here.
  if [[ "$found" != *cargo* ]]; then
    if gh api "/repos/forgesworn/$repo/contents/" -q '.[]|select(.type=="dir")|.name' 2>/dev/null \
        | while read -r d; do
            gh api "/repos/forgesworn/$repo/contents/$d/Cargo.toml" >/dev/null 2>&1 && { echo hit; break; }
          done | grep -q hit; then
      found="$found cargo"
    fi
  fi
  echo "${found# }"
}

# Compose .github/dependabot.yml from one fragment per detected ecosystem plus
# the shared github-actions block. The previous version copied a single whole
# template over the file, which cannot express a repo with two ecosystems and
# silently discarded any hand-added block on the next run.
compose_config() {
  local out="$1"; shift
  {
    cat "$TEMPLATE_DIR/fragments/header.yml"
    for eco in "$@"; do cat "$TEMPLATE_DIR/fragments/$eco.yml"; echo; done
    cat "$TEMPLATE_DIR/fragments/github-actions.yml"
  } > "$out"
}

in_skiplist() {
  local r="$1"
  # Guard the length first. Under `set -u` on bash 3.2 -- which is what macOS
  # still ships -- expanding "${SKIP_REPOS[@]}" on an empty array is an unbound
  # variable error, so the script aborted on its very first repo unless
  # DEPENDABOT_SKIP_REPOS happened to be set. That is almost certainly why repos
  # have been running stale copies of these templates.
  [[ ${#SKIP_REPOS[@]} -eq 0 ]] && return 1
  for s in "${SKIP_REPOS[@]}"; do [[ "$r" == "$s" ]] && return 0; done
  return 1
}

for repo in $REPOS; do
  [[ -n "$ONLY_REPO" && "$repo" != "$ONLY_REPO" ]] && continue
  in_skiplist "$repo" && { echo "skip (skiplist): $repo"; continue; }

  read -ra ECOSYSTEMS <<< "$(detect_ecosystems "$repo")"
  if [[ ${#ECOSYSTEMS[@]} -eq 0 ]]; then
    echo "skip (no npm/gomod/cargo): $repo"
    continue
  fi

  echo "=== $repo (${ECOSYSTEMS[*]}) ==="
  if [[ $APPLY -eq 0 ]]; then
    echo "  would apply: ${ECOSYSTEMS[*]} fragments + github-actions + dependabot-auto-merge.yml"
    continue
  fi

  REPO_DIR="$WORKDIR/$repo"
  gh repo clone "forgesworn/$repo" "$REPO_DIR" -- --depth 1 --quiet
  cd "$REPO_DIR"

  BRANCH="chore/dependabot-template-sync"
  git switch -c "$BRANCH"

  mkdir -p .github/workflows
  # Compose from the template, then hand back the settings that belong to the
  # repo rather than the template: where its packages live, how often to look,
  # how many PRs at once. Without this the sync flattens charter's cargo
  # `directories: [/core, /linux]` to `/`, which has no Cargo.toml, and
  # un-manages the very tree the cargo fragment was added to cover.
  PREV_CONFIG=""
  if [[ -f .github/dependabot.yml ]]; then
    PREV_CONFIG="$(mktemp)"; cp .github/dependabot.yml "$PREV_CONFIG"
  fi
  compose_config .github/dependabot.yml "${ECOSYSTEMS[@]}"
  if [[ -n "$PREV_CONFIG" ]]; then
    python3 "$TEMPLATE_DIR/merge-local.py" "$PREV_CONFIG" .github/dependabot.yml
    rm -f "$PREV_CONFIG"
  fi
  cp "$TEMPLATE_DIR/dependabot-auto-merge.yml"   .github/workflows/dependabot-auto-merge.yml

  # A cargo repo whose crates are not at the root needs `directories` listing
  # them. Composition cannot know that, so say so rather than quietly shipping
  # a config that watches the wrong path.
  if [[ " ${ECOSYSTEMS[*]} " == *" cargo "* ]]; then
    echo "  NOTE: $repo has cargo -- check the directory/directories key matches where its crates live"
  fi

  git add .github/dependabot.yml .github/workflows/dependabot-auto-merge.yml
  if git diff --cached --quiet; then
    echo "  no changes; skipping $repo"
    cd - >/dev/null
    continue
  fi

  git commit -m "chore: sync dependabot config from template

Tiered auto-merge: patch/minor grouped and auto-merged on green CI;
majors open individual PRs for deliberate review. TS/Node majors
ignored here -- upgraded deliberately as project work."
  git push -u origin "$BRANCH" --quiet

  gh pr create \
    --repo "forgesworn/$repo" \
    --head "$BRANCH" \
    --title "chore: sync dependabot config from template" \
    --body "Syncs canonical \`dependabot.yml\` and auto-merge workflow from \`forgesworn/.github/templates/dependabot/\`.

Changes:
- Patch/minor bumps grouped and auto-merged on green CI
- Majors open individual PRs (no more breaking changes hidden in group bumps)
- TypeScript, \`@types/node\`, and Node runtime majors ignored by dependabot -- upgraded deliberately"

  cd - >/dev/null
done

echo ""
if [[ $APPLY -eq 0 ]]; then
  echo "Dry-run complete. Re-run with --apply to create branches and PRs."
fi
