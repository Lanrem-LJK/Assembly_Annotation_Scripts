#!/usr/bin/env bash

#SBATCH --mail-user=bioljk@outlook.com
#SBATCH --mail-type=end,fail
#SBATCH --partition=pibu_el8

#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=02:00:00

#SBATCH --job-name=grep
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/grep_groups.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/grep_groups.err

# Define input and output paths
course_dir=/data/users/jlan/assembly-annotation-course
    input_dir=${course_dir}/EDTA_annotation/
        input_file=${input_dir}/assembly.fasta.mod.EDTA.TElib.fa
    output_dir=${course_dir}/EDTA_annotation/
    mkdir -p ${output_dir}

# Loop over Gypsy and Copia
for tag in "Gypsy" "Copia"
do
    # Define and create output directory for each tag/superfamily
    tag_dir=${output_dir}/${tag}
    mkdir -p ${tag_dir}
        output_file=${tag_dir}/${tag}.fa
    # grep sequences from the fasta input using the tag/superfamily, remove the "--" lines
    grep -A1 ${tag} ${input_file} | grep -v -- "^--$" > ${output_file}
done