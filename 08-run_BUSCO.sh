#!/usr/bin/env bash
  
#SBATCH --time=1-10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=BUSCO
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/BUSCO.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/BUSCO.err

WORKDIR=/data/users/jlan/assembly-annotation-course

OUTPUT_DIR=$WORKDIR/BUSCO

flye="$WORKDIR/Assembly/flye/assembly.fasta"
hifiasm="$WORKDIR/Assembly/hifiasm/assembly.fa"
lja="$WORKDIR/Assembly/lja/assembly.fasta"
trinity="$WORKDIR/Assembly/trinity.Trinity.fasta"

mkdir -p $OUTPUT_DIR

busco () {
    local input=$1
    local output=$2 
    local mode=$3

    apptainer exec \
    --bind $WORKDIR \
    /containers/apptainer/busco_5.7.1.sif \
    busco --in ${input} --out ${output} --mode ${mode} --lineage brassicales_odb10 --out_path ${OUTPUT_DIR} 
}

busco ${flye} "flye_BUSCO" "genome"
busco ${hifiasm} "hifiasm_BUSCO" "genome"
busco ${lja} "lja_BUSCO" "genome"
busco ${trinity} "trinity_BUSCO" "transcriptome"
