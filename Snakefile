rule process_text_data:
    input:
        "raw/article_info.tsv"
    output:
        "clean/cleaned_article_info.tsv"
    conda:
        "envs/ahds_assessment.yml"
    script:
        "tidytext.R"

