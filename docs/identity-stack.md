# Identity Stack

Spoken verification, deterministic identities, encrypted access control, decentralised identity verification, verifiable attestations, and privacy-preserving cryptography.

## Stack Overview

```mermaid
graph TB
    subgraph layer1["Layer 1 -- Applications"]
        direction LR
        CK["<b>canary-kit</b><br/><i>Duress detection, group sync,<br/>location beacons, dead man's switch</i>"]
        NA["<b>nostr-attestations</b><br/><i>NIP-VA kind 31000<br/>Credentials, endorsements,<br/>vouches, provenance, trust</i>"]
        SG["<b>signet</b><br/><i>4 verification tiers,<br/>ZKP age proofs, Signet Score</i>"]
        DM["<b>dominion</b><br/><i>Epoch-based encrypted<br/>access control, tiered audiences</i>"]
    end

    subgraph layer2["Layer 2 -- Core Protocols"]
        direction LR
        ST["<b>spoken-token</b><br/><i>Time-rotating<br/>speakable codes</i>"]
        NT["<b>nsec-tree</b><br/><i>Deterministic<br/>sub-identities</i>"]
        NTCLI["<b>nsec-tree-cli</b><br/><i>Offline-first CLI<br/>+ Shamir recovery</i>"]
    end

    subgraph layer3["Layer 3 -- Cryptographic Primitives"]
        direction LR
        RS["<b>ring-sig</b><br/><i>SAG / LSAG<br/>Anonymous group proofs</i>"]
        RP["<b>range-proof</b><br/><i>Pedersen commitments<br/>Value-in-range proofs</i>"]
        SC["<b>shamir-core</b><br/><i>GF(256) secret sharing<br/>Core utilities</i>"]
        SW["<b>shamir-words</b><br/><i>BIP-39 word shares<br/>Human-readable recovery</i>"]
    end

    subgraph layer4["Layer 4 -- Compliance"]
        direction LR
        JK["<b>jurisdiction-kit</b><br/><i>Professional registries<br/>28 countries</i>"]
    end

    layer3 --> layer2
    layer2 --> layer1
    layer4 --> layer1

    click CK "https://github.com/forgesworn/canary-kit" _blank
    click NA "https://github.com/forgesworn/nostr-attestations" _blank
    click SG "https://github.com/forgesworn/signet" _blank
    click DM "https://github.com/forgesworn/dominion" _blank
    click ST "https://github.com/forgesworn/spoken-token" _blank
    click NT "https://github.com/forgesworn/nsec-tree" _blank
    click NTCLI "https://github.com/forgesworn/nsec-tree-cli" _blank
    click RS "https://github.com/forgesworn/ring-sig" _blank
    click RP "https://github.com/forgesworn/range-proof" _blank
    click SC "https://github.com/forgesworn/shamir-core" _blank
    click SW "https://github.com/forgesworn/shamir-words" _blank
    click JK "https://github.com/forgesworn/jurisdiction-kit" _blank

    style layer1 fill:#1b3d2d,stroke:#16c79a,color:#eee,stroke-width:2px
    style layer2 fill:#1b2d3d,stroke:#0f3460,color:#eee,stroke-width:2px
    style layer3 fill:#2d2d1b,stroke:#f5a623,color:#eee,stroke-width:2px
    style layer4 fill:#2d1b3d,stroke:#9b59b6,color:#eee,stroke-width:2px
```

## The Layers

### Layer 1 -- Applications

**[canary-kit](https://github.com/forgesworn/canary-kit)** -- the CANARY protocol. Per-member spoken words, silent duress detection (say a different word under coercion), encrypted group sync, location beacons, and dead man's switch liveness. Deepfake-proof because the tokens rotate and are never transmitted -- you have to be present and alive.

**[nostr-attestations](https://github.com/forgesworn/nostr-attestations)** -- NIP-VA (kind 31000). One Nostr event kind for all attestations: credentials, endorsements, vouches, provenance, licensing, trust. Builders, parsers, and validators.

**[signet](https://github.com/forgesworn/signet)** -- decentralised identity verification for Nostr. Four verification tiers (self-declared, peer-vouched, professionally verified, institutionally certified), ZKP age proofs via range-proof, Signet Score (0-200), professional verifier anti-corruption mechanisms, and verifier delegation.

**[dominion](https://github.com/forgesworn/dominion)** -- epoch-based encrypted access control. Your content. Your keys. Your rules. HKDF content keys per tier/epoch, AES-256-GCM encryption, Shamir secret sharing for key recovery, and tiered audiences so you control exactly who can decrypt what.

### Layer 2 -- Core Protocols

**[spoken-token](https://github.com/forgesworn/spoken-token)** -- TOTP, but you say it out loud. Derives time-rotating, human-speakable verification tokens from a shared secret. Zero dependencies. The foundation canary-kit builds on.

**[nsec-tree](https://github.com/forgesworn/nsec-tree)** -- one master Nostr secret, unlimited derived sub-identities. Each identity is deterministic and unlinkable. Use separate keys for roles, apps, bots, or privacy boundaries without managing separate seeds.

**[nsec-tree-cli](https://github.com/forgesworn/nsec-tree-cli)** -- offline-first CLI for nsec-tree. Derive identities, generate proofs of common origin, and recover with Shamir shares.

### Layer 3 -- Cryptographic Primitives

**[ring-sig](https://github.com/forgesworn/ring-sig)** -- SAG and LSAG ring signatures on secp256k1. Prove you're in a group without revealing which member you are. LSAG adds linkability for double-spend/double-vote prevention.

**[range-proof](https://github.com/forgesworn/range-proof)** -- Pedersen commitment range proofs on secp256k1. Prove a value is within a range without revealing it. Age verification, balance proofs, threshold checks.

**[shamir-core](https://github.com/forgesworn/shamir-core)** -- Shamir's Secret Sharing over GF(256) with core splitting, combining, and verification utilities. The backend for shamir-words.

**[shamir-words](https://github.com/forgesworn/shamir-words)** -- split secrets into human-readable BIP-39 word shares using Shamir's Secret Sharing. Read your recovery share over the phone. Built on shamir-core.

### Layer 4 -- Compliance

**[jurisdiction-kit](https://github.com/forgesworn/jurisdiction-kit)** -- professional body registries and jurisdiction intelligence for 28 countries. Feeds into attestations and identity-sensitive flows with compliance, data protection, and mutual recognition context.

**Back to:** [Ecosystem overview](ecosystem-overview.md)
