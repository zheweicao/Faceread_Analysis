
subarray=(
    "SUB_2" "SUB_3" "SUB_4" "SUB_7" "SUB_8"  "SUB_9"  
    "SUB_10" "SUB_11" "SUB_12" "SUB_13" "SUB_14" "SUB_15" 
    "SUB_16" "SUB_17" "SUB_18" "SUB_19" "SUB_22" "SUB_24" 
    "SUB_25" "SUB_27" "SUB_28" "SUB_29" "SUB_30" "SUB_31" 
    "SUB_33" "SUB_38" "SUB_39" "SUB_41" "SUB_44" "SUB_45" 
    "SUB_47" "SUB_48" "SUB_49" "SUB_50" "SUB_51" "SUB_52" 
    "SUB_54" "SUB_55" "SUB_56" "SUB_57" "SUB_60" "SUB_61" 
    "SUB_62" "SUB_63" "SUB_64" "SUB_66" "SUB_67" "SUB_68" 
    "SUB_71" "SUB_72" "SUB_73" "SUB_74" "SUB_76" "SUB_77" 
    "SUB_78" "SUB_79" "SUB_80" "SUB_81" "SUB_82" "SUB_83" 
    "SUB_84" "SUB_86" "SUB_87" "SUB_88"
)


UNIQNAME=zhewei

for SUBJID in "${subarray[@]}"; do

    cd /nfs/turbo/lsa-psyc-djbrang/Freesurfer/Faceread_main/_OrignialDataBackup/${SUBJID}
    scp t1spgr_208sl.nii $UNIQNAME@greatlakes-xfer.arc-ts.umich.edu:/scratch/djbrang_root/djbrang0/shared_data/${SUBJID}.nii
    cd $UNIQNAME@greatlakes-xfer.arc-ts.umich.edu:/scratch/djbrang_root/djbrang0/shared_data/

    cd /nfs/turbo/lsa-psyc-djbrang/Freesurfer/
    sbatch --job-name=fs_"${SUBJID}"  --export=SUBJID=${SUBJID} reconAllGreatLakes_long.sh
done


cd /nfs/turbo/lsa-psyc-djbrang/Freesurfer/Faceread_main
sbatch --job-name=FSFAST_PREPROC  FSFAST_Preproc_v1.sh