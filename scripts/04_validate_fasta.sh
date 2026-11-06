#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FASTA_DIR="$ROOT_DIR/fasta"

count="$(find "$FASTA_DIR" -maxdepth 1 -type f -name '*.fna' | wc -l | tr -d ' ')"
if [ "$count" -ne 26 ]; then
  echo "ERROR: se esperaban 26 FASTA y se encontraron $count" >&2
  exit 1
fi

for fna in "$FASTA_DIR"/*.fna; do
  if ! grep -q '^>' "$fna"; then
    echo "ERROR: no parece FASTA válido: $fna" >&2
    exit 1
  fi
done

echo "Validación correcta: 26 FASTA con cabecera de secuencia."
