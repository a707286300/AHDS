Applied Health Data Science Summative Assessment
This repository contains the code and pipeline for the summative assessment for the Applied Health Data Science unit in the MSc in Medical Statistics and Health Data Science program.

Environment
This code was run on a Windows, in bash and R version 4.4.2.

It was also run on bluecrystal4.

The R environment is recorded in the ahds_environment.yml file in this directory. To create this environment in Conda, use:

conda env create --file ahds_environment.yml
conda activate ahdsenv

Note that this environment was initially created with:

conda create -n ahdsenv
conda activate ahdsenv
conda install r-base=4.4.2 r-tidyverse=2.0.0 
conda export --from-history > ahds_enviroenment.yml

Description of the data
The data used in this analysis is retrieved from PubMed via its API using a pipeline built with Bash scripts, R, and Snakemake. This data consists of article metadata such as PubMed IDs (PMIDs), publication years, and article titles.

Structure of the Data
1. Article Metadata
Description: This dataset contains metadata for academic articles retrieved from PubMed based on a query for "Long COVID".
Data File: clean/article_info.tsv
File Structure:
The file is tab-separated and contains the following columns:
PMID: The unique identifier for the article in PubMed.
Year: The year of publication.
Title: The title of the article.
2. Processed Tokens
Description: After text processing, the article titles are tokenized and cleaned for further analysis.
Data File: Intermediate processing generates cleaned tokens used in word frequency analysis.
3. Word Frequency Analysis
Description: This dataset contains the frequency of words appearing in article titles, grouped by year.
Data File: plot/word_frequency_plot.png (visualization output).

Pipeline Overview
The pipeline consists of four steps to process the data:

Step 1: Retrieve PMIDs from PubMed based on the query "Long COVID".
Step 2: Use the retrieved PMIDs to download article metadata, including titles and publication years.
Step 3: Process the titles to clean and tokenize the text, removing stop words and non-informative tokens.
Step 4: Perform word frequency analysis on the processed tokens and visualize the results.


