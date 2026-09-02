# Proposed VTO Field-Level Schema

**Status:** Draft pending profile-owner confirmation.

```cddl
VTO = {
  node_id: peer-id,
  timestamp: uint,
  jitter_ms: finite-float64,
  latency_ms: finite-float64,
  packet_loss: finite-float64,
  region: tstr,
  throughput_mbps: finite-float64
}

peer-id = tstr
finite-float64 = float
```

## Required fields and optionality

All fields in this draft are required. No optional members are defined. A future revision must use explicit CDDL optional-member syntax and establish whether new members alter the digest domain.

## Constraints

- `node_id` is a non-empty peer-ID text representation.
- `timestamp` is a non-negative Unix timestamp in seconds.
- `jitter_ms`, `latency_ms`, and `throughput_mbps` are finite, non-negative IEEE 754 binary64 values.
- `packet_loss` is a finite IEEE 754 binary64 value in the inclusive range 0.0 through 1.0.
- `region` is a non-empty text string.

CDDL itself cannot express all finite-value and range restrictions above; conforming encoders and validators MUST enforce them.
