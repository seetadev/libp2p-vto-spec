### VTO: Verified Telemetry Objects

### VTO (Verified Telemetry Object) using libp2p, CBOR, Unix-FS and IPFS

**Status:** 🧪 Draft integration materials

This repository explores **Verified Telemetry Objects (VTOs)** as small, deterministic, content-addressed objects for representing telemetry and machine-generated evidence in peer-to-peer and distributed systems.

The initial implementation and integration work uses **libp2p**, **deterministic CBOR**, **Unix-FS**, **multihash/CIDs**, and **IPFS** as an experimentation environment.

The goal is to make telemetry and evidence:

* **Deterministic** — the same logical object can produce the same canonical bytes.
* **Verifiable** — cryptographic digests can identify the exact encoded object.
* **Content-addressed** — objects can be represented using multihashes and CIDs.
* **Peer-to-peer** — evidence can be generated and exchanged between independently operated peers.
* **Composable** — individual evidence objects can become inputs to higher-level trust, policy, observability, and agent systems.
* **Interoperable** — implementations in different languages should be able to independently produce and verify the same representation.

> **Important:** This repository contains experimental specifications and integration materials. The VTO schema, encoding profile, digest context, measurement semantics, AAC binding, and interoperability requirements are subject to change.

---

## Why VTO?

Distributed systems increasingly need to exchange evidence about the state and behavior of peers, services, networks, and agents.

Examples include:

* Network latency and throughput
* Peer availability
* Transport and protocol observations
* Resource utilization
* Service-level measurements
* Agent-to-agent telemetry
* Distributed observability
* Routing and peer-selection evidence
* Security and infrastructure diagnostics
* Evidence used by policy or trust systems

A VTO provides a compact representation of such information that can be **deterministically encoded, cryptographically identified, exchanged between peers, and stored or distributed using content-addressed systems**.

The VTO itself is intended to be an **evidence primitive**, rather than a complete trust decision.

A higher-level system can consume multiple VTOs and other evidence objects to construct its own policy, reputation, trust, routing, or operational decisions.

---

## Design Overview

The initial architecture separates telemetry semantics from encoding and cryptographic identification:

```text
┌──────────────────────────────────────────────┐
│              Application / System            │
│                                              │
│   libp2p • agents • distributed systems      │
└───────────────────────┬──────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────┐
│       Verified Telemetry Object (VTO)         │
│                                              │
│ Measurements • Producer • Network • Metadata │
└───────────────────────┬──────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────┐
│          Deterministic CBOR Encoding         │
└───────────────────────┬──────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────┐
│              Digest Context                  │
│                                              │
│          SHA-256 • Multihash • CID           │
└───────────────────────┬──────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────┐
│       Verifiable / Content-Addressed         │
│                  Evidence                    │
└──────────────────────────────────────────────┘
```

The important boundary is:

> **VTO defines the semantics of the telemetry; the digest context defines how the encoded representation becomes cryptographically identifiable.**

This separation allows the encoding and digest mechanisms to potentially be reused by other evidence and telemetry formats without coupling them to VTO-specific semantics.

---

# VTO Data Model

A VTO is a structured representation of telemetry produced by a peer, node, service, agent, or other measurement-producing system.

The current working model contains:

```text
VTO
├── version
├── id
├── timestamp
├── producer
│   ├── peer_id
│   ├── implementation
│   └── version
├── measurements
│   ├── latency_ms
│   ├── throughput_mbps
│   ├── bandwidth_mbps
│   ├── packet_loss_pct
│   ├── cpu_utilization_pct
│   ├── memory_utilization_pct
│   ├── peer_count
│   ├── active_streams
│   └── uptime_seconds
├── network
│   ├── protocol
│   ├── transport
│   └── region
└── metadata
    ├── tags
    └── notes
```

The current CDDL is intentionally small and implementation-friendly. It is a **working draft** and may change as implementation and interoperability testing progresses.

---

# Canonical Encoding

The initial VTO profile uses **deterministic CBOR** as its canonical serialization.

The intended pipeline is:

```text
VTO
 │
 ▼
Deterministic CBOR
 │
 ▼
SHA-256
 │
 ▼
Multihash
 │
 ▼
CID
```

This provides a deterministic byte representation suitable for cryptographic hashing and content addressing.

Implementations should generate the canonical bytes directly rather than relying on a human-readable JSON representation.

JSON may be useful for debugging and diagnostics, but it is **not the canonical representation used for hashing or content addressing**.

---

# Digest and Content Addressing

The current draft uses **SHA-256** as the initial digest algorithm.

Conceptually:

```text
digest = SHA-256(deterministic_cbor(vto))
```

The resulting digest can be represented as a multihash and mapped to a CID.

The digest context is intended to remain reusable independently of VTO semantics.

For example:

```text
Other Evidence Object
        │
        ▼
Deterministic CBOR
        │
        ▼
Digest Context
        │
        ▼
Multihash
        │
        ▼
CID
```

This makes the digest-context layer potentially useful for other CBOR-based telemetry and evidence formats.

---

# Unix-FS and IPFS

