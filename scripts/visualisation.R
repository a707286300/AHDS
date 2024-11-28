
library(tidyverse)
library(tidytext)


data <- read_tsv("clean/cleaned_article_info.tsv")


word_freq <- data %>%
  unnest_tokens(word, cleaned_title) %>%  
  count(Year, word, sort = TRUE) %>%      
  group_by(Year) %>%
  top_n(10, n)                           


ggplot(word_freq, aes(x = Year, y = n, fill = word)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Word Frequency Over Time",
       x = "Year",
       y = "Frequency",
       fill = "Word")

output_path <- "plot/word_frequency_plot.png"

# ggsave 
ggsave(output_path, 
       plot = last_plot(),  
       width = 10,         
       height = 6,        
       dpi = 300)         
