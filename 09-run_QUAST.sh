#!/usr/bin/env bash
  
#SBATCH --time=1-10:00:00
#SBATCH --mem=80G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=QUAST
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/QUAST.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/QUAST.err

WORKDIR=/data/users/jlan/assembly-annotation-course
reference=/data/courses/assembly-annotation-course/references

OUTPUT_DIR=$WORKDIR/QUAST

flye="$WORKDIR/Assembly/flye/assembly.fasta"
hifiasm="$WORKDIR/Assembly/hifiasm/assembly.fa"
lja="$WORKDIR/Assembly/lja/assembly.fasta"

mkdir -p $OUTPUT_DIR

apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py -o $OUTPUT_DIR/without_reference --eukaryote --est-ref-size 140000000 -l flye,hifiasm,LJA --threads 24 --large $flye $hifiasm $lja

apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py -o $OUTPUT_DIR/with_reference --eukaryote -l flye,hifiasm,LJA --threads 24 --large -r $reference/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -g $reference/TAIR10_GFF3_genes.gff $flye $hifiasm $lja
