
library(psych)
library(corrplot)

cortest_psy_adj <- corr.test(df1, df2, method = "spearman", adjust = "fdr")
  moduleTraitCor<-round(cortest_psy_adj$r,2)
  moduleTraitPvalue<-round(cortest_psy_adj$p,2) 
  moduleTraitPvalue_adjust<-round(cortest_psy_adj$p.adj,digits = 2)
 
  
col<-colorRampPalette(c("blue","white","red"))(10)
corrplot(as.matrix(moduleTraitCor_res), method = "square",tl.cex = 0.4,col = col,tl.col = "black",
         p.mat=as.matrix(moduleTraitPvalue_adjust),
         sig.level = 0.05,
         insig = "blank",
  ) 
  dev.off()
