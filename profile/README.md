# Forgesworn

Open-source building blocks for sovereign commerce, spatial coordination, and identity verification — built on Nostr, Lightning, and zero-trust cryptography.

---

## L402 / Machine Payments

Everything an API needs to get paid — middleware, discovery, directories, and AI agent clients.

| Repository | Description |
|:-----------|:------------|
| **[toll-booth](https://github.com/forgesworn/toll-booth)** | Any API becomes a Lightning toll booth in one line. L402 middleware for Express, Hono, Deno, Bun, and Workers. |
| **[402-announce](https://github.com/forgesworn/402-announce)** | Announce HTTP 402 services on Nostr for decentralised discovery (kind 31402). |
| **[402-mcp](https://github.com/forgesworn/402-mcp)** | MCP server — AI agents discover, pay for, and consume L402 + x402 APIs. |
| **[402-pub](https://github.com/forgesworn/402-pub)** | [402.pub](https://402.pub) — live service directory for Lightning-paid APIs. |
| **[toll-booth-announce](https://github.com/forgesworn/toll-booth-announce)** | Bridge between toll-booth and 402-announce — announce your services on Nostr. |
| **[402-indexer](https://github.com/forgesworn/402-indexer)** | Nostr-native crawler that discovers L402 and x402 paid APIs and publishes kind 31402 events. |
| **[aperture-phoenixd](https://github.com/forgesworn/aperture-phoenixd)** | Use Phoenixd as the Lightning backend for Aperture — no LND required. `Go` |
| **[aperture-announce](https://github.com/forgesworn/aperture-announce)** | Announce Aperture L402 services on Nostr for decentralised discovery. `Go` |

## Spatial / Meeting

Fair meeting points and geospatial primitives — isochrones, venue search, geohash coverage.

| Repository | Description |
|:-----------|:------------|
| **[geohash-kit](https://github.com/forgesworn/geohash-kit)** | Zero-dependency geohash toolkit — encode, decode, cover polygons, and build Nostr location filters. |
| **[rendezvous-kit](https://github.com/forgesworn/rendezvous-kit)** | Find fair meeting points for N participants — isochrone intersection, venue search, fairness scoring. |
| **[rendezvous-mcp](https://github.com/forgesworn/rendezvous-mcp)** | MCP server for AI-driven fair meeting point discovery. |

## Identity / Verification

Spoken-word verification, deepfake-resistant protocols, and zero-knowledge primitives.

| Repository | Description |
|:-----------|:------------|
| **[spoken-token](https://github.com/forgesworn/spoken-token)** | TOTP but you say it out loud. Derive time-rotating, human-speakable verification tokens from a shared secret. |
| **[canary-kit](https://github.com/forgesworn/canary-kit)** | Deepfake-proof identity verification. Per-member spoken words, silent duress detection, encrypted group sync. |
| **[ring-sig](https://github.com/forgesworn/ring-sig)** | SAG and LSAG ring signatures on secp256k1 — prove group membership without revealing identity. |
| **[range-proof](https://github.com/forgesworn/range-proof)** | Pedersen commitment range proofs on secp256k1 — prove a value is in range without revealing it. |
| **[shamir-words](https://github.com/forgesworn/shamir-words)** | Split secrets into human-readable BIP-39 word shares using Shamir's Secret Sharing over GF(256). |

## Compliance

| Repository | Description |
|:-----------|:------------|
| **[jurisdiction-kit](https://github.com/forgesworn/jurisdiction-kit)** | Professional body registries and jurisdiction intelligence for 30+ countries. |
