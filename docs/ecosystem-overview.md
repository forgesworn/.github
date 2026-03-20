# Ecosystem Overview

How the ForgeSworn building blocks fit together. Three independent stacks built on a shared foundation of cryptographic primitives.

## System Context

```mermaid
block-beta
    columns 3

    space:3

    block:payments["⚡ L402 / Machine Payments"]:1
        columns 1
        p1["toll-booth · toll-booth-dvm"]
        p2["402-announce · toll-booth-announce"]
        p3["402-indexer · 402-pub · 402-mcp"]
        p4["aperture-announce · aperture-phoenixd"]
    end

    block:spatial["📍 Spatial / Meeting"]:1
        columns 1
        s1["geohash-kit"]
        s2["rendezvous-kit"]
        s3["rendezvous-mcp"]
    end

    block:identity["🔑 Identity / Verification"]:1
        columns 1
        i1["spoken-token · canary-kit"]
        i2["nsec-tree · nsec-tree-cli"]
        i3["nostr-attestations"]
    end

    space:3

    block:foundation["🔒 Foundation"]:3
        columns 3
        f1["ring-sig"]
        f2["range-proof · shamir-words"]
        f3["jurisdiction-kit"]
    end

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
