# Ecosystem Overview

How the ForgeSworn building blocks fit together. Three independent stacks built on a shared foundation of cryptographic primitives.

## System Context

```mermaid
graph TB
    subgraph payments["⚡ L402 / Machine Payments — 9 repos"]
        direction LR
        p1["toll-booth"]
        p2["toll-booth-dvm"]
        p3["toll-booth-announce"]
        p4["402-announce"]
        p5["402-indexer"]
        p6["402-pub"]
        p7["402-mcp"]
        p8["aperture-announce"]
        p9["aperture-phoenixd"]
    end

    subgraph spatial["📍 Spatial / Meeting — 3 repos"]
        direction LR
        s1["geohash-kit"]
        s2["rendezvous-kit"]
        s3["rendezvous-mcp"]
    end

    subgraph identity["🔑 Identity / Verification — 5 repos"]
        direction LR
        i1["spoken-token"]
        i2["canary-kit"]
        i3["nsec-tree"]
        i4["nsec-tree-cli"]
        i5["nostr-attestations"]
    end

    subgraph foundation["🔒 Foundation — 4 repos"]
        direction LR
        f1["ring-sig"]
        f2["range-proof"]
        f3["shamir-words"]
        f4["jurisdiction-kit"]
    end

    foundation --> identity
    foundation -.-> payments
    identity -.-> payments
    identity -.-> spatial

    click p1 "https://github.com/forgesworn/toll-booth" _blank
    click p2 "https://github.com/forgesworn/toll-booth-dvm" _blank
    click p3 "https://github.com/forgesworn/toll-booth-announce" _blank
    click p4 "https://github.com/forgesworn/402-announce" _blank
    click p5 "https://github.com/forgesworn/402-indexer" _blank
    click p6 "https://github.com/forgesworn/402-pub" _blank
    click p7 "https://github.com/forgesworn/402-mcp" _blank
    click p8 "https://github.com/forgesworn/aperture-announce" _blank
    click p9 "https://github.com/forgesworn/aperture-phoenixd" _blank
    click s1 "https://github.com/forgesworn/geohash-kit" _blank
    click s2 "https://github.com/forgesworn/rendezvous-kit" _blank
    click s3 "https://github.com/forgesworn/rendezvous-mcp" _blank
    click i1 "https://github.com/forgesworn/spoken-token" _blank
    click i2 "https://github.com/forgesworn/canary-kit" _blank
    click i3 "https://github.com/forgesworn/nsec-tree" _blank
    click i4 "https://github.com/forgesworn/nsec-tree-cli" _blank
    click i5 "https://github.com/forgesworn/nostr-attestations" _blank
    click f1 "https://github.com/forgesworn/ring-sig" _blank
    click f2 "https://github.com/forgesworn/range-proof" _blank
    click f3 "https://github.com/forgesworn/shamir-words" _blank
    click f4 "https://github.com/forgesworn/jurisdiction-kit" _blank

    style payments fill:#2d1b3d,stroke:#e94560,color:#eee,stroke-width:2px
    style spatial fill:#1b2d3d,stroke:#0f3460,color:#eee,stroke-width:2px
    style identity fill:#1b3d2d,stroke:#16c79a,color:#eee,stroke-width:2px
    style foundation fill:#2d2d1b,stroke:#f5a623,color:#eee,stroke-width:2px
```

## How the Stacks Connect

```mermaid
graph LR
    PAY["⚡ L402 Payments<br/><b>9 repos</b><br/><i>Gate, announce, index,<br/>discover, pay</i>"]
    SPA["📍 Spatial<br/><b>3 repos</b><br/><i>Geohash, meeting points,<br/>AI agents</i>"]
    IDN["🔑 Identity<br/><b>5 repos</b><br/><i>Spoken verification,<br/>sub-identities, attestations</i>"]
    FND["🔒 Foundation<br/><b>4 repos</b><br/><i>Ring sigs, range proofs,<br/>Shamir, jurisdictions</i>"]

    FND --> IDN
    FND -.-> PAY
    IDN -.->|"verify payers"| PAY
    IDN -.->|"verify participants"| SPA

    click PAY "l402-pipeline.md" _blank
    click SPA "ecosystem-overview.md" _blank
    click IDN "identity-stack.md" _blank
    click FND "identity-stack.md" _blank

    style PAY fill:#2d1b3d,stroke:#e94560,color:#eee,stroke-width:3px
    style SPA fill:#1b2d3d,stroke:#0f3460,color:#eee,stroke-width:3px
    style IDN fill:#1b3d2d,stroke:#16c79a,color:#eee,stroke-width:3px
    style FND fill:#2d2d1b,stroke:#f5a623,color:#eee,stroke-width:3px

    linkStyle 0 stroke:#f5a623,stroke-width:2px
    linkStyle 1 stroke:#f5a623,stroke-width:2px,stroke-dasharray:5
    linkStyle 2 stroke:#16c79a,stroke-width:2px,stroke-dasharray:5
    linkStyle 3 stroke:#16c79a,stroke-width:2px,stroke-dasharray:5
```

## Categories

| Category | Repos | Entry point | What it does |
|:---------|:-----:|:------------|:-------------|
| **⚡ L402 / Machine Payments** | 9 | [toll-booth](https://github.com/forgesworn/toll-booth) | Make any API payable via Lightning, announce it on Nostr, let AI agents find and consume it |
| **📍 Spatial / Meeting** | 3 | [rendezvous-kit](https://github.com/forgesworn/rendezvous-kit) | Geohash encoding, fair meeting point computation, MCP server for AI agents |
| **🔑 Identity / Verification** | 5 | [canary-kit](https://github.com/forgesworn/canary-kit) | Spoken verification, duress detection, deterministic Nostr identities, verifiable attestations |
| **🔒 Foundation** | 4 | [ring-sig](https://github.com/forgesworn/ring-sig) | Ring signatures, range proofs, Shamir secret sharing, jurisdiction intelligence |

**Drill down:** [L402 pipeline](l402-pipeline.md) | [Identity stack](identity-stack.md)
