#!/bin/bash
output_file="../clean/article_info.tsv"
mkdir -p ../clean
echo -e "PMID\tYear\tTitle" > $output_file

# 获取所有 PMID
pmid_list=$(sed -n 's:.*<Id>\([0-9]\+\)</Id>.*:\1:p' ../raw/data/pmids.xml | tr '\n' ',' | sed 's/,$//')

# 批量获取数据
article_xml=$(curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=${pmid_list}&retmode=xml")

# 解析并写入数据
echo "$article_xml" | sed -n '
  /<PubmedArticle>/,/<\/PubmedArticle>/{
    s:.*<PMID.*>\([0-9]\+\)</PMID>.*:\1:p
    s:.*<Year>\([0-9]\+\)</Year>.*:\1:p
    s:.*<ArticleTitle>\(.*\)</ArticleTitle>.*:\1:p
    /<\/PubmedArticle>/{
      x
      s/\n/\t/g
      p
      d
    }
    H
  }' >> $output_file

echo "Processing completed. Results stored in $output_file."


