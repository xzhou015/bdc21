#load library
library(quanteda)
library(ggplot2)
library(ggthemes)
library(tidytext)
library(glmnet)
library(readxl)
library(writexl)
real_news_05<-read.csv("NewsRealCOVID-19_05.csv")
real_news_07<-read.csv("NewsRealCOVID-19_07.csv")
real_news_09<-read.csv("NewsRealCOVID-19_09.csv")
real_news_11<-read.csv("NewsRealCOVID-19_11.csv")


real_news_05 <- data.frame(lapply(real_news_05, as.character), stringsAsFactors=FALSE)

realCorpus_05 <- corpus(real_news_05$content, docvars = real_news_05)
realCorpus_05<-tokens(realCorpus_05, what = "word1")
#prepare document for analysis
real_dfmtweet_05<-dfm(realCorpus_05,
              tolower = T,
              remove_numbers=T,
              remove_punct=T,
              remove_symbol=T,
              remove = stopwords("en"))
              #remove stopwords: justified as they contain nothing about sentiment)
real_doc_freq_05 <- docfreq(real_dfmtweet_05)


real_news_05 <- data.frame(lapply(real_news_05, as.character), stringsAsFactors=FALSE)

realCorpus_05 <- corpus(real_news_05$content, docvars = real_news_05)
realCorpus_05<-tokens(realCorpus_05, what = "word1")
#prepare document for analysis
real_dfmtweet_05<-dfm(realCorpus_05,
                      tolower = T,
                      remove_numbers=T,
                      remove_punct=T,
                      remove_symbol=T,
                      remove = stopwords("en"))
#remove stopwords: justified as they contain nothing about sentiment)
real_doc_freq_05 <- docfreq(real_dfmtweet_05)





write_xlsx(doc_freq_dataframe,"doc_freq.xlsx")

library(jiebaR)

cutter=worker()
segWords<-segment(tweet$title, cutter)
segWords<-filter_segment(segWords, stopwords("en"))

library(plyr)
tableWord<-count(segWords)
write_xlsx(tableWord,"doc_freq.xlsx")


