### Assembly Encryption tool
This is a 16-bit DOS assembly program that conditionally transforms and prints a paragraph based on whether its length is even or odd. It uses classic encryption-inspired techniques such as bit rotation, XOR, Caesar cipher, and substitution ciphers.

The program is written using the **small memory model** and relies on **INT 21h** for console output.

---

## Features

- Detects **even or odd length** of a paragraph at runtime
- Applies different transformation pipelines based on parity
- Demonstrates:
  - Bitwise rotation (`ROL`)
  - XOR encoding
  - Caesar cipher
  - Monoalphabetic substitution (Atbash-style)
- Uses DOS `$`-terminated strings
- Clean separation of logic paths

---

## Program Flow

### 1. Initialization
- Loads data segment
- Stores paragraph, decoy string, keys, and lookup tables

### 2. Length Check
- Computes paragraph length
- Uses `TEST` instruction to check parity

---

### Odd-Length Paragraph Path

- Prints `1`
- Applies:
  1. Bit rotation to each character
  2. XOR encoding using a fixed key
- Outputs the transformed paragraph

---

### Even-Length Paragraph Path

- Prints `0`
- Applies:
  1. Caesar cipher to the decoy string
  2. Substitution cipher to the paragraph:
     - Uppercase letters mapped using `ZYX...A`
     - Lowercase letters mapped using `zyx...a`
- Outputs the transformed paragraph

---

## Encryption Techniques Used

### Bit Rotation
Rotates each byte left by a configurable number of bits.

### XOR Encoding
Applies XOR with a fixed key to each character.

### Caesar Cipher
Shifts each character in the decoy string by a fixed key value.

### Substitution Cipher
Maps alphabetic characters using predefined lookup tables.

---

## Requirements

- MASM or TASM
- DOSBox (or real DOS environment)
- 16-bit x86 compatible system

---

## Build Instructions

```bash
masm project.asm;
link project.obj;
