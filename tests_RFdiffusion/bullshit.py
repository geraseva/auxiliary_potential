import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument( "--pdbdir", type=str, default='rfdiffusion_outputs/dmasif_potential', help='The name of a directory of pdbs to run through' )
parser.add_argument( "--list", action='store_true', help='Return list of bullshit files' )

args = parser.parse_args( )

from Bio import PDB
import os

count=0
bullshit=0

gen_dir=args.pdbdir
list_files=[]
for file in os.listdir(gen_dir):
    if file[-4:]!='.pdb':
        continue
    count+=1
    parser = PDB.PDBParser(QUIET=True)
    try:
        struct = parser.get_structure('pr', f'{gen_dir}/{file}')
        residues=list(struct[0]['A'].get_residues())
        for i in range(len(residues)-1):
            if (residues[i]['CA']-residues[i+1]['CA'])>5:
                bullshit+=1
                list_files.append(file)
            break
    except:
        bullshit+=1
        list_files.append(file)
if args.list:
    for file in list_files:
        print(file)
else:
    print('Total:',count)
    print('Bullshit:',bullshit)
    print(f'Shitty: {bullshit/count*100}%')

