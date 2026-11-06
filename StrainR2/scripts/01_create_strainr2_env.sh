#!/usr/bin/env bash
set -euo pipefail

if ! command -v mamba >/dev/null 2>&1 && ! command -v conda >/dev/null 2>&1; then
  echo "ERROR: instala Miniforge/Conda antes de continuar." >&2
  exit 1
fi

if command -v mamba >/dev/null 2>&1; then
  mamba create -y -n strainr2 -c conda-forge -c bioconda strainr2
else
  conda create -y -n strainr2 -c conda-forge -c bioconda strainr2
fi

echo "Entorno strainr2 creado. Actívalo con: mamba activate strainr2"
