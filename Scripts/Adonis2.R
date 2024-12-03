library(vegan)
library (phyloseq)

options(stringsAsFactors=F)
rm(list=ls())

df=read.csv("df.csv", sep="\t",header=TRUE)
dataT<-as.data.frame(t(df))
dist <- vegdist(data, method="bray")

adonis_result_dis = adonis2(dist~group, data, permutations = 999)
adonis_result_dis
