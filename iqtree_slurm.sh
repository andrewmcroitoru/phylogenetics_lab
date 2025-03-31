#!/bin/bash

#SBATCH --time=12:00:00   # job time limit
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=1   # number of tasks per node
#SBATCH --cpus-per-task=4   # number of CPU cores per task
#SBATCH --mem=16G   # memory
#SBATCH --partition=standard   # partition
#SBATCH --account=cobi   # allocation name
#SBATCH -o /scratch/amc6xa/random_slurm_outs/16s_%A.out

#### 1) Align the 16s sequences using MAFFT 
module load gcc/11.4.0 # required for MAFFT
module load openmpi/4.1.4 # required for MAFFT
module load mafft/7.505 # MAFFT already installed on Rivanna

seqs_path="$HOME/amc6xa/comp_bio_a06/16s.fasta"
aligned_seqs_out_path="$HOME/amc6xa/comp_bio_a06/ALIGNED_16s.fasta"

time mafft $seqs_path > $aligned_seqs_out_path


#### 2) Use iqtree to compute the maximum-likelihood tree using all default parameters
module load iqtree/2.2.0.3

num_threads=4
mem="16G"
model="MFP" # selects the best model
output_prefix="16s_IQTREE_OUT_"

iqtree -s $aligned_seqs_out_path -m $model -pre $output_prefix -nt $num_threads -mem $mem --verbose
