library("OmicsPLS")
library(magrittr) # needs to be run every time you start R and want to use %>%
library(ggplot2)

set.seed(123)

crossval_o2m(tax2, df_rna2, 2:5,1:3,1:3,nr_folds = 10) 
modelfit<-o2m(tax2, df_rna2, 2, 3, 2) 
print (modelfit)

xj<- loadings(modelfit, "Xjoint", 1:2) %>% abs %>% rowSums
xj[-(order(xj,decreasing=T)[1:5])] = 0
xj <- sign(xj)
print(xj)

plot1<-plot(modelfit, loading_name="Xj", i=1, j=2, label = "c", use_ggplot2 = TRUE,
            
            alpha = xj,
            
            aes(label = stringr::str_sub(colnames(tax2), start = 1)),size=4,col='red')+
  
  theme_bw() +
  
  coord_fixed(1, c(-1,1),c(-1,1)) +
  
  geom_point(alpha = 0.5+0.5*xj, col = 'blue',size=1.5) +
  
  labs(title = "taxonomy joint loadings",
       
       x = "First Joint Loadings", y = "Second Joint Loadings") +
  
  theme(plot.title = element_text(face='bold'))
plot1
graphics.off()


yj<- loadings(modelfit, "Yjoint", 1:2) %>% abs %>% rowSums
yj[-(order(yj,decreasing=T)[1:10])] = 0
yj <- sign(yj)

plot2<-plot(modelfit, loading_name="Yj", i=1, j=2, label = "c", use_ggplot2 = TRUE,
            
            alpha = yj,
            
            aes(label = stringr::str_sub(colnames(df_rna2), start = 1)),size=4,col='red')+
  
  theme_bw() +
  
  coord_fixed(1, c(-1,1),c(-1,1)) +
  
  geom_point(alpha = 0.5+0.5*yj, col = 'blue',size=1.5) +
  
  labs(title ="hostgene joint loadings",
       
       x = "First Joint Loadings", y = "Second Joint Loadings") +
  
  theme(plot.title = element_text(face='bold'))
plot2
