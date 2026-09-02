# CBOR Digest Context Requirements for VTO

**Status:** Draft requirements note. This document defines requirements; it does not allocate a registry identifier or define a new hash algorithm.

## Scope

The context binds a typed digest reference to the exact CBOR bytes of one VTO object. It uses a deterministic CBOR encoding contract so independently produced valid VTO values yield identical digest inputs.

## Digest input

The digest input MUST be exactly one definite-length CBOR map conforming to `vto-schema.cddl.md`. The input MUST NOT include transport framing, a length prefix, a multihash prefix, a CID prefix, detached signatures, or AAC wrapper bytes. A distinct context is required if a future design binds an AAC+VTO composite.

## CBOR requirements

1. Maps MUST be definite length.
2. Text-string keys MUST be unique and ordered by lexicographic byte order of their UTF-8 encoded key representations.
3. Integers MUST use shortest-form CBOR encoding.
4. Floating-point VTO fields MUST use binary64 encoding (`0xfb` plus eight bytes).
5. Indefinite-length items are prohibited.
6. Tags are prohibited within a VTO object unless a later VTO schema revision explicitly permits and specifies them.
7. `NaN`, infinities, and negative zero are prohibited.

## Digest algorithm

For the current test context, compute SHA-256 over the input bytes. When serialized as a multihash, encode the result as `0x12 || 0x20 || SHA-256(input)`. The profile MUST define a stable typed digest-context identifier before this construction is placed in a registry as non-provisional.

## Conformance

An implementation conforms when it validates the VTO constraints, produces the test vector in `testdata/vto_only_example.*`, and computes the matching multihash.

## CID mapping (informative)

A CID v1 may be formed from the resulting multihash with the `dag-cbor` multicodec only when the byte sequence is valid DAG-CBOR under the selected profile. This mapping does not change the digest input or digest algorithm.
