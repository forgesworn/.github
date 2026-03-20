# Identity Stack

Spoken verification, deterministic identities, verifiable attestations, and privacy-preserving cryptography.

```mermaid
graph TB
    subgraph primitives["Cryptographic Primitives"]
        rs["ring-sig<br/><i>anonymous group membership</i>"]
        rp["range-proof<br/><i>value-in-range proofs</i>"]
        sw["shamir-words<br/><i>human-readable secret shares</i>"]
    end

    subgraph spoken["Spoken Verification"]
        st["spoken-token<br/><i>rotating speakable codes</i>"]
        ck["canary-kit<br/><i>duress detection, groups, beacons</i>"]
    end

    subgraph identities["Deterministic Identities"]
        nt["nsec-tree<br/><i>sub-identity derivation</i>"]
        ntcli["nsec-tree-cli<br/><i>offline CLI + Shamir recovery</i>"]
    end

    subgraph attestations["Verifiable Attestations"]
        na["nostr-attestations<br/><i>NIP-VA kind 31000</i>"]
    end

    subgraph compliance["Compliance"]
        jk["jurisdiction-kit<br/><i>registries, 30+ countries</i>"]
    end

    %% Core chain
    st --> ck
    nt --> ntcli

    %% Crypto feeds into canary-kit
    rs --> ck
    rp --> ck
    sw --> ck

    %% Attestations
    ck -.->|"identity verification"| na
    jk -.->|"jurisdiction context"| na
    nt -.->|"purpose-specific keys"| na

    classDef primitiveStyle fill:#1a1a2e,stroke:#f5a623,color:#eee
    classDef spokenStyle fill:#1a1a2e,stroke:#16c79a,color:#eee
    classDef identityStyle fill:#1a1a2e,stroke:#0f3460,color:#eee
    classDef attestStyle fill:#1a1a2e,stroke:#e94560,color:#eee
    classDef complianceStyle fill:#1a1a2e,stroke:#9b59b6,color:#eee

    class rs,rp,sw primitiveStyle
    class st,ck spokenStyle
    class nt,ntcli identityStyle
    class na attestStyle
    class jk complianceStyle
```

## Layers

### Spoken Verification

**[spoken-token](https://github.com/forgesworn/spoken-token)** — TOTP, but you say it out loud. Derives time-rotating, human-speakable verification tokens from a shared secret. Zero dependencies.

**[canary-kit](https://github.com/forgesworn/canary-kit)** — builds on spoken-token with the CANARY protocol: per-member spoken words, silent duress detection (say a different word under coercion), encrypted group sync, location beacons, and dead man's switch liveness. Deepfake-proof because the tokens rotate and are never transmitted — you have to be present and alive.

### Deterministic Identities

**[nsec-tree](https://github.com/forgesworn/nsec-tree)** — one master Nostr secret, unlimited derived sub-identities. Each identity is deterministic and unlinkable. Use separate keys for roles, apps, bots, or privacy boundaries without managing separate seeds.

**[nsec-tree-cli](https://github.com/forgesworn/nsec-tree-cli)** — offline-first CLI for nsec-tree. Derive identities, generate proofs of common origin, and recover with Shamir shares.

### Verifiable Attestations

**[nostr-attestations](https://github.com/forgesworn/nostr-attestations)** — NIP-VA (kind 31000). One Nostr event kind for all attestations: credentials, endorsements, vouches, provenance, licensing, trust. Builders, parsers, and validators.

### Cryptographic Primitives

**[ring-sig](https://github.com/forgesworn/ring-sig)** — SAG and LSAG ring signatures on secp256k1. Prove you're in a group without revealing which member you are. LSAG adds linkability for double-spend/double-vote prevention.

**[range-proof](https://github.com/forgesworn/range-proof)** — Pedersen commitment range proofs on secp256k1. Prove a value is within a range without revealing the value. Useful for age verification, balance proofs, and threshold checks.

**[shamir-words](https://github.com/forgesworn/shamir-words)** — split secrets into human-readable BIP-39 word shares using Shamir's Secret Sharing over GF(256). Read your recovery share over the phone.

### Compliance

**[jurisdiction-kit](https://github.com/forgesworn/jurisdiction-kit)** — professional body registries and jurisdiction intelligence for 30+ countries. Feeds into attestations and identity-sensitive flows with compliance, data protection, and mutual recognition context.
