#!/usr/bin/env bash
  
#SBATCH --time=1-10:00:00
#SBATCH --mem=80G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/merqury.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/merqury.err

export MERQURY="/usr/local/share/merqury"

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/merqury
FOLDER=$WORKDIR/Kas-1
TEM=$WORKDIR/TEMmerqury
flye=$WORKDIR/Assembly/flye/assembly.fasta
hifiasm=$WORKDIR/Assembly/hifiasm/assembly.fa
lja=$WORKDIR/Assembly/lja/assembly.fasta
FLYE=$OUTPUT_DIR/flye
HIFIASM=$OUTPUT_DIR/hifiasm
LJA=$OUTPUT_DIR/lja

mkdir -p $FLYE
mkdir -p $HIFIASM
mkdir -p $LJA
mkdir -p $TEM

#tolerable collision rate: 0.001
#18.5126

zcat $FOLDER/ERR11437309.fastq.gz > $TEM/ERR11437309.fastq

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
meryl k=18 count $TEM/ERR11437309.fastq output $OUTPUT_DIR/read.meryl 

cd $FLYE
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
  $MERQURY/merqury.sh $OUTPUT_DIR/read.meryl $flye flye

cd $HIFIASM
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
  $MERQURY/merqury.sh $OUTPUT_DIR/read.meryl $hifiasm hifiasm

cd $LJA
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
  $MERQURY/merqury.sh $OUTPUT_DIR/read.meryl $lja lja

rm -r $TEM
