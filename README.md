# TE visualization along a contig in R

This repo contains an R script for visualizing transposable element (TE) annotations
along a genomic contig. It highlights one class of repeats (e.g., SINE, LINE, LTR)
based on the `repeat class/family` column.

## Files

- `contig_te_visualization.R` – main script to generate the plot.
- `Contig1_Known_TEs.xlsx` – example input file with TE annotations
  (columns: `original begin`, `original end`, `repeat class/family`).

## Usage

1. Install R and the required package:

```r
install.packages("readxl")
