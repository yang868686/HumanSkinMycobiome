library(SpiecEasi)
library(ggClusterNet)
library(tidyverse)
library(phyloseq)


data<-read.csv("df.txt",sep = "\t",header = TRUE)

result<-sparcc(data, iter = 20, inner_iter = 10, th = 0.1)

write.csv(result,"corr.txt",sep="\t")


p_value<-sparccboot(
  data,
  sparcc.params = list(),
  statisticboot = function(data, indices) triu(do.call("sparcc", c(list(data[indices,
                                                                             drop = FALSE]), sparcc.params))$Cor),
  statisticperm = function(data, indices) triu(do.call("sparcc",
                                                       c(list(apply(data[indices, ], 2, sample)), sparcc.params))$Cor),
  R,
  ncpus = 1,
  pval.sparccboot
)


write.csv(p_value,"p.txt",sep="\t")
