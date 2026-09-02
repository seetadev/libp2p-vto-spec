#!/usr/bin/env bash
set -euo pipefail

# Bootstrap VTO test vectors and conformance check
# Requirements: Python 3.10+, POSIX shell

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo ".")"

# Verify stored vectors
python - <<'PY'
from hashlib import sha256
from pathlib import Path
def check(cbor_path, mh_path):
    raw = bytes.fromhex(Path(cbor_path).read_text().strip())
    actual = "1220" + sha256(raw).hexdigest()
    expected = Path(mh_path).read_text().strip()
    if actual != expected:
        raise SystemExit(f"mismatch {cbor_path}: {actual} vs {expected}")
    print(f"OK {cbor_path} -> {expected}")
check("testdata/vto_only_example.cbor.hex", "testdata/vto_only_example.multihash.hex")
check("testdata/vto_aac_example.cbor.hex", "testdata/vto_aac_example.multihash.hex")
PY

echo "Bootstrap complete. Run CI locally with: python tools/check_vto_conformance.py --cbor testdata/vto_only_example.cbor.hex --multihash testdata/vto_only_example.multihash.hex"
