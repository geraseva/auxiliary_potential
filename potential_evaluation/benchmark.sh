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

declare -A hotspot_dict
hotspot_dict[pd_l1]='ppi.hotspot_res=[A56,A115,A123]'
hotspot_dict[il_7ra]='ppi.hotspot_res=[B58,B80,B139]'
hotspot_dict[insr]='ppi.hotspot_res=[E58,E88,E96]'
hotspot_dict[trka]='ppi.hotspot_res=[X294,X296,X333]'
hotspot_dict[ih]='ppi.hotspot_res=[B521,B545,B552]'

# Это код для подбора гиперпараметров потенциала
# надо подобрать такие параметры non_int_weight, int_weight, guide_scale, guide_decay,
# чтобы в результате получалось наименьшее кол-во буллшита
# (под буллшитом подразумевается взорванная структура, с улетевшими атомами)
#
# Очевидно, что если просто сделать non_int_weight и int_weight неизмеримо малым, то буллшита не будет
# но тогда не будет и влияния потенциала. надо как-то сбалансировать.

rm rfdiffusion_outputs/bullshit/*

# тут через цикл запускается генерация байндеров к 5 разным белкам
# можно попробовать распараллелить на несколько гпу, если они есть
# можно поставить inference.num_designs поменьше, тогда будет быстрее
# может зависать и вылетать, как правило, из-за буллшита
# при перезапуске кода уже рассчитанные файлы структур не пересчитываются

for pdb in pd_l1 il_7ra insr trka ih; # pd_l1 il_7ra insr trka ih
do
  $RFDIFFUSION_PATH/run_inference.py inference.num_designs=200 inference.output_prefix=rfdiffusion_outputs/bullshit/$pdb \
    ${pdb_dict[$pdb]} ${hotspot_dict[$pdb]} "${contig_dict[$pdb]}" \
    'potentials.guiding_potentials=["type:dmasif_interactions,non_int_weight:50,int_weight:50"] \
    potentials.guide_scale=2 potentials.guide_decay="quadratic"'
done

# тут результаты генерации проверяются на буллшитность
python3 bullshit.py -pdbdir rfdiffusion_outputs/bullshit