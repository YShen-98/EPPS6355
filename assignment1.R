# 1. Install and load necessary packages
if (!require("quanteda")) install.packages("quanteda")
if (!require("quanteda.textplots")) install.packages("quanteda.textplots")

library(quanteda)
library(quanteda.textplots)

# 2. my dataset is in RTF
install.packages("readtext")
library(readtext)
ML500 <- readtext("data/*.rtf")

# 3.Create a quanteda Corpus object
my_corpus <- corpus(
  ML500$text,
  docnames = ML500$doc_id
)

# 4. Tokenization: in my case i need numeric data
my_tokens <- tokens(
  my_corpus,
  remove_punct = TRUE,
  remove_symbols = TRUE,
) %>%
  tokens_tolower()

# 5. Remove stopwords: in my case i may need some of them
my_stopwords <- setdiff(
  stopwords("en"),
  c("not", "no", "nor",
    "can", "could", "may", "might",
    "should", "must")
)

my_tokens <- tokens_remove(
  my_tokens,
  pattern = my_stopwords
)

# 6. Generate the Document-Feature Matrix (DFM)
my_dfm <- dfm(my_tokens)
print(my_dfm)

# 7. Plot a basic wordcloud of the most frequent features to verify
textplot_wordcloud(my_dfm, max_words = 100, color = "blue")
                   
                   
