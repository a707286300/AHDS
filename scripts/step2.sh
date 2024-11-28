#!/bin/bash
output_file="../clean/article_info.tsv"
mkdir -p ../clean
echo -e "PMID\tYear\tTitle" > $output_file

for pmid in $(grep -oP '(?<=<Id>)[0-9]+(?=</Id>)' raw/data/pmids.xml); do
    article_xml=$(curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=${pmid}&retmode=xml")
    title=$(echo "$article_xml" | grep -oP '(?<=<ArticleTitle>)[^<]+' | sed 's/<[^>]*>//g')
    year=$(echo "$article_xml" | grep -oP '(?<=<PubDate><Year>)[0-9]{4}(?=</Year>)')

    echo "Processing PMID: $pmid"
    echo "Title: $title"
    echo "Year: $year"
    
    if [ -n "$title" ] && [ -n "$year" ]; then
        echo -e "$pmid\t$year\t$title" >> $output_file
    else
        echo "Skipping PMID: $pmid due to missing title or year."
    fi
done

echo "Processing completed. Results stored in $output_file."

