#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

MODE="${1:-debug}"
BUILD_DIR_ARG="${2:-}"

FILES=("main" "message")

NASM_FLAGS=(-f elf32)
LD_FLAGS=(-m elf_i386)

mode_lc="$(echo "$MODE" | tr '[:upper:]' '[:lower:]')"
if [[ "$mode_lc" == "debug" ]]; then
  NASM_FLAGS+=(-g -F dwarf)
  DEFAULT_DIR="build/debug"
elif [[ "$mode_lc" == "release" ]]; then
  DEFAULT_DIR="build/release"
else
  echo "Usage: $0 <debug|release> [build/path]" >&2
  exit 1
fi

BUILD_DIR="${BUILD_DIR_ARG:-$DEFAULT_DIR}"
mkdir -p "$BUILD_DIR"

echo "[+] Build type: $MODE"
echo "[+] Output dir: $BUILD_DIR"

OBJ=()
for f in "${FILES[@]}"; do
  SRC="$f.asm"
  OUT_OBJ="$BUILD_DIR/$f.o"

  if [[ ! -f "$SRC" ]]; then
    echo "[-] Source not found: $SRC" >&2
    exit 1
  fi

  echo "[+] Assembling $SRC..."
  nasm "${NASM_FLAGS[@]}" "$SRC" -o "$OUT_OBJ"
  OBJ+=("$OUT_OBJ")
done

BIN="$BUILD_DIR/main"
echo "[+] Linking..."
ld "${LD_FLAGS[@]}" "${OBJ[@]}" -o "$BIN"

echo "[✓] Build complete: $BIN"
