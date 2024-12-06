library(clusterProfiler)
library(org.Hs.eg.db)
library(ggplot2)

OrgDb = "org.Hs.eg.db"  # "org.Mm.eg.db"  "org.Hs.eg.db"
genetype = "ENSEMBL"    # "SYMBOL"   "ENSEMBL"

tmp <- bitr(gene,fromType = "SYMBOL", 
                   toType = "ENTREZID",
                   OrgDb = OrgDb )



kegg <- enrichKEGG(
  gene = tmp$ENTREZID,
  keyType = 'kegg',  
  organism = 'hsa',  
  pAdjustMethod = 'BH', 
  pvalueCutoff = 0.05, 
qvalueCutoff = 0.1,  
)

dotp <- clusterProfiler::dotplot(kegg,
                                 size="GeneRatio",
                                 showCategory=10, 
                                 label_format=20,
                                 font.size=8, 
) + scale_size_area(max_size = 10) +
  scale_color_continuous(low='#E64B35FF',high='#4DBBD5FF') +
  theme(axis.text= element_text(face="bold", color = "black"))

ego <- enrichGO(
  gene = tmp$ENTREZID, 
  OrgDb = "org.Hs.eg.db",
  ont="BP",  
  pAdjustMethod = "BH",
  pvalueCutoff = 0.05, 
  qvalueCutoff = 0.05,  
)


lineage1_ego <- clusterProfiler::simplify( 
  ego,
  cutoff=0.7,  
  by="p.adjust",
  select_fun=min
)

dotp <- clusterProfiler::dotplot(lineage1_ego,
                                  size="GeneRatio",
                                  showCategory=10, #10 显示的是padjust最小的前10个
                                  label_format=20,
                                  font.size=8, 
) + scale_size_area(max_size = 10) +
  scale_color_continuous(low='#E64B35FF',high='#4DBBD5FF') +
  theme(axis.text= element_text(face="bold", color = "black"))

