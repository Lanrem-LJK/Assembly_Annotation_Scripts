#!/usr/bin/env bash
  
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/trinity.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/trinity.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/Assembly/trinity
FOLDER=$WORKDIR/read_QC/fastp/Illumina_Sha/
TEM=$WORKDIR/TEMtrinity

mkdir -p $OUTPUT_DIR
mkdir -p $TEM

module load Trinity/2.15.1-foss-2021a

zcat $FOLDER/1.fastq.gz > $TEM/ERR754081_1.fastq
zcat $FOLDER/2.fastq.gz > $TEM/ERR754081_2.fastq

Trinity --seqType fq --left $TEM/ERR754081_1.fastq --right $TEM/ERR754081_2.fastq --output $OUTPUT_DIR --CPU 6 --max_memory 20G

rm -r $TEM
