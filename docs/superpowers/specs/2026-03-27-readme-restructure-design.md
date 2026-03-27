# ForgeSworn README Restructure

**Date:** 2026-03-27
**Status:** Approved
**Scope:** `forgesworn-github` repo (org profile README, visual guides, JSON manifest)

## Problem

The ForgeSworn GitHub org has grown from 21 to 30 public repos. Nine new repos (bray, nostr-veil, dominion, signet, toll-booth-mcp, shamir-core, payment-methods, nip-drafts, trott-conformance) are not reflected in the README or Mermaid diagrams. The current 4-section structure does not scale or tell the ecosystem story.

## Approach

Ecosystem narrative restructure (Approach B from brainstorming). Reorganise around what you are building towards. Elevate bray and nostr-veil as top-level entry points. Add structured JSON manifest for the forgesworn.dev site.

## Files to Modify

| File | Action |
|------|--------|
| `profile/README.md` | Rewrite -- 8 category sections, 30 repos, ecosystem narrative |
| `docs/ecosystem-overview.md` | Add new subgraphs, nodes, update counts |
| `docs/identity-stack.md` | Add signet, dominion, shamir-core nodes |
| `docs/l402-pipeline.md` | Add toll-booth-mcp node |
| `forgesworn-repos.json` | New file -- structured manifest for forgesworn.dev |

## New Public Repos (9)

| Repo | Category | Description |
|------|----------|-------------|
| bray | AI Agents | Trust-aware Nostr MCP for AI and humans. 106 tools across 13 groups. |
| nostr-veil | Trust / Privacy | Anonymous trust assertions using LSAG ring signatures over NIP-85. |
| dominion | Identity / Access | Epoch-based encrypted access control. HKDF, AES-256-GCM, Shamir, tiered audiences. |
| signet | Identity / Access | Decentralised identity verification. 4 tiers, ZKP age proofs, Signet IQ. |
| toll-booth-mcp | L402 / Machine Payments | MCP server with read-only analytics and widget UIs for toll-booth. |
| shamir-core | Cryptographic Primitives | Shamir's Secret Sharing over GF(256). Backend for shamir-words. |
| payment-methods | L402 / Machine Payments | Specs for HTTP Payment Authentication (Lightning, Cashu, Session). |
| nip-drafts | Protocol / Standards | 30 Nostr protocol extensions. |
| trott-conformance | Protocol / Standards | Protocol conformance test suite. |

## README Structure

### 1. Opening

Updated tagline and bullet list reflecting full scope: payments, identity, trust, privacy, AI agents, spatial, protocol standards, cryptographic primitives.

### 2. Visual Guides Link

Unchanged format, same three links.

### 3. Start Here

13 use-case entries. Each shows what the repo does and what it connects to. Order:

1. toll-booth (+ toll-booth-announce, 402-announce, 402-indexer, 402-pub, toll-booth-mcp, toll-booth-dvm)
2. 402-mcp (+ toll-booth, 402-pub)
3. bray (+ nsec-tree, dominion) -- elevated as AI agent entry point
4. nostr-veil (+ ring-sig) -- elevated as privacy/trust entry point
5. rendezvous-kit (+ geohash-kit, rendezvous-mcp)
6. spoken-token (+ canary-kit)
7. nsec-tree (+ nsec-tree-cli, bray, signet)
8. canary-kit (+ ring-sig, range-proof, shamir-words)
9. signet (+ nostr-attestations, range-proof)
10. dominion (+ bray)
11. nostr-attestations
12. jurisdiction-kit (+ canary-kit, signet)
13. nip-drafts

### 4. Common Flows

9 chains (3 new):

- `toll-booth -> toll-booth-announce -> 402-announce -> 402-indexer -> 402-pub -> 402-mcp`
- `toll-booth -> toll-booth-mcp` (new)
- `geohash-kit -> rendezvous-kit -> rendezvous-mcp`
- `nsec-tree -> bray -> dominion` (new)
- `nsec-tree -> spoken-token / canary-kit`
- `ring-sig -> nostr-veil` (new)
- `nostr-attestations -> signet -> canary-kit / jurisdiction-kit`
- `spoken-token -> canary-kit -> ring-sig / range-proof / shamir-words`
- `shamir-core -> shamir-words -> nsec-tree-cli`