VTOs are designed to work naturally with content-addressed storage and peer-to-peer distribution.

A conceptual flow is:

```text
Telemetry
   │
   ▼
VTO
   │
   ▼
Deterministic CBOR
   │
   ▼
Digest / Multihash
   │
   ▼
CID
   │
   ├──────────────► Unix-FS
   │
   └──────────────► IPFS
                         │
                         ▼
                    Peer-to-peer
                    distribution
```

This enables a VTO to be identified independently of where it is stored or retrieved.

IPFS can provide a content-addressed distribution layer, while libp2p provides the peer-to-peer networking environment in which telemetry can be generated and exchanged.

The specification itself is intended to remain broader than any single implementation or storage system.

---

# Relationship to libp2p

libp2p provides the initial implementation and experimentation environment for VTO.

The current examples use libp2p concepts including:

* Peer IDs
* GossipSub
* QUIC
* Peer counts
* Active streams
* Network and transport context

However, VTO is **not intended to be exclusively libp2p-specific**.

The format is intended to remain useful for:

* Other peer-to-peer networks
* Distributed systems
* Agent networks
* Infrastructure platforms
* Observability systems

libp2p therefore provides an important practical environment for developing and testing the specification while keeping the underlying evidence model reusable.

---

# Producer Identity

The current producer structure includes:

```text
producer:
  peer_id
  implementation
  version
```

For peer-to-peer systems, `peer_id` provides an association between the telemetry and the producing peer.

However:

> **A producer identifier alone does not establish authenticity.**

The current VTO work intentionally separates content integrity from authenticity.

Future profiles may explore:

* VTO signatures
* Binding telemetry to cryptographic peer identities
* Measurement attestation
* Provenance
* Trusted execution environments
* Verification of measurement environments

These are higher-level mechanisms and are not implied merely by the presence of a Peer ID or CID.

---

# Integrity vs. Authenticity

An important design principle is to distinguish **integrity** from **authenticity**.

A digest provides a stable identifier for the exact encoded object:

```text
VTO
 │
 ▼
Deterministic CBOR
 │
 ▼
SHA-256
 │
 ▼
Multihash / CID
```

This allows a verifier to determine whether the referenced bytes correspond to the expected object.

A digest by itself does **not** establish:

* Who produced the object
* Whether the producer is trusted
* Whether the measurement is accurate
* Whether the measurement environment is trustworthy
* Whether the producer intentionally reported false information

These concerns belong to higher-level authenticity, provenance, attestation, policy, and trust profiles.

---

# VTO and Composable Trust

VTOs are intended to be **primitive evidence objects**, not complete trust decisions.

A higher-level system can compose multiple independently verifiable objects:

```text
        ┌─────────────┐
        │    VTO #1   │
        └──────┬──────┘
               │
        ┌──────▼──────┐
        │    VTO #2   │
        └──────┬──────┘
               │
        ┌──────▼──────┐
        │    VTO #3   │
        └──────┬──────┘
               │
               ▼
      ┌───────────────────┐
      │ Evidence / Trust  │
      │      Policy       │
      └─────────┬─────────┘
                │
                ▼
      ┌───────────────────┐
      │ Decision / Action  │
      └───────────────────┘
```

This creates a foundation for systems that build trust from multiple sources of independently verifiable evidence rather than relying on a single centralized authority.

Potential applications include:

* P2P network observability
* Network performance assessment
* Agent-to-agent coordination
* Distributed reputation
* Service-level evidence
* Routing and peer selection
* Security monitoring
* Infrastructure diagnostics
* Decentralized agent systems

---

# AAC Integration

This repository also contains materials exploring the relationship between VTOs and **AAC**.

The intended direction is to investigate how VTOs can act as structured, verifiable evidence within an agent communication and trust architecture.

Potential areas of exploration include:

```text
AAC
 │
 ├── Identity / Peer Association
 │
 ├── Evidence
 │      │
 │      └── VTO
 │
 ├── Policy
 │
 ├── Provenance
 │
 └── Trust / Verification
```

The exact AAC binding model remains a review item and should not be treated as finalized by the current repository.

---

# Float Handling

The current working profile uses **IEEE-754 binary64 floating-point values** for measurement fields such as:

* `latency_ms`
* `throughput_mbps`
* `bandwidth_mbps`
* `packet_loss_pct`
* `cpu_utilization_pct`
* `memory_utilization_pct`

The profile currently requires:

* IEEE-754 binary64 encoding
* Native floating-point representation in CBOR
* No conversion to decimal strings
* Deterministic CBOR encoding
* Digest computation directly over canonical CBOR bytes
* No JSON canonicalization step

The treatment of exceptional floating-point values, including NaN, infinities, and signed zero, remains an area requiring explicit specification.

---

# Test Vectors and Interoperability

Interoperability is a primary goal.

Given the same logical VTO, independent implementations should eventually produce:

```text
             Identical VTO
                  │
        ┌─────────┼─────────┐
        │         │         │
        ▼         ▼         ▼
     Impl A     Impl B    Impl C
        │         │         │
        └─────────┼─────────┘
                  ▼
       Identical deterministic CBOR
                  │
                  ▼
            Identical digest
                  │
                  ▼
             Identical CID
```

