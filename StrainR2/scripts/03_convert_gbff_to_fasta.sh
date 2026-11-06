#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INPUT_DIR="$ROOT_DIR/gbff"
OUTPUT_DIR="$ROOT_DIR/fasta"

mkdir -p "$OUTPUT_DIR"
shopt -s nullglob
files=("$INPUT_DIR"/*.gbff)

if [ "${#files[@]}" -eq 0 ]; then
  echo "ERROR: no se encontraron archivos .gbff en $INPUT_DIR" >&2
  exit 1
fi

for gbff in "${files[@]}"; do
  nombre="$(basename "$gbff" .gbff)"
  output="$OUTPUT_DIR/${nombre}.fna"
  if [ -s "$output" ]; then
    echo "Existe; se conserva: $output"
    continue
  fi
  mamba run -n strainr2 seqret -sequence "$gbff" -outseq "$output" -osformat fasta
done

echo "GBFF convertidos: $(find "$OUTPUT_DIR" -maxdepth 1 -type f -name '*.fna' | wc -l | tr -d ' ')"
