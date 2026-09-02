
# Getting Started

This package provides draft VTO digest-context materials and deterministic test vectors. It is intended for review and integration planning, not as a claim of current libp2p production output.

## Quick start

1. Clone the repo and open a terminal in the root.
2. Run the bootstrap script to validate vectors:
   ```bash
   bash scripts/bootstrap.sh
   ```
3. Run a local conformance check:
   ```bash
   python tools/check_vto_conformance.py --cbor testdata/vto_only_example.cbor.hex --multihash testdata/vto_only_example.multihash.hex
   python tools/check_vto_conformance.py --cbor testdata/vto_aac_example.cbor.hex --multihash testdata/vto_aac_example.multihash.hex
   ```
4. Review the spec drafts:
   - `vto-schema.cddl.md`
   - `vto-float-fields.md`
   - `vto-example-bytes.md`
   - `cbor-digest-context-requirements.md`

## Next steps

- Open a discussion issue using `.github/ISSUE_TEMPLATE/vto-aac-discussion.md` to finalize the AAC binding model and digest scope.
- After agreement, implement the AAC emitter in Go and Python and open a PR using `.github/pull_request_template.md`.
- Extend CI with additional vectors and negative tests as the design evolves.

## Important notice

These artifacts are draft and require explicit libp2p profile-owner confirmation before any registry publication or normative claims.
