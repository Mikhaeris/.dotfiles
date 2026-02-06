#!/bin/sh
set -e

BUILD_TYPE=${1:-Debug}
BUILD_DIR="build/$(echo "$BUILD_TYPE" | tr 'A-Z' 'a-z')"

SRC="main.asm"
OBJ="$BUILD_DIR/main.o"
BIN="$BUILD_DIR/main"

NASM_FLAGS="-f elf32"
LD_FLAGS="-m elf_i386"

mkdir -p "$BUILD_DIR"

echo "[+] Build type: $BUILD_TYPE"
echo "[+] Output dir: $BUILD_DIR"

if [ "$BUILD_TYPE" = "Debug" ]; then
  NASM_FLAGS="$NASM_FLAGS -g -F dwarf"
elif [ "$BUILD_TYPE" = "Release" ]; then
  NASM_FLAGS="$NASM_FLAGS"
else
  echo "[-] Unknown build type: $BUILD_TYPE"
  exit 1
fi

echo "[+] Assembling..."
nasm $NASM_FLAGS "$SRC" -o "$OBJ"

echo "[+] Linking..."
ld $LD_FLAGS "$OBJ" -o "$BIN"

echo "[✓] Build complete: $BIN"
