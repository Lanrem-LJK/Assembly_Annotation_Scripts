#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=64G
#SBATCH --nodes=1
#SBATCH --time=7-00:00:00
#SBATCH --job-name=MAKER
#SBATCH --mail-user=bioljk@outlook.com
#SBATCH --mail-type=ALL
#SBATCH --output=/data/users/jlan/assembly-annotation-course/out/MAKER/MAKER_%j.out
#SBATCH --error=/data/users/jlan/assembly-annotation-course/out/MAKER/MAKER_%j.err
#SBATCH --partition=pibu_el8

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/jlan/assembly-annotation-course"
CONTAINERDIR="/data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif"

REPEATMASKER_DIR="/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"
export PATH=$PATH:"/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"

module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a

mpiexec --oversubscribe -n 50 apptainer exec \
       	--bind $SCRATCH:/TMP --bind $COURSEDIR --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR \
	${COURSEDIR}/containers/MAKER_3.01.03.sif \
	maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_evm.ctl maker_exe.ctl 
