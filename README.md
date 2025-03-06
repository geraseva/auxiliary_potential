# Auxiliary potential

This is a repo containing tests of a complex DL auxiliary potential for RFdiffusion. 

## Installation

```
git clone https://github.com/geraseva/auxiliary_potential
cd auxiliary_potential
git clone https://github.com/geraseva/masif_martini
```
## Protein generator implementation

```
git clone https://github.com/geraseva/protein_generator
cd protein_generator

# get protein_generator weights
wget http://files.ipd.uw.edu/pub/sequence_diffusion/checkpoints/SEQDIFF_230205_dssp_hotspots_25mask_EQtasks_mod30.pt -P model 
wget http://files.ipd.uw.edu/pub/sequence_diffusion/checkpoints/SEQDIFF_221219_equalTASKS_nostrSELFCOND_mod30.pt -P model'
```

Create conda environment for running protein_generator with auxiliary potentials
```
conda env create -f environment.yml
conda activate proteingenerator
pip install pykeops
```
Usage examples are in ```tests_proteingenerator/```

## For collaborators

Run the following to test:
```
mkdir tests_proteingenerator/outputs/
python protein_generator/inference.py --out outputs \
    --pdb input_pdbs/5O45.pdb --contigs A17-145 70-100 --T 25 --save_best_plddt \
    --num_designs 1 --start_num 0 --potentials dmasif_interactions --potential_scale 10.0
```

## RFDiffusion implementation
```
# clone submodules, or simply make a symlink if you already have some of them
git clone https://github.com/geraseva/RFdiffusion
git clone https://github.com/dauparas/LigandMPNN

# get RFdiffusion weights
cd RFdiffusion
mkdir models && cd models
wget http://files.ipd.uw.edu/pub/RFdiffusion/6f5902ac237024bdd0c176cb93063dc4/Base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/e29311f6f1bf1af907f9ef9f44b8328b/Complex_base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/60f09a193fb5e5ccdc4980417708dbab/Complex_Fold_base_ckpt.pt

# get LigandMPNN weights

cd ../LigandMPNN
bash get_model_params.sh "./model_params"
```

Create conda environment for running RFdiffusion with auxiliary potentials
```
cd ../RFdiffusion
conda env create -f env/SE3nv.yml

conda activate SE3nv
cd env/SE3Transformer
pip install --no-cache-dir -r requirements.txt
python setup.py install
cd ../.. # change into the root directory of the repository
pip install -e . # install the rfdiffusion module from the root of the repository

cd ../../LigandMPNN # install LigandMPNN requirements
pip install -r requirements.txt
```
Usage examples are in ```tests_RFdiffusion/```

