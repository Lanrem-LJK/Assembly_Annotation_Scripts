#!/usr/bin/env bash
  
#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastp
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/read_QC/fastp
OUTPUT_DIR1=$OUTPUT_DIR/PacBio_Kas-1
OUTPUT_DIR2=$OUTPUT_DIR/Illumina_Sha
FOLDER1=$WORKDIR/Kas-1
FOLDER2=$WORKDIR/RNAseq_Sha

mkdir -p $OUTPUT_DIR1
mkdir -p $OUTPUT_DIR2

module load fastp/0.23.4-GCC-10.3.0

fastp -i $FOLDER1/*.fastq.gz -o $OUTPUT_DIR1/kas.fastq.gz -h $OUTPUT_DIR1/kas_report.html -j $OUTPUT_DIR1/kas_report.json
fastp -i $FOLDER2/*1.fastq.gz -I $FOLDER2/*2.fastq.gz -o $OUTPUT_DIR2/1.fastq.gz -O $OUTPUT_DIR2/2.fastq.gz -h $OUTPUT_DIR2/sha_report.html -j $OUTPUT_DIR2/sha_report.json
