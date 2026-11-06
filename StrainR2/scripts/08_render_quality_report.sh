#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
mamba run -n strainr2 Rscript -e "rmarkdown::render('calidad_26_cepas.Rmd', output_file='calidad_26_cepas.html')"
echo "Informe escrito en $ROOT_DIR/calidad_26_cepas.html"
