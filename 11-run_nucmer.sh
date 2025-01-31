#!/usr/bin/env bash
  
#SBATCH --time=1-10:00:00
#SBATCH --mem=80G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=nucmer
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/nucmer.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/nucmer.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/nucmer
FODER=$WORKDIR/Kas-1
flye=$WORKDIR/Assembly/flye/assembly.fasta
hifiasm=$WORKDIR/Assembly/hifiasm/assembly.fa
lja=$WORKDIR/Assembly/lja/assembly.fasta
reference=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

mkdir -p $OUTPUT_DIR

# flye reference
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
  nucmer -p $OUTPUT_DIR/flye_ref --breaklen 1000 --mincluster 1000 $reference $flye
# hifiasm reference
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
  nucmer -p $OUTPUT_DIR/hifiasm_ref --breaklen 1000 --mincluster 1000 $reference $hifiasm
# lja reference
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
  nucmer -p $OUTPUT_DIR/lja_ref --breaklen 1000 --mincluster 1000 $reference $lja
# flye hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
  nucmer -p $OUTPUT_DIR/flye_hifiasm --breaklen 1000 --mincluster 1000 $hifiasm $flye
# hifiasm lja
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
  nucmer -p $OUTPUT_DIR/hifiasm_lja --breaklen 1000 --mincluster 1000 $lja $hifiasm
# lja flye
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
  nucmer -p $OUTPUT_DIR/lja_flye --breaklen 1000 --mincluster 1000 $flye $lja
