import argparse
import hashlib
from pathlib import Path

p = argparse.ArgumentParser()
p.add_argument('--cbor', required=True)
p.add_argument('--multihash', required=True)
a = p.parse_args()
raw = bytes.fromhex(Path(a.cbor).read_text().strip())
actual = '1220' + hashlib.sha256(raw).hexdigest()
expected = Path(a.multihash).read_text().strip()
if actual != expected:
    raise SystemExit(f'multihash mismatch: actual={actual} expected={expected}')
print('multihash conformance passed')
