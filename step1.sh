#!/bin/bash
mkdir -p raw/data
echo "Retrieving PubMed IDs..."
curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=%22long%20covid%22&retmax=10000" > raw/data/pmids.xml
echo "Extracting PubMed IDs from XML..."
pmids=$(grep -oP '(?<=<Id>)[0-9]+(?=</Id>)' raw/data/pmids.xml)
if [ -z "$pmids" ]; then
    echo "No PMIDs retrieved. Exiting."
    exit 1
fi

echo "Downloading article metadata..."
for pmid in $pmids; do
    echo "Processing PMID: $pmid"
    curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=${pmid}" > raw/data/article-data-${pmid}.xml
    sleep 1  
done

echo "Download complete"

