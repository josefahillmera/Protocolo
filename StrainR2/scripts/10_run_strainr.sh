#!/usr/bin/env bash
set -euo pipefail

# FASE 2: comparación de lecturas metagenómicas contra StrainR2DB.
# Este script está preparado para ejecutarse cuando existan R1/R2; no se ejecuta durante la preparación.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
R1="${1:-}"
R2="${2:-}"
SAMPLE="${3:-muestra}"
THREADS="${THREADS:-4}"
MEM_GB="${MEM_GB:-4}"

if [ -z "$R1" ] || [ -z "$R2" ]; then
  echo "Uso: bash scripts/10_run_strainr.sh reads/muestra_R1.fastq.gz reads/muestra_R2.fastq.gz nombre_muestra" >&2
  exit 2
fi

if [ ! -f "$ROOT_DIR/$R1" ] && [ ! -f "$R1" ]; then
  echo "ERROR: no existe R1: $R1" >&2
  exit 1
fi
if [ ! -f "$ROOT_DIR/$R2" ] && [ ! -f "$R2" ]; then
  echo "ERROR: no existe R2: $R2" >&2
  exit 1
fi
if [ ! -d "$ROOT_DIR/StrainR2DB" ]; then
  echo "ERROR: no existe StrainR2DB. Ejecuta primero la Fase 1." >&2
  exit 1
fi

R1_PATH="$R1"
R2_PATH="$R2"
case "$R1" in /*) R1_PATH="$R1";; *) R1_PATH="$ROOT_DIR/$R1";; esac
case "$R2" in /*) R2_PATH="$R2";; *) R2_PATH="$ROOT_DIR/$R2";; esac

mkdir -p "$ROOT_DIR/resultados/$SAMPLE"

mamba run -n strainr2 StrainR \
  --forward "$R1_PATH" \
  --reverse "$R2_PATH" \
  --reference "$ROOT_DIR/StrainR2DB" \
  --outdir "$ROOT_DIR/resultados/$SAMPLE" \
  --prefix "$SAMPLE" \
  --threads "$THREADS" \
  --mem "$MEM_GB"
