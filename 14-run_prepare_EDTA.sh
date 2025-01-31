#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=64G
#SBATCH --time=7-00:00:00
#SBATCH --job-name=Phylo_Analysis
#SBATCH --mail-user=bioljk@outlook.com
#SBATCH --mail-type=ALL
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/Prepare_EDTA.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/Prepare_EDTA.err
#SBATCH --partition=pibu_el8

module load 

TEsorter assembly.fasta.mod.EDTA.raw/LTR/assembly.fasta.mod.LTR.intact.raw.fa -db rexdb-plant 
