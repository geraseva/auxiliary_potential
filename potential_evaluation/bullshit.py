import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument( "-pdbdir", type=str, default='rfdiffusion_outputs/dmasif_potential', help='The name of a directory of pdbs to run through' )
args = parser.parse_args( )

from Bio import PDB
import os

count=0
bullshit=0

gen_dir=args.pdbdir
for file in os.listdir(gen_dir):
    if file[-4:]!='.pdb':
        continue
    count+=1
    parser = PDB.PDBParser(QUIET=True)
    struct = parser.get_structure('pr', f'{gen_dir}/{file}')
    residues=list(struct[0]['A'].get_residues())
    for i in range(len(residues)-1):
        if (residues[i]['CA']-residues[i+1]['CA'])>5:
            bullshit+=1

print('Total:',count)
print('Bullshit:',bullshit)
print(f'Shitty: {bullshit/count*100}%')

