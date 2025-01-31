#!/usr/bin/env bash
  
#SBATCH --time=1-10:00:00
#SBATCH --mem=80G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=mummer
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/mummer.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/mummer.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/mummer
NUCMER_DIR=$WORKDIR/nucmer
FODER=$WORKDIR/Kas-1
flye=$WORKDIR/Assembly/flye/assembly.fasta
hifiasm=$WORKDIR/Assembly/hifiasm/assembly.fa
lja=$WORKDIR/Assembly/lja/assembly.fasta
reference=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

mkdir -p $OUTPUT_DIR

apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
 mummerplot --png --layout --large -p $OUTPUT_DIR/flye_ref $NUCMER_DIR/flye_ref.delta
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
 mummerplot --png --layout --large -p $OUTPUT_DIR/hifiasm_ref $NUCMER_DIR/hifiasm_ref.delta
 apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
 mummerplot --png --layout --large -p $OUTPUT_DIR/lja_ref $NUCMER_DIR/lja_ref.delta
 apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
 mummerplot --png --layout --large -p $OUTPUT_DIR/flye_hifiasm $NUCMER_DIR/flye_hifiasm.delta
 apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
 mummerplot --png --layout --large -p $OUTPUT_DIR/hifiasm_lja $NUCMER_DIR/hifiasm_lja.delta
 apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
 mummerplot --png --layout --large -p $OUTPUT_DIR/lja_flye $NUCMER_DIR/lja_flye.delta
