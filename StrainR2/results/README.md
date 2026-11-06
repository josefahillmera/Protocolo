# Resultados de StrainR2

Esta carpeta contiene resultados livianos que sí se versionan en GitHub:

- `KmerContent.report`: reporte original generado por `PreProcessR`.
- `StrainR2_options.txt`: parámetros usados para construir la base.
- `kmer_summary_by_strain.tsv`: resumen por cepa.
- `kmer_summary_global.tsv`: resumen global.

La base completa `StrainR2DB/` no se versiona porque ocupa aproximadamente 834 MB e incluye el índice BBMap y los subcontigs. Para repetir el análisis, agrega localmente los 26 GBFF en `StrainR2/gbff/`, genera `StrainR2/fasta/` y ejecuta `scripts/05_run_preprocessr.sh`.
