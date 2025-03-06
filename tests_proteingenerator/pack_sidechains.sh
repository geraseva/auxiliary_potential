#!/bin/bash

source /home/domain/data/prog/miniconda3/etc/profile.d/conda.sh
conda activate pyrosetta

for pot in dmasif_potential_t5 ; # no_potential nc_potential dmasif_potential nc_dmasif_potential
do
  mkdir outputs/relaxed
  mkdir outputs/relaxed/${pot}
  python ../utils/fast_relax.py -pdbdir outputs/proteingenerator_outputs/${pot} \
  -outdir outputs/relaxed/${pot} -parallel 
done

conda deactivate

