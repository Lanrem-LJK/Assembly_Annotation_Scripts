#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastqc
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/read_QC/fastqc
OUTPUT_DIR1=$OUTPUT_DIR/PacBio_Kas-1
OUTPUT_DIR2=$OUTPUT_DIR/Illumina_Sha 
FOLDER1=$WORKDIR/Kas-1
FOLDER2=$WORKDIR/RNAseq_Sha

mkdir -p $OUTPUT_DIR1
mkdir -p $OUTPUT_DIR2

module load FastQC/0.11.9-Java-11

fastqc $FOLDER1/*.fastq.gz -o $OUTPUT_DIR1
fastqc $FOLDER2/*.fastq.gz -o $OUTPUT_DIR2
