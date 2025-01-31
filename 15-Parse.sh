#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=64G
#SBATCH --time=5-00:00:00
#SBATCH --job-name=TE_Age_Estimation
#SBATCH --mail-user=bioljk@outlook.com
#SBATCH --mail-type=ALL
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/Parse.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/Parse.err
#SBATCH --partition=pibu_el8

# Load necessary modules
module load BioPerl/1.7.8-GCCcore-10.3.0

# Define variables
GENOME_MOD_OUT="/data/users/jlan/assembly-annotation-course/EDTA_annotation/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out"
PARSE_RM_SCRIPT="/data/users/jlan/assembly-annotation-course/scripts/parseRM.pl"   

perl $PARSE_RM_SCRIPT -i $GENOME_MOD_OUT -l 50,1 -v

echo "TE Age Estimation completed."
