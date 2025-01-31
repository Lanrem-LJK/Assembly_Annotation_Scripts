#!/usr/bin/env bash

#SBATCH --mail-user=bioljk@outlook.com         # 你的邮箱
#SBATCH --mail-type=end,fail
#SBATCH --partition=pibu_el8                  # SLURM 分区
#SBATCH --cpus-per-task=50                    # 分配 50 个 CPU 核心
#SBATCH --mem=10G                             # 分配 10GB 内存
#SBATCH --time=05:00:00                       # 运行时间上限 5 小时

#SBATCH --job-name=TEsorter                   # 作业名称
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/5_2_3_TEsorter_%j.o
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/5_2_3_TEsorter_%j.e

# Define output and input directories
course_dir=/data/users/jlan/assembly-annotation-course
tag="Brass_db"
output_dir=${course_dir}/EDTA_annotation/${tag}
mkdir -p ${output_dir}
cd ${output_dir}

# Keep COURSEDIR unchanged
COURSEDIR=/data/courses/assembly-annotation-course

# Define input file
input_dir=${COURSEDIR}/EDTA_annotation/
input_file=${input_dir}/Brassicaceae_repbase_all_march2019.fasta

# Run TEsorter (singularity container)
singularity exec \
--bind ${output_dir} \
--bind ${COURSEDIR} \
${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
TEsorter ${input_file} -db rexdb-plant -pre ${tag}
