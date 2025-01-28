#!/bin/bash

LIGANDMPNN_PATH=../LigandMPNN/
WD=`pwd`

mkdir ligandmpnn_output

for pot in no_potential nc_potential dmasif_potential nc_dmasif_potential ; # no_potential nc_potential dmasif_potential nc_dmasif_potential
do

  # generate json files for ligandmpnn multiple run"
  cd $WD
  pdb_ids=$WD/ligandmpnn_output/${pot}_ids.json
  redesigned_residues=$WD/ligandmpnn_output/${pot}_res.json
  echo { > ${pdb_ids}
  echo { > ${redesigned_residues}

  itdir=$WD/rfdiffusion_outputs/$pot
  for pdb in `ls $itdir | grep pdb` ;
  do
    if [ -f $WD/dssp_statistics/${pot}/${pdb}.dssp ]
    then
      echo \"$itdir/$pdb\": \"\", >> ${pdb_ids}
      echo \"$itdir/$pdb\": \"$(cat $itdir/$pdb | grep 'CA  GLY A' | awk 'BEGIN{OFS="";ORS=" "}{print $5, $6}' | sed 's/\ $//' )\", >> ${redesigned_residues}
    fi
  done

  tmp=`cat ${pdb_ids} | sed '$ s/\,$/\n}/'`
  echo $tmp > ${pdb_ids}
  tmp=`cat ${redesigned_residues} | sed '$ s/\,$/\n}/'`
  echo $tmp > ${redesigned_residues}

  # run ligandmpnn
  cd $LIGANDMPNN_PATH
  python3 run.py \
    --pdb_path_multi ${pdb_ids} \
    --out_folder $WD/ligandmpnn_output/$pot \
    --model_type "protein_mpnn" \
    --batch_size 5 --pack_side_chains 0 \
    --redesigned_residues_multi ${redesigned_residues}

   #write ligandmpnn outputs to a single file
  for pdb in `ls ligandmpnn_output/${pot}/seqs | grep fa` ;
  do
    echo $pdb
    cat ligandmpnn_output/${pot}/seqs/${pdb} | awk '{print $1, $2}' | grep id= -A 1 | sed 's/,\ id=/_/' | sed 's/,//' >> ligandmpnn_output/${pot}/all_seqs.fasta   
  done
done

