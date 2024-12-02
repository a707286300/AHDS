Applied Health Data Science Summative Assessment
===

This repository contains the code and pipeline for the summative assessment for the Applied Health Data Science unit in the MSc in Medical Statistics and Health Data Science program.

Environment
===
This code was run on a Windows, in bash and R version 4.4.2.

It was also run on bluecrystal4.

Clone the repository:

git clone https://github.com/a707286300/AHDS.git

The R environment is recorded in the ahds_environment.yml file in this directory. To create this environment in Conda, use:

conda env create --file ahds_environment.yml
conda activate ahds_env

Note that this environment was initially created with:

conda create -n ahds_env
conda activate ahds_env
conda install r-base=4.4.2 r-tidyverse=2.0.0 
conda env export > ahds_enviroenment.yml

Description of the data
The data used in this analysis is retrieved from PubMed via its API using a pipeline built with Bash scripts, R, and Snakemake. This data consists of article metadata such as PubMed IDs (PMIDs), publication years, and article titles.

Running the Program
===
To run the entire pipeline, you can execucate: 
snakemake

If you want to do a commit run in BlueCrystal, run run.sh.
sbatch run.sh
Before running, check the config file to make sure the request data is correct.
In addition, single components can be run as follows:
snakemake raw/data/pmids.xml --cores 1 -p
snakemake clean/article_info.tsv --cores 1 -p
snakemake clean/cleaned_article_info.tsv --cores 1 -p
snakemake clean/visualisation.png --cores 1 -p

raw/data
Contains raw input data files retrieved from PubMed. These include:
pmids.xml

clean/
Contains processed data files generated during the pipeline execution. These include:
article_info.tsv

plot/
Contains visual outputs generated from the analysis. These include:
word_frequency_plot.png

Sripts/
Contains Bash and R scripts used in the analysis. These include:
step1.sh: Bash script to retrieve PubMed IDs and article metadata.
step2.sh: Bash script or R script to process raw XML files and extract relevant data.
visualisation.R: R script to generate plots based on the processed data.

Snakefile
The Snakemake workflow file, defining the pipeline steps, input/output dependencies, and scripts to be executed.

ahds_environment.yml
Conda environment configuration file, specifying the packages required to run the pipeline.