Canonical test vectors should eventually contain:

1. The logical VTO
2. The deterministic CBOR bytes
3. The digest algorithm
4. The digest bytes
5. The multihash
6. The CID

This provides a common interoperability target for implementations across languages and ecosystems.

---

# Repository Structure

```text
.
├── README.md
│
├── vto-schema.cddl.md
│   └── Proposed field-level CDDL
│
├── vto-example-bytes.md
│   └── Deterministic VTO test vector and SHA-256 multihash
│
├── vto-float-fields.md
│   └── Floating-point handling requirements
│
├── cbor-digest-context-requirements.md
│   └── Digest-context requirements
│
├── .github/
│   ├── Issue templates
│   ├── Pull-request templates
│   └── CI workflows
│
└── testdata/
    └── Machine-readable test vectors
```

The repository currently packages the proposed VTO schema, digest-context requirements, AAC integration materials, CI scaffolding, and deterministic CBOR test vectors.

---

# Review Gates

Before any adoption or registry publication, the following should be explicitly confirmed:

1. **VTO fields and optionality**

   * Confirm the actual field definitions.
   * Confirm required versus optional fields.

2. **Encoder output**

   * Validate the actual encoder-generated bytes.
   * Avoid relying on manually constructed production-byte examples.

3. **Measurement semantics**

   * Define the meaning, units, and measurement methodology for each metric.

4. **Float policy**

   * Confirm IEEE-754 handling.
   * Define behavior for NaN, infinities, and signed zero.

5. **AAC binding**

   * Confirm the selected AAC integration/binding model.

6. **Digest context**

   * Establish a registered or otherwise agreed typed digest-context identifier.

These gates are important before treating the material as a stable interoperability profile.

---

# Current Implementation Status

| Component                       | Status              |
| ------------------------------- | ------------------- |
| VTO conceptual model            | 🧪 Working draft    |
| CDDL schema                     | 🧪 Working draft    |
| Deterministic CBOR profile      | 🧪 In progress      |
| Digest context                  | 🧪 In progress      |
| SHA-256 profile                 | 🧪 Initial proposal |
| Multihash representation        | 🧪 In progress      |
| CID representation              | 🧪 In progress      |
| Canonical test vectors          | ⏳ Planned           |
| Cross-language interoperability | ⏳ Planned           |
| VTO signatures                  | ⏳ Future work       |
| Provenance / attestation        | ⏳ Future work       |
| Trust / reputation profiles     | ⏳ Future work       |

The repository should therefore be considered **experimental until implementation, interoperability testing, security review, and community feedback have progressed further**.

---

# Roadmap

The immediate implementation priorities are:

1. Finalize the VTO CDDL.
2. Implement deterministic CBOR serialization.
3. Generate canonical CBOR test vectors.
4. Define the digest context.
5. Validate SHA-256 → multihash → CID interoperability.
6. Establish cross-language test vectors.
7. Clarify floating-point canonicalization.
8. Explore optional authenticity and signing profiles.
9. Explore provenance and attestation mechanisms.
10. Develop higher-level trust composition profiles.

---

# Design Principles

### Determinism

The same logical object should result in the same canonical byte representation.

### Content Addressability

Evidence should be independently identifiable through cryptographic content addressing.

### Composability

Small, verifiable objects should be usable as building blocks for larger trust and policy systems.

### Separation of Concerns

Telemetry semantics, serialization, cryptographic identity, authenticity, and trust decisions should remain independently specified.

### Interoperability

The specification should be implementable across languages and ecosystems without depending on a particular implementation.

### Minimalism

The core object should remain small enough to be generated and exchanged efficiently at the edge.

### Extensibility

Future profiles should be able to add capabilities without tightly coupling the core model to a particular application.

---

# Contributing

This repository is an open working space for developing interoperable specifications and implementations for verifiable telemetry and composable evidence.

Contributions are welcome across:

* Specification design
* CDDL
* CBOR encoding
* Digest contexts
* Multihash and CID integration
* Unix-FS / IPFS integration
* Test vectors
* Interoperability testing
* libp2p implementations
* AAC integration
* Security analysis
* Formalization
* Provenance and attestation
* Trust and reputation models

When proposing changes, please distinguish between:

1. **Wire-format requirements**
2. **Canonicalization requirements**
3. **Cryptographic requirements**
4. **Semantic requirements**
5. **Application-specific behavior**

Keeping these layers separate is important for maintaining composability and interoperability.

---

# Status and Scope

**Experimental / Initial Working Draft**

This repository does **not** currently represent a finalized standard or production-ready interoperability profile.

The schemas, encoding profiles, digest contexts, measurement semantics, AAC integration, and verification mechanisms are expected to evolve through:

* Implementation
* Interoperability testing
* Security review
* Community feedback
* Cross-language validation

The objective is to develop a practical foundation for **verifiable, content-addressed telemetry and evidence exchange across peer-to-peer, distributed, and agentic systems**.

