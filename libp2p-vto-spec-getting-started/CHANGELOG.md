# Changelog

All notable changes to this draft package are documented here.

## [Unreleased]

### Added

- Draft VTO field-level CDDL (`vto-schema.cddl.md`).
- Float-handling requirements (`vto-float-fields.md`).
- Deterministic VTO test vector and SHA-256 multihash (`vto-example-bytes.md`, `testdata/vto_only_example.*`).
- AAC+VTO composite vector (`testdata/vto_aac_example.*`).
- CBOR digest-context requirements note (`cbor-digest-context-requirements.md`).
- GitHub discussion and PR templates for VTO+AAC work.
- Basic CI that verifies stored vectors and absence of placeholders.
- Bootstrap script (`scripts/bootstrap.sh`) to validate vectors locally.

### Notes

- These materials are draft and profile-owner-reviewable. They do not assert current libp2p production behavior.
- Registry publication is blocked on explicit libp2p owner confirmation and a stable digest-context identifier.
