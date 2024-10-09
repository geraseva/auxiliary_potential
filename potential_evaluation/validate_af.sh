#!/bin/bash

COLABFOLD_PATH=/home/domain/vladislove2020/ColabFold/colabfold_batch/colabfold-conda/bin/
AF_DB_PATH=/home/domain/data/geraseva/alphafold_db/

echo "generate fasta_file"
mkdir af_predictions

# write ligandmpnn outputs to a single file

#for pot in no_potential nc_potential dmasif_potential nc_dmasif_potential ; # no_potential nc_potential dmasif_potential nc_dmasif_potential
#do
#  for pdb in `ls ligandmpnn_output/$pot/seqs | grep fa` ;
#  do
#    cat ligandmpnn_output/$pot/seqs/$pdb | awk '{print $1, $2}' | grep id= -A 1 | sed 's/,\ id=/_/' | sed "s/>/>${pot}_/" | sed 's/,//' >> proteinmpnn_output/all_seqs.fasta   
#  done
#done

PATH="$COLABFOLD_PATH:$PATH"

$COLABFOLD_PATH/colabfold_search ligandmpnn_output/all_seqs.fasta $AF_DB_PATH af_predictions/msas

$COLABFOLD_PATH/colabfold_batch af_predictions/msas af_predictions/structures