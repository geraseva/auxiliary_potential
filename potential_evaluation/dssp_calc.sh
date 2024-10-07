#!/bin/bash

for i in no_potential nc_potential dmasif_potential nc_dmasif_potential
do
  mkdir $i
  for f in `ls rfdiffusion_outputs/$i | grep pdb`
  do 
    dssp -i rfdiffusion_outputs/$i/$f -o dssp_statistics/$i/$f.dssp
  done
done