#!/bin/bash

RFDIFFUSION_PATH=../RFdiffusion/scripts

declare -A pdb_dict
pdb_dict[pd_l1]="inference.input_pdb=input_pdbs/5O45.pdb"
pdb_dict[il_7ra]="inference.input_pdb=input_pdbs/3DI3.pdb"
pdb_dict[insr]="inference.input_pdb=input_pdbs/4ZXB.pdb"
pdb_dict[trka]="inference.input_pdb=input_pdbs/1WWW.pdb"
pdb_dict[ih]="inference.input_pdb=input_pdbs/5VLI.pdb"

declare -A contig_dict
contig_dict[pd_l1]='contigmap.contigs=[A17-145/0 70-100]'
contig_dict[il_7ra]='contigmap.contigs=[B17-209/0 70-100]'
contig_dict[insr]='contigmap.contigs=[E1-150/0 70-100]'
contig_dict[trka]='contigmap.contigs=[X282-382/0 70-100]'
contig_dict[ih]='contigmap.contigs=[B501-670/0 70-100]'

declare -A pot_dict
pot_dict[no_potential]=""
pot_dict[nc_potential]='potentials.guiding_potentials=["type:interface_ncontacts,weight:0.5"]'
pot_dict[dmasif_potential]='potentials.guiding_potentials=["type:dmasif_interactions,non_int_weight:10,int_weight:1"]'
pot_dict[nc_dmasif_potential]='potentials.guiding_potentials=["type:dmasif_interactions,non_int_weight:10,int_weight:1","type:interface_ncontacts,weight:0.5"]'

declare -A hotspot_dict
hotspot_dict[pd_l1]='ppi.hotspot_res=[A56,A115,A123]'
hotspot_dict[il_7ra]='ppi.hotspot_res=[B58,B80,B139]'
hotspot_dict[insr]='ppi.hotspot_res=[E58,E88,E96]'
hotspot_dict[trka]='ppi.hotspot_res=[X294,X296,X333]'
hotspot_dict[ih]='ppi.hotspot_res=[B521,B545,B552]'

for pdb in pd_l1 il_7ra insr trka ih; # pd_l1 il_7ra insr trka ih
do
  #no_potential nc_potential dmasif_potential nc_dmasif_potential
  for pot in no_potential nc_potential dmasif_potential nc_dmasif_potential; 
 do
    echo $pdb $pot
    $RFDIFFUSION_PATH/run_inference.py inference.num_designs=200 inference.output_prefix=rfdiffusion_outputs_p0/$pot/$pdb \
      ${pot_dict[$pot]} ${pdb_dict[$pdb]} ${hotspot_dict[$pdb]} "${contig_dict[$pdb]}" 
  done
done 