#!/usr/bin/env bash
  
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasm
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/hifiasm.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/hifiasm.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/Assembly/hifiasm
FOLDER=$WORKDIR/Kas-1
TEM=$WORKDIR/TEMhifiasm

mkdir -p $OUTPUT_DIR
mkdir -p $TEM

zcat $FOLDER/ERR11437309.fastq.gz > $TEM/ERR11437309.fastq

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/hifiasm_0.19.8.sif \
hifiasm -o $OUTPUT_DIR/Kas_1.asm -t 32 $TEM/ERR11437309.fastq

rm -r $TEM
