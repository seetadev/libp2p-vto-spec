# Reference vector bytes live in ../../testdata.
# Production encoders must implement the approved AAC binding model.
from pathlib import Path
import hashlib
root = Path(__file__).resolve().parents[2]
raw = bytes.fromhex((root / 'testdata/vto_only_example.cbor.hex').read_text().strip())
print('cbor_hex=' + raw.hex())
print('multihash_hex=1220' + hashlib.sha256(raw).hexdigest())
