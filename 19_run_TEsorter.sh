#!/usr/bin/env bash

#SBATCH --mail-user=bioljk@outlook.com         # 你的邮箱
#SBATCH --mail-type=end,fail
#SBATCH --partition=pibu_el8                  # 修改分区名称
#SBATCH --cpus-per-task=50                    # 使用 50 个 CPU 核心
#SBATCH --mem=10G                             # 分配 10GB 内存
#SBATCH --time=05:00:00                       # 作业运行时间上限为 5 小时

#SBATCH --job-name=TEsorter                   # 作业名称
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/5_2_2_TEsorter_%j.o
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/5_2_2_TEsorter_%j.e

# Define working directory
working_dir=/data/users/jlan/assembly-annotation-course/EDTA_annotation

# Define directory with the container (remains unchanged)
COURSEDIR=/data/courses/assembly-annotation-course

# Loop over Gypsy and Copia
for tag in "Gypsy" "Copia"
do
    tag_dir=${working_dir}/${tag}
        input_file=${tag_dir}/${tag}.fa
        cd ${tag_dir}

    # Run TEsorter (singularity container)
    singularity exec \
    --bind ${COURSEDIR} \
    --bind ${tag_dir} \
    ${COURSEDIR}/containers2/TEsorter_1.3.0.sif \
    TEsorter ${input_file} -db rexdb-plant -pre ${tag}
done
