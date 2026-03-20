# L402 Pipeline

The full lifecycle of a Lightning-paid API: create, gate, announce, index, discover, pay, consume.

## Pipeline Overview

```mermaid
graph TB
    subgraph layer1["Layer 1 — Gate Your API"]
        direction LR
        TB["<b>toll-booth</b><br/><i>L402 middleware for Express,<br/>Hono, Deno, Bun, Workers</i>"]
    end

    subgraph layer2["Layer 2 — Announce on Nostr"]
        direction LR
        TBA["<b>toll-booth-announce</b><br/><i>Bridge: toll-booth config<br/>→ 402-announce</i>"]
        ANN["<b>402-announce</b><br/><i>Publish kind 31402<br/>to Nostr relays</i>"]
        TBA --> ANN
    end

    subgraph layer2alt["Layer 2 — Announce (Aperture)"]
        direction LR
        APXPH["<b>aperture-phoenixd</b><br/><i>Phoenixd backend<br/>for Aperture</i>"]
        APX["<b>aperture-announce</b><br/><i>Aperture YAML<br/>→ kind 31402</i>"]
        APXPH -.-> APX
    end

    subgraph layer3["Layer 3 — Index & Discover"]
        direction LR
        IDX["<b>402-indexer</b><br/><i>Crawl Nostr for<br/>kind 31402 events</i>"]
        PUB["<b>402-pub</b><br/><i>Live directory<br/>at 402.pub</i>"]
        IDX --> PUB
    end

    subgraph layer4["Layer 4 — Consume"]
        direction LR
        MCP["<b>402-mcp</b><br/><i>AI agents discover,<br/>pay, and consume</i>"]
        DVM["<b>toll-booth-dvm</b><br/><i>Expose as NIP-90<br/>Data Vending Machine</i>"]
    end

    layer1 --> layer2
    layer1 --> layer2alt
    layer2 --> layer3
    layer2alt --> layer3
    layer3 --> layer4
    layer1 -->|"direct"| layer4

    click TB "https://github.com/forgesworn/toll-booth" _blank
    click TBA "https://github.com/forgesworn/toll-booth-announce" _blank
    click ANN "https://github.com/forgesworn/402-announce" _blank
    click APXPH "https://github.com/forgesworn/aperture-phoenixd" _blank
    click APX "https://github.com/forgesworn/aperture-announce" _blank
    click IDX "https://github.com/forgesworn/402-indexer" _blank
    click PUB "https://github.com/forgesworn/402-pub" _blank
    click MCP "https://github.com/forgesworn/402-mcp" _blank
    click DVM "https://github.com/forgesworn/toll-booth-dvm" _blank

    style layer1 fill:#2d1b3d,stroke:#e94560,color:#eee,stroke-width:2px
    style layer2 fill:#3d2d1b,stroke:#f5a623,color:#eee,stroke-width:2px
    style layer2alt fill:#3d2d1b,stroke:#f5a623,color:#eee,stroke-width:2px
    style layer3 fill:#1b2d3d,stroke:#0f3460,color:#eee,stroke-width:2px
    style layer4 fill:#1b3d2d,stroke:#16c79a,color:#eee,stroke-width:2px
```

## The Layers

### Layer 1 — Gate Your API

**[toll-booth](https://github.com/forgesworn/toll-booth)** wraps any HTTP endpoint with L402 authentication. One line of middleware — supports Express, Hono, Deno, Bun, and Workers. Connects to Phoenixd, LND, CLN, LNbits, or NWC for Lightning invoices.

### Layer 2 — Announce on Nostr

Two paths depending on your setup:

- **toll-booth users:** **[toll-booth-announce](https://github.com/forgesworn/toll-booth-announce)** reads your config and passes it to **[402-announce](https://github.com/forgesworn/402-announce)**, which publishes kind `31402` events to Nostr relays.
- **Aperture users:** **[aperture-announce](https://github.com/forgesworn/aperture-announce)** reads Aperture YAML and publishes the same events. **[aperture-phoenixd](https://github.com/forgesworn/aperture-phoenixd)** lets you use Phoenixd instead of LND.

### Layer 3 — Index & Discover

**[402-indexer](https://github.com/forgesworn/402-indexer)** crawls Nostr for kind `31402` events and builds a searchable index. **[402-pub](https://github.com/forgesworn/402-pub)** is the live directory at [402.pub](https://402.pub).

### Layer 4 — Consume

- **[402-mcp](https://github.com/forgesworn/402-mcp)** — MCP client for AI agents to discover, pay, and consume paid APIs autonomously.
- **[toll-booth-dvm](https://github.com/forgesworn/toll-booth-dvm)** — expose any toll-booth-gated API as a NIP-90 Data Vending Machine on Nostr.

**Back to:** [Ecosystem overview](ecosystem-overview.md)
