#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=14g
#SBATCH --time=48:00:00
#SBATCH --account=djbrang0
#SBATCH --partition=standard
#SBATCH --mail-type=BEGIN,END,FAIL

# Dynamically include SUBJID in log filenames
#SBATCH --output=logs/slurm-%x-%j.out
#SBATCH --error=logs/slurm-%x-%j.err

# Load necessary modules
module load freesurfer/7.4.1

# Define directories
SUBJECTS_DIR="/nfs/turbo/lsa-psyc-djbrang/Freesurfer/Faceread_main/FSrecon_Nov24/"
PROJ_DIR="/nfs/turbo/lsa-psyc-djbrang/Freesurfer/Faceread_main/_FsFastInput/"
# FSFAST_PARFILES_DIR="/nfs/turbo/lsa-psyc-djbrang/Freesurfer/Faceread_main/FsFastParFiles/${SUBJECT_ID}"
BOLD_FSD="bold"
TR=0.8
WINDOW=15  # Event-related window size in seconds

subarray=(
    "SUB_2" "SUB_3" "SUB_4" "SUB_7" "SUB_8" "SUB_9"
    "SUB_10" "SUB_11" "SUB_12" "SUB_13" "SUB_14" "SUB_15"
    "SUB_16" "SUB_17" "SUB_18" "SUB_19" "SUB_22" "SUB_24"
    "SUB_25" "SUB_27" "SUB_28" "SUB_29" "SUB_30" "SUB_31"
    "SUB_33" "SUB_38" "SUB_39" "SUB_41" "SUB_44" "SUB_45"
    "SUB_47" "SUB_48" "SUB_49" "SUB_50" "SUB_51" "SUB_52"
    "SUB_54" "SUB_55" "SUB_56" "SUB_57" "SUB_60" "SUB_61"
    "SUB_62" "SUB_63" "SUB_64" "SUB_66" "SUB_67" "SUB_68"
    "SUB_71" "SUB_72" "SUB_73" "SUB_74" "SUB_76" "SUB_77"
    "SUB_78" "SUB_79" "SUB_80" "SUB_81" "SUB_82" "SUB_83"
    "SUB_84" "SUB_86" "SUB_87"
)

# Change to project directory
cd ${PROJ_DIR} || exit

# Run preproc-sess
preproc-sess \
    -sf sessionID.txt \
    -fsd bold \
    -surface fsaverage lhrh \
    -mni305 \
    -fwhm 0 \
    -nostc \
    -per-run -force