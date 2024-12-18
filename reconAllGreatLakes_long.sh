#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=7g
#SBATCH --time=24:00:00
#SBATCH --account=djbrang0
#SBATCH --partition=standard
#SBATCH --mail-type=BEGIN,END,FAIL

# Dynamically include SUBJID in log filenames
#SBATCH --output=logs/slurm-%x-%j.out
#SBATCH --error=logs/slurm-%x-%j.err

# Check if SUBJID is defined
if [ -z "$SUBJID" ]; then
  echo "Error: SUBJID is not defined"
  exit 1
fi

cd /scratch/djbrang_root/djbrang0/shared_data
mkdir -p subjects
rm -r /nfs/turbo/lsa-psyc-djbrang/Freesurfer/subjects_FS_741/$SUBJID
rm -r /nfs/turbo/lsa-psyc-djbrang/Freesurfer/subjects/$SUBJID
rm -r subjects/$SUBJID

module load freesurfer/7.4.1
export OMP_NUM_THREADS=12

recon-all -subjid $SUBJID -i "$SUBJID".nii* -all -parallel -openmp 12
segment_subregions thalamus --cross $SUBJID --threads 12
segment_subregions hippo-amygdala --cross $SUBJID --threads 12
cp -r subjects/$SUBJID /nfs/turbo/lsa-psyc-djbrang/Freesurfer/subjects_FS_741/
