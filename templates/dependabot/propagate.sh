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

classify_repo() {
  # echoes "npm", "gomod", or "skip"
  local repo="$1"
  if gh api "/repos/forgesworn/$repo/contents/go.mod" >/dev/null 2>&1; then
    echo gomod; return
  fi
  if gh api "/repos/forgesworn/$repo/contents/package.json" >/dev/null 2>&1; then
    echo npm; return
  fi
  echo skip
}

in_skiplist() {
  local r="$1"
  for s in "${SKIP_REPOS[@]}"; do [[ "$r" == "$s" ]] && return 0; done
  return 1
}

for repo in $REPOS; do
  [[ -n "$ONLY_REPO" && "$repo" != "$ONLY_REPO" ]] && continue
  in_skiplist "$repo" && { echo "skip (skiplist): $repo"; continue; }

  kind=$(classify_repo "$repo")
  if [[ "$kind" == "skip" ]]; then
    echo "skip (no npm/gomod): $repo"
    continue
  fi

  echo "=== $repo ($kind) ==="
  if [[ $APPLY -eq 0 ]]; then
    echo "  would apply: dependabot.$kind.yml + dependabot-auto-merge.yml"
    continue
  fi

  REPO_DIR="$WORKDIR/$repo"
  gh repo clone "forgesworn/$repo" "$REPO_DIR" -- --depth 1 --quiet
  cd "$REPO_DIR"

  BRANCH="chore/dependabot-template-sync"
  git switch -c "$BRANCH"

  mkdir -p .github/workflows
  cp "$TEMPLATE_DIR/dependabot.$kind.yml"        .github/dependabot.yml
  cp "$TEMPLATE_DIR/dependabot-auto-merge.yml"   .github/workflows/dependabot-auto-merge.yml

  if git diff --quiet; then
    echo "  no changes; skipping $repo"
    cd - >/dev/null
    continue
  fi

  git add .github/dependabot.yml .github/workflows/dependabot-auto-merge.yml
  git commit -m "chore: sync dependabot config from template

Tiered auto-merge: patch/minor grouped and auto-merged on green CI;
majors open individual PRs for deliberate review. TS/Node majors
ignored here -- upgraded deliberately as project work."
  git push -u origin "$BRANCH" --quiet

  gh pr create \
    --repo "forgesworn/$repo" \
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
