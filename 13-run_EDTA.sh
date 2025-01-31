#!/usr/bin/env bash
  
#SBATCH --time=5-10:00:00
#SBATCH --mem=80G
#SBATCH --cpus-per-task=20
#SBATCH --job-name=EDTA_annotation
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/EDTA.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/EDTA.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/EDTA_annotation
flye="/data/users/jlan/assembly-annotation-course/Assembly/flye/assembly.fasta"

cd $OUTPUT_DIR

apptainer exec -C --bind /data -H ${pwd}/work \
	--writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/EDTA_v1.9.6.sif \
 EDTA.pl \
 --genome $flye \
 --species others \
 --step all \
 --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \
 --anno 1 \
 --threads 20
