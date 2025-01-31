#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=64G
#SBATCH --time=7-00:00:00
#SBATCH --job-name=MAKER_config
#SBATCH --mail-user=bioljk@outlook.com
#SBATCH --mail-type=ALL
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/MAKER_config.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/MAKER_config.err
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/jlan/assembly-annotation-course/MAKER"

mkdir $WORKDIR

cd $WORKDIR

apptainer exec --bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker -CTL \
