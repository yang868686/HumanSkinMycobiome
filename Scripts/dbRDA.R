library(vegan)
library("BiodiversityR")
library(ggordiplots)
library(ggforce)

erie_bray<-phyloseq::distance(funga_ps,method='bray')
dbrda1 = vegan::dbrda(erie_bray~group + Condition(institution + age + sex + batch_id ), data = sampledf, na.action = na.omit) 

my_plot <- ggordiplots::gg_ordiplot(dbrda1, groups = sampledf$group, spiders = TRUE, conf = 0.95, pt.size = 0)
ordiplot <- my_plot$plot

ordiplot + geom_vline(xintercept = c(0), color = "grey70", linetype = 2) +
  geom_hline(yintercept = c(0), color = "grey70", linetype = 2) +  
  scale_x_continuous(sec.axis = dup_axis(labels=NULL, name=NULL), limits = c(-2,2)) +
  scale_y_continuous(sec.axis = dup_axis(labels=NULL, name=NULL), limits = c(-1.5,1.5)) +    
  geom_mark_ellipse(data=dat, #my_plot$df_ellipse
                    mapping=aes(x=x, y=y, colour=Group, 
                        fill=after_scale(alpha(colour, 0.2))), 
                    expand=0, size=0.2, show.legend=FALSE) +
  geom_segment(dat2,  #my_plot$df_spiders
               mapping=aes(x = cntr.x, xend = x, y = cntr.y, yend = y, color = Group), 
               size=1.5, show.legend=TRUE) +
  theme(
    panel.background = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.line = element_line("black"),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    text = element_text(size = 12),
    axis.text = element_text(size = 10, colour = "black"),
    axis.title = element_text(size = 14, colour = "black"),
    legend.title = element_text(size = 14),
    plot.title = element_text(hjust = 0.5,  face = "bold")) +
  scale_color_brewer(palette = "Dark2") +
  xlab(paste0("dbRDA1, ", round(summary(dbrda1)$cont$importance[2,1],3)*100, "%")) + 
  ylab(paste0("dbRDA2, ", round(summary(dbrda1)$cont$importance[2,2],3)*100, "%"))
