#!/usr/bin/env python3
"""Hand repo-local operational settings back into a freshly composed dependabot.yml.

The template owns POLICY -- which groups exist, what they cover, what is ignored.
The repo owns OPERATIONS -- where its packages live, how often to look, how many
PRs at once. Copying the template wholesale destroyed the second category: it
would flatten charter's cargo `directories: [/core, /linux]` to `directory: /`,
a path with no Cargo.toml, silently un-managing the tree the cargo fragment was
added to cover.

This patches the composed TEXT rather than re-serialising it. A yaml round-trip
would drop every comment in the file, and those comments are the only record of
why the peer-locked families are grouped at all -- which is exactly the
knowledge whose absence let this bug recur across four repos.

Usage: merge-local.py <existing.yml> <composed.yml>   (edits composed.yml)
Missing or unparseable input is not fatal; the composed file is left alone.
"""
import sys, re, pathlib

try:
    import yaml
except ImportError:
    sys.exit(0)

# Scalar operational keys safe to carry over. Deliberately excludes `groups` and
# `ignore`: those are the policy the template exists to enforce.
SCALAR_KEYS = ("open-pull-requests-limit", "target-branch")


def eco_blocks(text):
    """Yield (ecosystem, start_line, end_line) over the composed file's entries."""
    lines = text.splitlines()
    starts = [i for i, l in enumerate(lines)
              if re.match(r"^  - package-ecosystem:\s*\S+", l)]
    for n, i in enumerate(starts):
        eco = lines[i].split(":", 1)[1].strip()
        end = starts[n + 1] if n + 1 < len(starts) else len(lines)
        yield eco, i, end


def main(existing_path, composed_path):
    existing, composed = pathlib.Path(existing_path), pathlib.Path(composed_path)
    if not existing.is_file():
        return
    try:
        old = yaml.safe_load(existing.read_text()) or {}
    except yaml.YAMLError:
        return
    prev = {u.get("package-ecosystem"): u for u in old.get("updates", [])}

    text = composed.read_text()
    lines = text.splitlines(keepends=True)
    notes = []

    # Work back-to-front so earlier line numbers stay valid as we splice.
    for eco, start, end in reversed(list(eco_blocks(text))):
        p = prev.get(eco)
        if not p:
            continue
        seg = lines[start:end]

        # directory / directories: the two are alternatives, so replace as a pair.
        if "directories" in p or "directory" in p:
            want = (["    directories:\n"] + [f"      - {d!r}\n".replace("'", '"') for d in p["directories"]]
                    if "directories" in p else
                    [f'    directory: "{p["directory"]}"\n'])
            kept = []
            skipping = False
            for l in seg:
                if re.match(r"^    directory:", l) or re.match(r"^    directories:", l):
                    skipping = True
                    continue
                if skipping:
                    if re.match(r"^      - ", l):
                        continue
                    skipping = False
                kept.append(l)
            # Re-insert directly after the package-ecosystem line.
            # Only report an actual change; re-stating an identical "/" is noise
            # that makes the real overrides harder to spot in the run output.
            before = "".join(l for l in seg if re.match(r"^    director(y|ies):", l)
                             or re.match(r"^      - ", l))
            seg = [kept[0]] + want + kept[1:]
            if before.split() != "".join(want).split():
                cur = p.get("directories") or p.get("directory")
                notes.append(f"{eco}.directory={cur!r}")

        # schedule.interval
        if isinstance(p.get("schedule"), dict) and "interval" in p["schedule"]:
            iv = p["schedule"]["interval"]
            for i, l in enumerate(seg):
                if re.match(r"^      interval:", l):
                    if l.split(":", 1)[1].strip() != iv:
                        notes.append(f"{eco}.schedule={iv}")
                    seg[i] = f"      interval: {iv}\n"
                    break

        for key in SCALAR_KEYS:
            if key not in p:
                continue
            for i, l in enumerate(seg):
                if re.match(rf"^    {re.escape(key)}:", l):
                    if l.split(":", 1)[1].strip() != str(p[key]):
                        notes.append(f"{eco}.{key}={p[key]}")
                    seg[i] = f"    {key}: {p[key]}\n"
                    break

        lines[start:end] = seg

    composed.write_text("".join(lines))
    if notes:
        print("  kept repo-local: " + ", ".join(notes))


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
