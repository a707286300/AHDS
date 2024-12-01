#!/bin/bash

# Exit if any command fails
set -e

# SLURM Job Submission Directives
#SBATCH --job-name=AHDS        
#SBATCH --partition=teach_cpu           
#SBATCH --nodes=1                       
#SBATCH --ntasks=1                     
#SBATCH --cpus-per-task=1                
#SBATCH --mem=16G                        
#SBATCH --time=12:00:00                  
#SBATCH --output=AHDS%j.log     
#SBATCH --account=SSCM033324

echo "Job started on $(date)"  

# Conda environment
source ~/initConda.sh
conda activate ahds_env

snakemake

