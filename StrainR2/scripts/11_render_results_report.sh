#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
mamba run -n strainr2 Rscript -e "rmarkdown::render('resultados_strainr2.Rmd', output_file='resultados_strainr2.html')"
echo "Informe escrito en $ROOT_DIR/resultados_strainr2.html"
