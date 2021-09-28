install.packages("wordcloud")
library(wordcloud)

install.packages("RColorBrewer")
library(RColorBrewer)

install.packages("wordcloud2")
library(wordcloud2)

install.packages("tm")
library(tm)

#create corpus
docs <- Corpus(DirSource('/Users/peter/OneDrive/Mason/DAEN 690/tm'))

docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))

inspect(docs)

# create dtm
dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

#list the most frequent terms
findFreqTerms(dtm, lowfreq=60)
