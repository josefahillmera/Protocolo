#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT_DIR/calidad_26_cepas.tsv"

mamba install -y -n strainr2 -c bioconda seqkit
mamba run -n strainr2 seqkit stats -a "$ROOT_DIR"/fasta/*.fna > "$OUT"
echo "Tabla escrita en $OUT"