### 5-12. Category Sections (8 sections, 30 repos)

Repo count verification: 11 + 3 + 6 + 1 + 2 + 4 + 1 + 2 = 30.

**L402 / Machine Payments (11 repos)**
Existing 9 + toll-booth-mcp, payment-methods.

**Spatial / Meeting (3 repos)**
Unchanged.

**Identity / Access (6 repos)**
spoken-token, canary-kit, nsec-tree, nsec-tree-cli, signet, dominion. Keep existing descriptions, add new rows for signet and dominion.

**AI Agents (1 repo)**
bray. Standalone section. Description covers 106 tools, 13 groups, three trust dimensions (Verification + Proximity + Access).

**Trust / Privacy (2 repos)**
nostr-veil, nostr-attestations. nostr-attestations moved here from Identity because it is fundamentally about trust assertions. Still referenced in Identity "Start Here" entries.

**Cryptographic Primitives (4 repos)**
Existing 3 + shamir-core. Existing shamir-words description updated to mention shamir-core as backend.

**Compliance (1 repo)**
jurisdiction-kit. Unchanged.

**Protocol / Standards (2 repos)**
nip-drafts, trott-conformance. New section.

## Diagram Changes

### ecosystem-overview.md

System Context diagram:
- Add subgraph "AI Agents -- 1 repo" containing bray
- Add subgraph "Trust / Privacy -- 2 repos" containing nostr-veil, nostr-attestations
- Add subgraph "Protocol / Standards -- 2 repos" containing nip-drafts, trott-conformance
- Move nostr-attestations from Identity to Trust/Privacy subgraph
- Add signet, dominion to Identity subgraph (now 6 repos: spoken-token, canary-kit, nsec-tree, nsec-tree-cli, signet, dominion)
- Add toll-booth-mcp, payment-methods to Payments subgraph (now 11 repos)
- Add shamir-core to Foundation subgraph (now 4 repos)
- New arrows: AI Agents depends on Identity and Foundation; Trust/Privacy depends on Foundation
- Click links for all new nodes

"How the Stacks Connect" diagram:
- Update repo counts in all boxes
- Add AI Agents, Trust/Privacy, Protocol/Standards boxes
- New relationship arrows

Categories table:
- Update all counts
- Add new rows for AI Agents, Trust/Privacy, Protocol/Standards

### identity-stack.md

- Add signet and dominion to Layer 1 (Applications)
- Add shamir-core to Layer 3 (Cryptographic Primitives)
- Keep nostr-attestations in Layer 1 (it is part of the identity stack flow even though its README section is Trust/Privacy)
- Update click links

### l402-pipeline.md

- Add toll-booth-mcp to Layer 4 (Consume)
- Add text reference to payment-methods in the intro paragraph (not a diagram node -- it is a spec, not a pipeline step)
- Update click links

## JSON Manifest

`forgesworn-repos.json` at repo root. Structure:

```json
{
  "generated": "2026-03-27",
  "totalPublicRepos": 30,
  "categories": [
    {
      "name": "L402 / Machine Payments",
      "slug": "l402",
      "description": "Make APIs payable, discoverable, and consumable by people and agents.",
      "repos": [
        {
          "name": "toll-booth",
          "github": "https://github.com/forgesworn/toll-booth",
          "npm": "@forgesworn/toll-booth",
          "description": "Any API becomes a Lightning toll booth in one line.",
          "tags": ["l402", "lightning", "middleware"],
          "dependsOn": [],
          "usedBy": ["toll-booth-announce", "toll-booth-dvm", "toll-booth-mcp"]
        }
      ]
    }
  ]
}
```

Every repo gets: name, github URL, npm package (if any), one-line description, tags, dependsOn, usedBy. The forgesworn.dev site agent reads this as source of truth for repo listing, categorisation, and dependency graph.

## Decisions

1. **nostr-attestations** moves from Identity to Trust/Privacy in the README, but stays in the identity-stack.md diagram because it is part of that flow.
2. **bray** gets its own section (AI Agents) rather than being buried in Identity.
3. **payment-methods** is a text reference in l402-pipeline.md, not a diagram node.
4. **signet-you** (private), **nostr-anon-vote** (private) are excluded.
5. **signet** origin is `forgesworn/signet.git`. The `decented` remote is legacy.
