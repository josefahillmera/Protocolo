# Protocolo StrainR2 — consorcio de 26 cepas

Este repositorio contiene scripts, metadata, resúmenes y resultados reproducibles para preparar una base de referencia de 26 genomas con StrainR2.

## Datos grandes excluidos

Por tamaño, no se suben al repositorio Git los archivos originales `GBFF`, los FASTA, la base `StrainR2DB` ni las lecturas FASTQ. Deben agregarse localmente en:

```text
Protocolo/StrainR2/gbff/
Protocolo/StrainR2/fasta/
Protocolo/StrainR2/StrainR2DB/
Protocolo/StrainR2/reads/
```

Las carpetas incluidas en el repositorio contienen un `README.md` que explica qué archivo debe colocarse en cada una. El archivo `manifest.tsv` conserva la correspondencia de las 26 muestras.

## Requisitos

Se requiere macOS o Linux, Miniforge/Conda/Mamba y conexión a internet. StrainR2 puede ejecutarse en macOS/Linux. StrainScan requiere un entorno Linux separado.

## Instalación y ejecución completa

```bash
cd Protocolo/StrainR2
bash ../scripts/01_create_strainr2_env.sh
bash ../scripts/02_install_emboss.sh
bash ../scripts/03_convert_gbff_to_fasta.sh
bash ../scripts/04_validate_fasta.sh
bash ../scripts/05_run_preprocessr.sh 150
bash ../scripts/06_summarize_kmers.sh
bash ../scripts/07_seqkit_stats.sh
bash ../scripts/08_render_quality_report.sh
```

`150` debe reemplazarse por la longitud real de las lecturas FASTQ. Se puede comprobar con:

```bash
gzip -cd reads/muestra_R1.fastq.gz | awk 'NR==2 {print length($0); exit}'
```

## Qué hace cada script

| Script | Función |
|---|---|
| `01_create_strainr2_env.sh` | Crea el entorno Conda de StrainR2. |
| `02_install_emboss.sh` | Instala `seqret` para convertir GBFF a FASTA. |
| `03_convert_gbff_to_fasta.sh` | Convierte los 26 GBFF a `.fna`. |
| `04_validate_fasta.sh` | Comprueba que existan 26 FASTA válidos. |
| `05_run_preprocessr.sh` | Construye `StrainR2DB`. Puede tardar más de 100 minutos. |
| `06_summarize_kmers.sh` | Resume `KmerContent.report` por cepa y globalmente. |
| `07_seqkit_stats.sh` | Calcula contigs, longitud, N50 y GC%. |
| `08_render_quality_report.sh` | Genera el informe HTML de calidad. |

## Resultados ya obtenidos

La ejecución de `PreProcessR` terminó correctamente con:

- 129.551.558 k-mers diferentes.
- 128.620.910 k-mers únicos, aproximadamente 99,28% global.
- N50 mínimo de 74.261 bp en `26_B28_J10.fna`.
- 3.724 registros en `KmerContent.report`.
- 3.706 subcontigs útiles y 18 excluidos.
- 98,4020% de unicidad promedio en subcontigs útiles.

Los resultados publicados incluyen `calidad_26_cepas.tsv`, `calidad_26_cepas.Rmd`, `calidad_26_cepas.html`, `results/kmer_summary_by_strain.tsv` y `results/kmer_summary_global.tsv`.

## Ejecutar StrainR con lecturas FASTQ

Después de agregar lecturas paired-end a `reads/`:

```bash
mamba activate strainr2
StrainR \
  --forward ./reads/muestra_R1.fastq.gz \
  --reverse ./reads/muestra_R2.fastq.gz \
  --reference ./StrainR2DB \
  --outdir ./resultados/muestra \
  --prefix muestra \
  --threads 4 \
  --mem 4
```

`StrainR2DB` se construye una vez y se puede reutilizar para varias muestras. `StrainR` generará archivos de mapeo, RPKM, abundancia, resumen y figura.

## Resultado de `KmerContent.report`

Las columnas son `SubcontigID`, `StrainID`, `ContigID`, `Start_Stop`, `Length`, `Nunique` y `Percent_Unique`. Los valores altos de `Percent_Unique` indican subcontigs más discriminables dentro del consorcio; no representan abundancia de una cepa.

## Git LFS y archivos grandes

La base `StrainR2DB` ocupa aproximadamente 834 MB y no debe subirse al Git normal. Para compartirla se recomienda Git LFS, Zenodo, OSF o almacenamiento institucional. En ese caso deben conservarse checksums y documentar la ruta de descarga.

## Referencias

- StrainR2: https://github.com/BisanzLab/StrainR2
- Bioconda StrainR2: https://bioconda.github.io/recipes/strainr2/README.html
