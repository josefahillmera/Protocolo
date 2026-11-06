#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FASTA_DIR="$ROOT_DIR/fasta"
DB_DIR="$ROOT_DIR/StrainR2DB"
READ_SIZE="${1:-150}"

if [ -e "$DB_DIR" ]; then
  echo "ERROR: ya existe $DB_DIR. Para no sobrescribir una base, usa otra salida o mueve la anterior." >&2
  exit 1
fi

mamba run -n strainr2 PreProcessR \
  --indir "$FASTA_DIR" \
  --outdir "$DB_DIR" \
  --readsize "$READ_SIZE"

test -s "$DB_DIR/KmerContent.report"
test -s "$DB_DIR/options.txt"
echo "PreProcessR completado: $DB_DIR"
