#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT="$ROOT_DIR/StrainR2DB/KmerContent.report"
OUT_DIR="$ROOT_DIR/results"
mkdir -p "$OUT_DIR"

awk -F '\t' '
NR > 1 && $1 != "SubcontigID" && NF >= 7 {
  id=$2; total[id]++; sumN[id]+=$6; sumP[id]+=$7
  if ($3 ~ /^EXCLUDED/) excluded[id]++; else useful[id]++
}
END {
  print "StrainID\tTotal_subcontigs\tExcluded\tUseful\tNunique_total\tMean_Percent_Unique"
  for (id in total) printf "%s\t%d\t%d\t%d\t%d\t%.4f\n", id,total[id],excluded[id]+0,useful[id]+0,sumN[id]+0,(useful[id]?sumP[id]/useful[id]:0)
}' "$REPORT" | {
  IFS= read -r header
  printf '%s\n' "$header"
  sort -k1,1
} > "$OUT_DIR/kmer_summary_by_strain.tsv"

awk -F '\t' '
NR > 1 && $1 != "SubcontigID" && NF >= 7 {n++; if ($3 ~ /^EXCLUDED/) e++; else u++; s += $6; p += $7}
END {printf "records\t%d\nexcluded\t%d\nuseful\t%d\nNunique_total\t%d\nmean_percent_unique\t%.4f\n", n,e,u,s,(u?p/u:0)}
' "$REPORT" > "$OUT_DIR/kmer_summary_global.tsv"

echo "Resúmenes escritos en $OUT_DIR"
