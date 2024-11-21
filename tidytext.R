options(repos = c(CRAN = "https://cloud.r-project.org"))

install.packages("tidyverse")
install.packages("tidytext")
install.packages("SnowballC")


library(tidyverse)
library(tidytext)
library(SnowballC)


data <- read_tsv("raw/article_info.tsv")




cleaned_titles <- data %>%
  unnest_tokens(word, Title) %>%
  filter(!word %in% stop_words$word) %>%  
  filter(!str_detect(word, "\\d"))  




cleaned_titles <- cleaned_titles %>%
  mutate(stemmed_word = wordStem(word))  


final_titles <- cleaned_titles %>%
  group_by(PMID, Year) %>%
  summarize(cleaned_title = paste(stemmed_word, collapse = " "), .groups = "drop")


head(final_titles)

write_tsv(final_titles, "clean/cleaned_article_info.tsv")

