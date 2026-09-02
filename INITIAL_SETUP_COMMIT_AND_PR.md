# Initial Setup Commit and PR Text

## Commit subject

`docs: add draft VTO digest-context materials and deterministic test vectors`

## Commit body

Add draft, profile-owner-reviewable VTO integration materials: a field-level CDDL proposal, float requirements, an illustrative deterministic VTO vector, CBOR digest-context requirements, GitHub collaboration templates, basic digest-vector CI, and VTO/AAC fixtures.

The artifacts intentionally do not claim that the supplied fields or byte sequences are current libp2p production output. Registry publication remains blocked on explicit libp2p owner confirmation and a stable digest-context identifier.

## PR description

This PR establishes reviewable scaffolding for VTO digest-context work. It adds no CPB normative changes and makes no registry update. Reviewers should verify the proposed schema, canonical-CBOR rules, float policy, vector reproducibility, and the separation of VTO-only versus AAC+VTO digest domains.
