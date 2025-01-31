#!/usr/bin/env bash
  
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=LJA
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/lja.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/lja.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/Assembly/lja
FOLDER=$WORKDIR/Kas-1
TEM=$WORKDIR/TEMlja

mkdir -p $OUTPUT_DIR
mkdir -p $TEM

zcat $FOLDER/ERR11437309.fastq.gz > $TEM/ERR11437309.fastq

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/lja-0.2.sif \
lja -o $OUTPUT_DIR --reads $TEM/ERR11437309.fastq

rm -r $TEM
