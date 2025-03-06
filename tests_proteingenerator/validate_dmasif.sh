#!/bin/bash

source /home/domain/data/prog/miniconda3/etc/profile.d/conda.sh
conda activate dmasif_upd

mkdir outputs/dmasif_output
for i in dmasif_potential no_potential; # no_potential nc_potential dmasif_potential nc_dmasif_potential
do
  mkdir outputs/dmasif_output/$i
  ls outputs/relaxed/$i/ | grep pdb | awk '{print $1,"B","A"}'> outputs/dmasif_output/$i.list
  python3 ../masif_martini/train_inf.py inference --experiment_name no_h_prot --na protein --no_h \
  --pdb_list outputs/dmasif_output/$i.list --data_dir outputs/relaxed/$i --out_dir outputs/dmasif_output/$i
done

conda deactivate