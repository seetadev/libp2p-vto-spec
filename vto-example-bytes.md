# VTO Deterministic Test Vector

**Status:** Illustrative, deterministic test vector; it is **not** represented as bytes emitted by a current libp2p production implementation. Replace it only after preserving this vector as a separate compatibility fixture.

## Logical object

```json
{
  "node_id": "12D3KooWR5vD7vG7zQj8xqJ8xqJ8xqJ8xqJ8xqJ8xqJ8xqJ8",
  "timestamp": 1725280000,
  "jitter_ms": 3.8125,
  "latency_ms": 42.375,
  "packet_loss": 0.00125,
  "region": "us-east-1",
  "throughput_mbps": 987.625
}
```

## Raw CBOR item

Hex:

```text
a766726567696f6e6975732d656173742d31676e6f64655f69647830313244334b6f6f5752357644377647377a516a3878714a3878714a3878714a3878714a3878714a3878714a3878714a38696a69747465725f6d73fb400e8000000000006974696d657374616d701a66d5af006a6c6174656e63795f6d73fb40453000000000006b7061636b65745f6c6f7373fb3f547ae147ae147b6f7468726f7567687075745f6d627073fb408edd0000000000
```

Base64:

```text
p2ZyZWdpb25pdXMtZWFzdC0xZ25vZGVfaWR4MDEyRDNLb29XUjV2RDd2Rzd6UWo4eHFKOHhxSjh4cUo4eHFKOHhxSjh4cUo4eHFKOGlqaXR0ZXJfbXP7QA6AAAAAAABpdGltZXN0YW1wGmbVrwBqbGF0ZW5jeV9tc/tARTAAAAAAAGtwYWNrZXRfbG9zc/s/VHrhR64Ue290aHJvdWdocHV0X21icHP7QI7dAAAAAAA=
```

## SHA-256 multihash

```text
1220ee80dc3721c13c486dd285c4538c79c880b1deb0f6516744fa20ace499044539
```

The digest input is the raw CBOR byte sequence above, without framing or a CID prefix.
