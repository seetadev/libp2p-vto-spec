# VTO Float-Bearing Fields

**Status:** Draft pending profile-owner confirmation.

| Field | Wire type | Measurement basis | Derived | Required precision | Constraint |
|---|---|---|---:|---|---|
| `jitter_ms` | CBOR float64 | Standard deviation of packet/inter-arrival timing over the stated observation interval | Yes | IEEE 754 binary64 | Finite, >= 0 |
| `latency_ms` | CBOR float64 | Observed one-way or round-trip latency; the telemetry producer MUST identify which basis it uses | Producer-dependent | IEEE 754 binary64 | Finite, >= 0 |
| `packet_loss` | CBOR float64 | Lost packets divided by total packets in the observation interval | Yes | IEEE 754 binary64 | Finite, 0 <= value <= 1 |
| `throughput_mbps` | CBOR float64 | `(bytes_transferred / interval_seconds) * 8 / 1_000_000` | Yes | IEEE 754 binary64 | Finite, >= 0 |

## Encoding rules

1. Each field above MUST use CBOR major type 7 with additional information 27 (`0xfb`), followed by an IEEE 754 binary64 payload.
2. A conforming producer MUST reject `NaN`, positive infinity, negative infinity, and negative zero before encoding.
3. A float-valued field MUST remain a float on the wire even if its numeric value is integral.
4. Calculations performed at a higher precision MUST be rounded to binary64 before encoding.
