
rule download_articles:
    output:
        "raw/pmids.xml"
    shell:
        """
        curl "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=%22long%20covid%22&retmax=10000" > {output}
        """

rule process_xml:
    input:
        "raw/pmids.xml"
    output:
        "clean/articles.tsv"
    script:
        "tidytext.R"

rule process_titles:
    input:
        "clean/articles.tsv"
    output:
        "clean/clean_titles.tsv"
    script:
        "tidytext.R"

rule visualize_data:
    input:
        "clean/clean_titles.tsv"
    output:
        "visualisation/word_frequency.png"
    script:
        "visualisation.R"

