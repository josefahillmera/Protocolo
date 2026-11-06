#!/usr/bin/env bash
set -euo pipefail

if command -v mamba >/dev/null 2>&1; then
  mamba install -y -n strainr2 -c bioconda emboss
else
  conda install -y -n strainr2 -c bioconda emboss
fi

mamba run -n strainr2 seqret -version 2>/dev/null || conda run -n strainr2 seqret -version
