#!/usr/bin/env bash
  
#SBATCH --time=1-00:00:00
#SBATCH --mem=45G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=kmer
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/read_QC/kmer
OUTPUT_DIR1=$OUTPUT_DIR/PacBio_Kas-1
OUTPUT_DIR2=$OUTPUT_DIR/Illumina_Sha
FOLDER1=$WORKDIR/Kas-1
FOLDER2=$WORKDIR/RNAseq_Sha

mkdir -p $OUTPUT_DIR1
mkdir -p $OUTPUT_DIR2

module load Jellyfish/2.3.0-GCC-10.3.0

jellyfish count -C -m 21 -s 5G -t 4 <(zcat $FOLDER1/*.fastq.gz) -o $OUTPUT_DIR1/reads_Kas-1.jf 
jellyfish histo -s 5G -t 4 $OUTPUT_DIR1/reads_Kas-1.jf > $OUTPUT_DIR1/reads_Kas-1.histo

jellyfish count -C -m 21 -s 5G -t 4 <(zcat $FOLDER2/*1.fastq.gz) <(zcat $FOLDER2/*2.fastq.gz) -o $OUTPUT_DIR2/reads_Sha.jf
jellyfish histo -s 5G -t 4 $OUTPUT_DIR2/reads_Sha.jf > $OUTPUT_DIR2/reads_Sha.histo
