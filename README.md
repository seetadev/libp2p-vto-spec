### VTO (Verified Telemetry Object): Draft Integration Materials

**Status:** Draft integration materials.

This repository packages proposed VTO schema, digest-context requirements, AAC integration templates, CI scaffolding, and deterministic CBOR test vectors. The VTO field names, semantic definitions, and production-byte claims must be confirmed by the libp2p profile owner before registry publication.

### Contents

- `vto-schema.cddl.md` — proposed field-level CDDL
- `vto-example-bytes.md` — deterministic VTO test vector and SHA-256 multihash
- `vto-float-fields.md` — float-handling requirements
- `cbor-digest-context-requirements.md` — digest-context requirements note
- `.github/` — issue/PR templates and CI workflow
- `testdata/` — machine-readable vectors

### Encoding contract

The supplied vectors use definite-length CBOR maps, deterministic key ordering by encoded-key bytes, IEEE 754 binary64 floats, and SHA-256 multihashes over the raw CBOR item. Do not describe this as a CBOR tag-42 profile: tag 42 is the CID tag, while DAG-CBOR is a distinct IPLD codec/profile.

### Review gates

Before adoption or registry publication, confirm: 
(1) actual VTO fields and optionality, 
(2) actual encoder bytes from libp2p, 
(3) measurement semantics and float policy, 
(4) the selected AAC binding model, and 
(5) a registered or otherwise agreed typed digest-context identifier.
