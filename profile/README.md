# ForgeSworn

Open-source building blocks for sovereign commerce, identity, and trust.

- Machine-payable APIs and Lightning payment gating
- Deterministic Nostr identities and encrypted access control
- Privacy-preserving trust and anonymous reputation
- Spoken verification, anti-deepfake, and coercion resistance
- Fair meeting points and spatial coordination
- Coercion-resistant location sharing and phone-to-phone offline mesh
- AI agent tooling for sovereign Nostr interaction
- Cryptographic primitives: ring signatures, range proofs, Shamir secret sharing
- Nostr protocol extensions and conformance testing
- Build infrastructure: reproducible, hardened npm publishing

Built on Nostr, Lightning, and zero-trust cryptography. Every repo works standalone or as a composable part of the ecosystem.

<img src="../docs/forgesworn-architecture.svg" alt="ForgeSworn Ecosystem - hexagonal architecture diagram showing crypto core, identity, agents, L402 payments, trust, compliance, and spatial categories" width="100%"/>

**Visual guides:** [Ecosystem overview](../docs/ecosystem-overview.md) | [L402 pipeline](../docs/l402-pipeline.md) | [Identity stack](../docs/identity-stack.md)

## Start Here

- **[toll-booth](https://github.com/forgesworn/toll-booth)**: Gate any HTTP API behind Lightning payments.
  Add **[toll-booth-announce](https://github.com/forgesworn/toll-booth-announce)**, **[402-announce](https://github.com/forgesworn/402-announce)**, **[402-indexer](https://github.com/forgesworn/402-indexer)**, and **[402-pub](https://github.com/forgesworn/402-pub)** for discovery. Add **[toll-booth-mcp](https://github.com/forgesworn/toll-booth-mcp)** for analytics and **[toll-booth-dvm](https://github.com/forgesworn/toll-booth-dvm)** for NIP-90 exposure. Use **[toll-booth-rs](https://github.com/forgesworn/toll-booth-rs)** for Rust.
- **[402-mcp](https://github.com/forgesworn/402-mcp)**: Let AI agents discover, pay for, and consume paid APIs.
  Pair with **[toll-booth](https://github.com/forgesworn/toll-booth)** and **[402-pub](https://github.com/forgesworn/402-pub)**.
- **[bray](https://github.com/forgesworn/bray)**: Give AI agents a sovereign Nostr identity.
  251 tools across 27 groups covering identity, social, payments, dispatch, trust, moderation, privacy, spells, and encrypted access. Built on **[nsec-tree](https://github.com/forgesworn/nsec-tree)** for identity derivation and **[dominion](https://github.com/forgesworn/dominion)** for encrypted access.
- **[nostr-veil](https://github.com/forgesworn/nostr-veil)**: Privacy-preserving Web of Trust.
  Anonymous trust assertions using LSAG ring signatures over NIP-85. Built on **[ring-sig](https://github.com/forgesworn/ring-sig)**.
- **[rendezvous-kit](https://github.com/forgesworn/rendezvous-kit)**: Build fair meeting-point or spatial apps.
  Add **[geohash-kit](https://github.com/forgesworn/geohash-kit)** and **[rendezvous-mcp](https://github.com/forgesworn/rendezvous-mcp)**.
- **[flock](https://github.com/forgesworn/flock)**: A coercion-resistant friend-finder that walks you the last half-mile to a moving friend by ear — location end-to-end encrypted over Nostr, and a decoy unlock if the phone is taken.
  Built on **[flock-kit](https://github.com/forgesworn/flock-kit)**, **[covey-kit](https://github.com/forgesworn/covey-kit)**, **[roost-kit](https://github.com/forgesworn/roost-kit)**, **[keystore-kit](https://github.com/forgesworn/keystore-kit)**, and an offline **[mesh-kit](https://github.com/forgesworn/mesh-kit)** / **[capacitor-mesh-ble](https://github.com/forgesworn/capacitor-mesh-ble)** stack.
- **[spoken-token](https://github.com/forgesworn/spoken-token)**: Add human-speakable rotating verification codes.
  Pair with **[canary-kit](https://github.com/forgesworn/canary-kit)**.
- **[nsec-tree](https://github.com/forgesworn/nsec-tree)**: Derive deterministic, unlinkable Nostr sub-identities from one master secret.
  Use it when one seed needs separate identities for roles, apps, bots, or privacy boundaries. Add **[nsec-tree-cli](https://github.com/forgesworn/nsec-tree-cli)** for an offline-first CLI. Used by **[bray](https://github.com/forgesworn/bray)**, **[heartwood](https://github.com/forgesworn/heartwood)**, and **[signet](https://github.com/forgesworn/signet)**.
- **[heartwood](https://github.com/forgesworn/heartwood)**: Keyless NIP-46 bridge for hardware Nostr signers.
  Connects Nostr relays to a USB-tethered **[heartwood-esp32](https://github.com/forgesworn/heartwood-esp32)** token or **[heartwood-ledger](https://github.com/forgesworn/heartwood-ledger)** app — the bridge holds no seed, no PIN, no plaintext; every operation happens on the device. Per-client kind permissions enforced on-device, unlimited unlinkable personas from one mnemonic via **[nsec-tree](https://github.com/forgesworn/nsec-tree)**. `Rust`
- **[bark](https://github.com/forgesworn/bark)**: NIP-07 Nostr signer backed by NIP-46 remote signing.
  Self-sovereign keys, derived personas with **[heartwood](https://github.com/forgesworn/heartwood)**.
- **[canary-kit](https://github.com/forgesworn/canary-kit)**: Build spoken verification, duress detection, or privacy-preserving identity flows.
  Add **[ring-sig](https://github.com/forgesworn/ring-sig)**, **[range-proof](https://github.com/forgesworn/range-proof)**, and **[shamir-words](https://github.com/forgesworn/shamir-words)**.
- **[signet](https://github.com/forgesworn/signet)**: Decentralised identity verification for Nostr.
  4 verification tiers, ZKP age proofs, Signet Score (0-200). Built on **[nostr-attestations](https://github.com/forgesworn/nostr-attestations)** and **[range-proof](https://github.com/forgesworn/range-proof)**. Drop it into a website with **[signet-verify](https://github.com/forgesworn/signet-verify)** (one script tag, one function call).
- **[dominion](https://github.com/forgesworn/dominion)**: Encrypted access control with epoch-based key rotation.
  Tiered audiences, HKDF content keys, Shamir secret sharing. Used by **[bray](https://github.com/forgesworn/bray)**.
- **[nostr-attestations](https://github.com/forgesworn/nostr-attestations)**: One Nostr event kind for all attestations (NIP-VA, kind 31000).
  Credentials, endorsements, vouches, provenance, licensing, and trust.
- **[jurisdiction-kit](https://github.com/forgesworn/jurisdiction-kit)**: Work with jurisdiction and professional-registry data.
  Pair with **[canary-kit](https://github.com/forgesworn/canary-kit)** or **[signet](https://github.com/forgesworn/signet)** for identity-sensitive flows.
- **[nip-drafts](https://github.com/forgesworn/nip-drafts)**: 36 Nostr protocol extensions covering service coordination, trust, payments, disputes, key hierarchy, resource curation, and encrypted access. Classified as upstream, ecosystem, or incubating.
- **[anvil](https://github.com/forgesworn/anvil)**: Ship JS/TS libraries with reproducible, hardened npm releases.
  Multi-runner byte-identical build attestation, OIDC trusted publishing, SLSA provenance, secret scanning, exports-map checks. Pure bash, auditable in under thirty minutes. Used by 24+ repos in this org.

## Common Flows

- `toll-booth -> toll-booth-announce -> 402-announce -> 402-indexer -> 402-pub -> 402-mcp`: Gate an API, announce it on Nostr, index it, publish a directory, let AI agents consume it.
- `toll-booth -> toll-booth-mcp`: Monitor a toll-booth with analytics dashboards and widget UIs.
- `geohash-kit -> rendezvous-kit -> rendezvous-mcp`: Encode spatial data, compute fair meeting points, expose to AI agents.
- `nsec-tree -> heartwood-esp32 -> heartwood -> bark`: Keys on a hardware token, relayed by the keyless bridge via NIP-46 over Nostr relays, used from the browser via NIP-07.
- `nsec-tree -> heartwood-esp32 -> sapwood`: Microcontroller signing token on ESP32-S3, configured via a web management UI.
- `nsec-tree -> heartwood-ledger -> heartwood`: The same signer running as a Ledger embedded app, keys in the secure element (emulator-proven).
- `heartwood -> cambium`: Android NIP-55 signing with no keys on the phone — every request proxied to the hardware signer.
- `nsec-tree -> bray -> dominion`: Derive sub-identities, give them to an AI agent, gate content access by tier and epoch.
- `nsec-tree -> spoken-token / canary-kit`: Derive purpose-specific Nostr identities, attach spoken verification or higher-trust identity flows.
- `ring-sig -> nostr-veil`: Anonymous trust assertions -- prove group membership without revealing who endorsed.
- `nostr-attestations -> signet -> signet-verify`: Protocol plus drop-in SDK so any website can age-gate or identity-gate in one script tag.
- `nostr-attestations -> signet -> canary-kit / jurisdiction-kit`: Issue verifiable attestations, verify identities with tiers and ZKP age proofs, add jurisdiction context.
- `spoken-token -> canary-kit -> ring-sig / range-proof / shamir-words`: Spoken verification, privacy-preserving proofs, human-recoverable secret handling.
- `shamir-core -> shamir-words -> nsec-tree-cli`: Core secret sharing, BIP-39 word output, offline identity recovery.
- `covey-kit -> roost-kit -> flock-kit`: Build an encrypted circle, deliver each member's position as a NIP-59 gift wrap, and guide people to each other by sound and vibration.
- `mesh-kit -> mesh-nostr-kit / capacitor-mesh-ble`: Run an authenticated, encrypted, in-order channel over any transport — a Bluetooth mesh between phones, a Nostr relay, or both bridged so someone out of range still hears it.

## L402 / Machine Payments

Make APIs payable, discoverable, and consumable by people and agents.

Start with **[toll-booth](https://github.com/forgesworn/toll-booth)** to put a Lightning paywall in front of an API. Add announcement and indexing repos for discovery, then **[402-mcp](https://github.com/forgesworn/402-mcp)** when the client is an AI agent.

| Repository | What it does |
|:-----------|:-------------|
| **[toll-booth](https://github.com/forgesworn/toll-booth)** | Any API becomes a Lightning toll booth in one line. L402 middleware for Express, Hono, Deno, Bun, and Workers. |
| **[toll-booth-rs](https://github.com/forgesworn/toll-booth-rs)** | L402 payment middleware for Rust. Gates any HTTP API behind Lightning payments. `Rust` |
| **[402-announce](https://github.com/forgesworn/402-announce)** | Announce HTTP 402 services on Nostr for decentralised discovery using kind `31402` parameterised replaceable events. |
| **[402-mcp](https://github.com/forgesworn/402-mcp)** | MCP client for AI agents to discover, pay for, and consume L402 and x402 APIs. |
| **[402-pub](https://github.com/forgesworn/402-pub)** | [402.pub](https://402.pub) ecosystem landing page and live directory for Lightning-paid APIs. |
| **[toll-booth-announce](https://github.com/forgesworn/toll-booth-announce)** | Bridge between `toll-booth` and `402-announce` so a toll-booth service can be announced on Nostr. |
| **[toll-booth-dvm](https://github.com/forgesworn/toll-booth-dvm)** | Expose any toll-booth-gated API as a NIP-90 Data Vending Machine on Nostr. |
| **[toll-booth-mcp](https://github.com/forgesworn/toll-booth-mcp)** | MCP server with read-only analytics and widget UIs for toll-booth deployments. |
| **[402-indexer](https://github.com/forgesworn/402-indexer)** | Nostr-native crawler that discovers L402 and x402 paid APIs and publishes kind `31402` events. |
| **[payment-methods](https://github.com/forgesworn/payment-methods)** | Specifications for HTTP Payment Authentication methods (Lightning, Cashu, Session). |
| **[aperture-phoenixd](https://github.com/forgesworn/aperture-phoenixd)** | Use Phoenixd as the Lightning backend for Aperture, with no LND required. `Go` |
| **[aperture-announce](https://github.com/forgesworn/aperture-announce)** | Announce Aperture L402 services on Nostr for decentralised discovery. `Go` |

## Spatial / Meeting

Build location-aware workflows and fair meeting-point tools.

Start with **[rendezvous-kit](https://github.com/forgesworn/rendezvous-kit)** for meeting-point logic. Use **[geohash-kit](https://github.com/forgesworn/geohash-kit)** for geospatial primitives and Nostr location filters. Use **[rendezvous-mcp](https://github.com/forgesworn/rendezvous-mcp)** when you want that flow exposed to agents.

| Repository | What it does |
|:-----------|:-------------|
| **[geohash-kit](https://github.com/forgesworn/geohash-kit)** | Zero-dependency geohash toolkit for encoding, decoding, polygon coverage, and Nostr location filters. |
| **[rendezvous-kit](https://github.com/forgesworn/rendezvous-kit)** | Find fair meeting points for `N` participants with isochrone intersection, venue search, and fairness scoring. |
| **[rendezvous-mcp](https://github.com/forgesworn/rendezvous-mcp)** | MCP server for AI-driven fair meeting-point discovery. |

## Safety, Location & Offline Mesh

Coordinate and stay safe on open protocols, with location that belongs to the person it describes — and keeps working when the network doesn't.

**flock stack** — **[flock](https://github.com/forgesworn/flock)** is the app: a coercion-resistant friend-finder that guides you the last half-mile to a moving friend by voice, sound, and vibration, with the phone still in your pocket. Location is end-to-end encrypted over Nostr, shared only as precisely and as briefly as its owner chooses, held by no server — and a compelled unlock opens a decoy, not the real thing. Under it: **[flock-kit](https://github.com/forgesworn/flock-kit)** is the pure guidance-and-safety core, **[covey-kit](https://github.com/forgesworn/covey-kit)** holds the encrypted circles, **[roost-kit](https://github.com/forgesworn/roost-kit)** moves everything as NIP-59 gift wraps, **[keystore-kit](https://github.com/forgesworn/keystore-kit)** guards the on-device key — and when the signal drops, **[mesh-kit](https://github.com/forgesworn/mesh-kit)**, **[mesh-nostr-kit](https://github.com/forgesworn/mesh-nostr-kit)**, and **[capacitor-mesh-ble](https://github.com/forgesworn/capacitor-mesh-ble)** carry the same encrypted frames phone-to-phone over a Bluetooth mesh.

| Repository | What it does |
|:-----------|:-------------|
| **[flock](https://github.com/forgesworn/flock)** | Coercion-resistant friend-finder. Guides you to a moving friend by ear and vibration; location end-to-end encrypted over Nostr, shared at the precision and for the time you choose; a decoy unlock under duress. |
| **[flock-kit](https://github.com/forgesworn/flock-kit)** | Framework-free guidance and location-safety core: radar state machine, heading engine, honest degradation, precision tiers, and consented live-session rules. |
| **[covey-kit](https://github.com/forgesworn/covey-kit)** | Private circles for Nostr: derived per-circle keys, roles, word-code invites, personal inboxes, and convergent membership state. |
| **[roost-kit](https://github.com/forgesworn/roost-kit)** | Nostr transport for private circles: NIP-59 gift wraps, relay fan-out, rotating inboxes, and a pre-signed offline outbox. |
| **[keystore-kit](https://github.com/forgesworn/keystore-kit)** | Browser key-at-rest. Protect one secret behind a PIN, a WebAuthn-PRF biometric, or a grace window; pluggable storage and an irreversible burn. Zero runtime dependencies. |
| **[mesh-kit](https://github.com/forgesworn/mesh-kit)** | Transport-agnostic encrypted offline-mesh substrate. A Noise_XX secure channel, store-and-forward reliability, and deterministic sims — carries opaque frames without knowing the application. |
| **[mesh-nostr-kit](https://github.com/forgesworn/mesh-nostr-kit)** | Nostr relay transport for opaque mesh-kit frames, so a mesh reaches anyone still holding a relay path. |
| **[capacitor-mesh-ble](https://github.com/forgesworn/capacitor-mesh-ble)** | Bluetooth LE mesh transport for Capacitor apps: discovery, GATT links, chunking, dedup, and multi-hop relay — phone-to-phone with no network. |

## Identity Primitives

Composable libraries for deterministic identity derivation, spoken verification, and encrypted access control.

Start with **[nsec-tree](https://github.com/forgesworn/nsec-tree)** for deterministic unlinkable Nostr identities, **[spoken-token](https://github.com/forgesworn/spoken-token)** for human-speakable rotating codes, **[dominion](https://github.com/forgesworn/dominion)** for tiered encrypted access, or **[canary-kit](https://github.com/forgesworn/canary-kit)** for full spoken-verification flows with duress detection and group sync.

| Repository | What it does |
|:-----------|:-------------|
| **[nsec-tree](https://github.com/forgesworn/nsec-tree)** | Deterministic Nostr sub-identity derivation. One master secret, unlimited unlinkable identities. |
| **[nsec-tree-cli](https://github.com/forgesworn/nsec-tree-cli)** | Offline-first CLI for nsec-tree with derivation, proofs, and Shamir recovery. |
| **[nsec-tree-py](https://github.com/forgesworn/nsec-tree-py)** | Python port of nsec-tree. Conformant deterministic sub-identity derivation, interop-tested against the TypeScript implementation. `Python` |
| **[spoken-token](https://github.com/forgesworn/spoken-token)** | TOTP, but you say it out loud. Derive time-rotating, human-speakable verification tokens from a shared secret. |
| **[canary-kit](https://github.com/forgesworn/canary-kit)** | Deepfake-proof identity verification with per-member spoken words, silent duress detection, encrypted group sync, and an open protocol. |
| **[dominion](https://github.com/forgesworn/dominion)** | Epoch-based encrypted access control. Your content. Your keys. Your rules. HKDF content keys per tier/epoch, AES-256-GCM, Shamir secret sharing, tiered audiences. |

## Signers and Identity Apps

Running signers, hardware variants, and decentralised-identity applications built on the primitives above.

**Signer stack** -- the keys live on a hardware signer (**[heartwood-esp32](https://github.com/forgesworn/heartwood-esp32)** token or **[heartwood-ledger](https://github.com/forgesworn/heartwood-ledger)** secure-element app), **[heartwood](https://github.com/forgesworn/heartwood)** is the keyless bridge that connects the device to Nostr relays, **[bark](https://github.com/forgesworn/bark)** (browser, NIP-07) and **[cambium](https://github.com/forgesworn/cambium)** (Android, NIP-55) are the clients that sign through it, and **[sapwood](https://github.com/forgesworn/sapwood)** is the web management UI.

**Signet stack** -- **[signet](https://github.com/forgesworn/signet)** is the verification protocol, [My Signet](https://mysignet.app) is the user app, and **[signet-verify](https://github.com/forgesworn/signet-verify)** is the drop-in SDK for any website.

| Repository | What it does |
|:-----------|:-------------|
| **[heartwood](https://github.com/forgesworn/heartwood)** | Keyless NIP-46 bridge for hardware Nostr signers. Relay-mediated (no open ports), per-client permissions enforced on-device, unlimited unlinkable personas via nsec-tree. `Rust` |
| **[heartwood-esp32](https://github.com/forgesworn/heartwood-esp32)** | nsec-tree signing token for Heltec WiFi LoRa 32 V3/V4 (ESP32-S3). On-device button approval, up to 8 master identities. `Rust` |
| **[heartwood-ledger](https://github.com/forgesworn/heartwood-ledger)** | Heartwood signer as a Ledger embedded app — NIP-46, NIP-44, and nsec-tree personas on the secure element. Emulator-proven prototype. `Rust` |
| **[bark](https://github.com/forgesworn/bark)** | NIP-07 Nostr signer backed by NIP-46 remote signing. No user keys stored; derived personas with Heartwood. |
| **[cambium](https://github.com/forgesworn/cambium)** | Android NIP-55 signer that holds no keys — every request proxied to a Heartwood hardware signer over NIP-46. `Kotlin` |
| **[sapwood](https://github.com/forgesworn/sapwood)** | Web management UI for the Heartwood ESP32 signer. |
| **[signet](https://github.com/forgesworn/signet)** | Decentralised identity verification for Nostr. 4 verification tiers, ZKP age proofs, Signet Score (0-200), professional verifier anti-corruption, verifier delegation. |
| **[signet-verify](https://github.com/forgesworn/signet-verify)** | Drop-in age verification SDK for websites. One script tag, one function call. |

## AI Agents

Give AI agents sovereign Nostr identities with trust-aware tooling.

| Repository | What it does |
|:-----------|:-------------|
| **[bray](https://github.com/forgesworn/bray)** | Trust-aware Nostr MCP for AI and humans. 251 tools across 27 groups: identity, social, trust, dispatch, relay, marketplace, safety, privacy, and encrypted access. NIP-A7 Spell casting. Three trust dimensions: Verification (Signet), Proximity (WoT), and Access (Dominion). |

## Trust / Privacy

Privacy-preserving trust and verifiable attestations.

| Repository | What it does |
|:-----------|:-------------|
| **[nostr-veil](https://github.com/forgesworn/nostr-veil)** | Anonymous trust assertions for Nostr. LSAG ring signatures over NIP-85 so endorsements are verifiable but contributors are unidentifiable. Solves the Trust Trilemma. |
| **[nostr-attestations](https://github.com/forgesworn/nostr-attestations)** | One Nostr event kind for all attestations -- credentials, endorsements, vouches, provenance, licensing, and trust. NIP-VA (kind 31000). |

## Cryptographic Primitives

Standalone cryptographic building blocks used across the ecosystem.

| Repository | What it does |
|:-----------|:-------------|
| **[ring-sig](https://github.com/forgesworn/ring-sig)** | SAG and LSAG ring signatures on secp256k1 for proving group membership without revealing identity. |
| **[range-proof](https://github.com/forgesworn/range-proof)** | Pedersen commitment range proofs on secp256k1 for proving a value is in range without revealing it. |
| **[private-equality](https://github.com/forgesworn/private-equality)** | Socialist Millionaires' Protocol over Ristretto255 for deciding whether two parties hold the same secret, revealing only one bit. |
| **[shamir-core](https://github.com/forgesworn/shamir-core)** | Shamir's Secret Sharing over GF(256) with core utilities. Backend for shamir-words. |
| **[shamir-words](https://github.com/forgesworn/shamir-words)** | Split secrets into human-readable BIP-39 word shares using Shamir's Secret Sharing. Built on shamir-core. |

## Compliance

Work with jurisdiction and professional-registry intelligence for regulated or identity-sensitive flows.

| Repository | What it does |
|:-----------|:-------------|
| **[jurisdiction-kit](https://github.com/forgesworn/jurisdiction-kit)** | Professional body registries and jurisdiction intelligence for 28 countries, including compliance, data protection, and mutual recognition contexts. |

## Protocol / Standards

Nostr protocol extensions and conformance testing.

| Repository | What it does |
|:-----------|:-------------|
| **[nip-drafts](https://github.com/forgesworn/nip-drafts)** | 36 Nostr protocol extensions: service coordination, trust, payments, disputes, key hierarchy, resource curation, paid APIs, and encrypted access. Classified as upstream, ecosystem, or incubating. Each NIP is independent. |
| **[trott-conformance](https://github.com/forgesworn/trott-conformance)** | Protocol conformance test suite. Lifecycle fixtures for TROTT task kinds. |

## Tooling / Build Infrastructure

Infrastructure that underpins how the other repos are built and published.

| Repository | What it does |
|:-----------|:-------------|
| **[anvil](https://github.com/forgesworn/anvil)** | Hardened npm publishing GitHub Action. Multi-runner byte-identical build attestation, OIDC trusted publishing, SLSA provenance, secret scanning, exports-map checks, frozen-vector gates. Pure bash, auditable in under thirty minutes. Used by 24+ repos in this org. |
