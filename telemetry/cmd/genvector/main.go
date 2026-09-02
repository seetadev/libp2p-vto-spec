package main

import (
    "crypto/sha256"
    "encoding/hex"
    "fmt"
    "os"
    "strings"
)

func main() {
    b, err := os.ReadFile("../../testdata/vto_only_example.cbor.hex")
    if err != nil { panic(err) }
    raw, err := hex.DecodeString(strings.TrimSpace(string(b)))
    if err != nil { panic(err) }
    sum := sha256.Sum256(raw)
    fmt.Printf("cbor_hex=%x\nmultihash_hex=1220%x\n", raw, sum)
}
