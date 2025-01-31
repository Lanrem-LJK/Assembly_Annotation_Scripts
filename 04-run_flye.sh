#!/usr/bin/env bash
  
#SBATCH --time=1-10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/flye.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/flye.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/Assembly/flye
FOLDER=$WORKDIR/Kas-1
TEM=$WORKDIR/TEMflye

mkdir -p $OUTPUT_DIR
mkdir -p $TEM

zcat $FOLDER/ERR11437309.fastq.gz > $TEM/ERR11437309.fastq

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/flye_2.9.5.sif \
flye --pacbio-hifi $TEM/ERR11437309.fastq -o $OUTPUT_DIR

rm -r $TEM
