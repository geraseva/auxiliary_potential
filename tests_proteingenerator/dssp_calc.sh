#!/bin/bash

mkdir outputs/dssp_statistics
for i in dmasif_potential_t5; # no_potential  dmasif_potential 
do
  mkdir outputs/dssp_statistics/$i
  for f in `ls outputs/proteingenerator_outputs/$i | grep pdb`
  do 
    /home/domain/anur/progs/bin/dsspcmbi outputs/proteingenerator_outputs/$i/$f outputs/dssp_statistics/$i/$f.dssp
  done
done