#!/bin/bash

# Generate structures using RFdiffusion
./design_ppi.sh

# Calculate secondary structure statistics
./dssp_calc.sh

# Predict sequences using LigandMPNN
./get_sequence.sh

# Relax sidechains using FastRelax
./pack_sidechains.sh

# Calculate PPIs on surfaces using dMaSIF
./validate_dmasif.sh

# Predict structures by sequences using af/chai
./validate_af.sh
