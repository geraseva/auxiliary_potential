#!/bin/bash

mkdir dssp_statistics_p0
for i in no_potential nc_potential dmasif_potential nc_dmasif_potential; # no_potential nc_potential dmasif_potential nc_dmasif_potential
do
  mkdir dssp_statistics_p0/$i
  for f in `ls rfdiffusion_outputs_p0/$i | grep pdb`
  do 
    dssp -i rfdiffusion_outputs_p0/$i/$f -o dssp_statistics_p0/$i/$f.dssp
  done
done