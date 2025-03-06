#!/bin/bash

source /home/domain/data/prog/miniconda3/etc/profile.d/conda.sh
conda activate proteingenerator

PROTEINGENERATOR_PATH=../protein_generator

declare -A pdb_dict
pdb_dict[pd_l1]="../input_pdbs/5O45.pdb"
pdb_dict[il_7ra]="../input_pdbs/3DI3.pdb"
pdb_dict[insr]="../input_pdbs/4ZXB.pdb"
pdb_dict[trka]="../input_pdbs/1WWW.pdb"
pdb_dict[ih]="../input_pdbs/5VLI.pdb"

declare -A contig_dict
contig_dict[pd_l1]='A17-145 70-100'
contig_dict[il_7ra]='B17-209 70-100'
contig_dict[insr]='E1-150 70-100'
contig_dict[trka]='X282-382 70-100'
contig_dict[ih]='B501-670 70-100'

declare -A hotspot_dict
hotspot_dict[pd_l1]='A56,A115,A123'
hotspot_dict[il_7ra]='B58,B80,B139'
hotspot_dict[insr]='E58,E88,E96'
hotspot_dict[trka]='X294,X296,X333'
hotspot_dict[ih]='B521,B545,B552'

declare -A pot_dict
pot_dict[no_potential]=""
pot_dict[dmasif_potential_t5]='--potentials dmasif_interactions --potential_scale 10.0'

mkdir proteingenerator_outputs
for pdb in pd_l1 il_7ra insr trka ih ; # pd_l1 il_7ra insr trka ih
do
  for pot in dmasif_potential_t5; # no_potential; 
 do
    echo $pdb $pot
    mkdir outputs/proteingenerator_outputs/$pot

    python $PROTEINGENERATOR_PATH/inference.py --out outputs/proteingenerator_outputs/$pot/$pdb \
    --pdb ${pdb_dict[$pdb]} --contigs ${contig_dict[$pdb]} ${pot_dict[$pot]} --T 25 --save_best_plddt \
    --num_designs 250 --start_num 0 # --hotspots ${hotspot_dict[$pdb]}
  done
done 

conda deactivate