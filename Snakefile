rule process_titles:
    input:
        "raw/article_info.tsv"
    output:
        "clean/cleand_article_info.tsv"
    script:
        "tidytext.R"

