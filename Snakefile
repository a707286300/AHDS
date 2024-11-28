rule all:
    input:
        "clean/visualisation.png"

rule step1:
    output:
        "raw/data/pmids.xml"
    shell:
        """
        bash scripts/step1.sh
        """

rule step2:
    input:
        "raw/data/pmids.xml"
    output:
        "clean/article_info.tsv"
    shell:
        """
        bash scripts/step2.sh
        """

rule tidytext:
    input:
        "clean/article_info.tsv"
    output:
        "clean/cleaned_article_info.tsv"
    shell:
        "Rscript scripts/tidytext.R"


rule visualisation:
    input:
        "clean/cleaned_article_info.tsv"
    output:
        "clean/visualisation.png"
    shell:
        "Rscript scripts/visualisation.R"

