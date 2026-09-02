---
name: VTO + AAC Integration Discussion
about: Agree the binding model before implementation
title: "[DISCUSS] VTO + AAC integration"
labels: [discussion, vto, aac]
---

# Decision requested

Agree the AAC-to-VTO binding model before code or registry work proceeds.

## Required decisions

- Is AAC a detached object referencing a VTO digest, or a wrapper containing VTO?
- What is the digest scope: VTO only, AAC only, or the composite?
- Which digest-context identifier applies to each scope?
- Are Go and Python required to produce byte-for-byte identical CBOR?
- What canonical test vectors and negative tests are required?

## Non-goals

This issue does not alter CPB normative requirements.

## Acceptance criteria

The resolution records an exact CDDL structure, digest domain, test-vector ownership, implementation owners, and compatibility rules.
