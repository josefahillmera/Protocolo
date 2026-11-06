# Protocolo StrainR2: consorcio de 26 cepas

Este repositorio documenta la preparación de una base de referencia para cuantificar cepas bacterianas con StrainR2.

## Consorcio

Se utilizaron 26 muestras/genomas:

`B2.8.A.08`, `B2.8.B.03`, `B2.8.B.06`, `B2.8.C.04`, `B2.8.C.09`, `B2.8.D.05`, `B2.8.D.06`, `B2.8.D.07`, `B2.8.D.08`, `B2.8.D.10`, `B2.8.E.03`, `B2.8.E.05`, `B2.8.E.09`, `B2.8.F.03`, `B2.8.F.05`, `B2.8.F.06`, `B2.8.H.01`, `B2.8.H.03`, `B2.8.H.04`, `B2.8.H.05`, `B2.8.H.06`, `B2.8.H.07`, `B2.8.J.03`, `B2.8.J.07`, `B2.8.J.08`, `B2.8.J.10`.

## Estructura esperada

```text
Protocolo/
├── gbff/                         # GenBank originales
├── fasta/                        # FASTA convertidos desde GBFF
├── metadata/                     # Metadata seleccionada
├── StrainR2DB/                   # Base generada por PreProcessR
├── calidad_26_cepas.tsv          # Seqkit stats
├── calidad_26_cepas.Rmd          # Informe reproducible
├── calidad_26_cepas.html         # Informe renderizado
├── scripts/                      # Scripts de ejecución
└── results/                      # Resúmenes derivados
```

## Requisitos

- macOS/Linux para StrainR2.
- Miniforge/Conda/Mamba.
- Lecturas metagenómicas paired-end FASTQ para ejecutar la etapa final de `StrainR`.
- Confirmar la longitud real de las lecturas antes de usar `--readsize`.

## Ejecución

Desde esta carpeta:

```bash
bash scripts/01_create_strainr2_env.sh
bash scripts/02_install_emboss.sh
bash scripts/03_convert_gbff_to_fasta.sh
bash scripts/04_validate_fasta.sh
bash scripts/05_run_preprocessr.sh 150
bash scripts/06_summarize_kmers.sh
bash scripts/07_seqkit_stats.sh
bash scripts/08_render_quality_report.sh
```

El paso 05 puede tardar más de 100 minutos y requiere varios GB de RAM. No se debe repetir sobre una carpeta de salida que ya contenga una base válida.

## Resultado de esta ejecución

`PreProcessR` terminó correctamente con:

- 129.551.558 k-mers diferentes.
- 128.620.910 k-mers únicos.
- 99,28% de k-mers únicos globales.
- N50 mínimo de 74.261 bp, correspondiente a `26_B28_J10.fna`.
- 3.724 registros de subcontigs en `KmerContent.report`.
- 3.706 subcontigs útiles y 18 excluidos.
- 98,40% de unicidad promedio en los subcontigs útiles.

## Interpretación

`KmerContent.report` describe la capacidad de los subcontigs de diferenciarse dentro de la comunidad. No informa abundancia ni presencia en una muestra. La abundancia se obtiene después con `StrainR` y las lecturas FASTQ.

## GitHub

La base `StrainR2DB` ocupa aproximadamente 834 MB. GitHub no es adecuado para almacenar archivos grandes directamente. Se recomienda:

1. subir scripts, README, metadata y resúmenes;
2. excluir `StrainR2DB/`, `gbff/`, `fasta/` y FASTQ del repositorio normal;
3. usar Git LFS, Zenodo, OSF o un almacenamiento institucional para los datos grandes;
4. conservar checksums y rutas de descarga en un manifiesto.

Los scripts no borran resultados existentes: si la carpeta de salida ya existe, el script de `PreProcessR` se detiene para evitar sobrescribirla.
