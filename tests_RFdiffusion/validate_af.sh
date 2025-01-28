#!/bin/bash

# from https://github.com/YoshitakaMo/localcolabfold

COLABFOLD_PATH=/home/domain/vladislove2020/ColabFold/colabfold_batch/colabfold-conda/bin/
AF_DB_PATH=/home/domain/data/geraseva/alphafold_db/
PATH="$COLABFOLD_PATH:$PATH"

for pot in no_potential nc_potential dmasif_potential nc_dmasif_potential;
do
  mkdir af_predictions/$pot
  
  $COLABFOLD_PATH/colabfold_search ligandmpnn_output/$pot/all_seqs.fasta $AF_DB_PATH af_predictions/$pot/msas

#  $COLABFOLD_PATH/colabfold_batch af_predictions/$pot/msas af_predictions/$pot/structures

done


