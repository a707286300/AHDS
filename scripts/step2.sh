#!/bin/bash
# Define the output file path
output_file="clean/article_info.tsv"

# Create the output directory
mkdir -p clean
# Add the header row to the output file
echo -e "PMID\tYear\tTitle" > $output_file

# Loop through all PMIDs extracted from the input XML
for pmid in $(grep -oP '(?<=<Id>)[0-9]+(?=</Id>)' raw/data/pmids.xml); do
    article_xml=$(curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=${pmid}&retmode=xml")
# Extract the article title from the XML 
    title=$(echo "$article_xml" | grep -oP '(?<=<ArticleTitle>)[^<]+' | sed 's/<[^>]*>//g')
# Extract the publication year from the XML
    year=$(echo "$article_xml" | grep -oP '(?<=<PubDate><Year>)[0-9]{4}(?=</Year>)')

    echo "Processing PMID: $pmid"
    echo "Title: $title"
    echo "Year: $year"
    
#if both title and year are not empty
    if [ -n "$title" ] && [ -n "$year" ]; then
        echo -e "$pmid\t$year\t$title" >> $output_file
    else
# Skip the current PMID
        echo "Skipping PMID: $pmid due to missing title or year."
    fi
done

echo "Processing completed. Results stored in $output_file."
