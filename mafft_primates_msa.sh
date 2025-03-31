#!/bin/bash

module load gcc/11.4.0 # required for MAFFT
module load openmpi/4.1.4 # required for MAFFT
module load mafft/7.505 # MAFFT already installed on Rivanna

cd ~/amc6xa/comp_bio_a06/
time mafft primate_mtdna.fasta > ALIGNED_primate_mtdna.fasta