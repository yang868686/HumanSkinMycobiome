pacman::p_load(tidyverse,microeco,magrittr)
library(phyloseq)

dataset <- microtable$new(sample_table = sample_table_ad,
                          otu_table = feature_table_ad,
                          tax_table = tax_table_ad )

lefse <- trans_diff$new(dataset = dataset, 
                        method = "lefse", 
                        group = "group", 
                        alpha = 0.05, 
                        lefse_subgroup = NULL)

head(lefse$res_diff)
all_results <- lefse$res_diff

write.csv(all_results, file="all_results.csv")

p_lef<-lefse$plot_diff_bar(use_number = 1:10, 
                    width = 0.8 ) +
  ggsci::scale_color_npg() +
  ggsci::scale_fill_npg()
p_lef

ggsave('p_lef.pdf', p_lef, width = 12, height = 8)
dev.off()
graphics.off()
p_abun<-lefse$plot_diff_abund(use_number = 1:8, group_order = c("LES", "NON_LES", "CTRL"))
p_abun
ggsave('p_abun.pdf', p_abun, width = 12, height = 8)
dev.off()
graphics.off()

