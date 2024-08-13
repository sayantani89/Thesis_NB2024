
library(ggplot2)
library(wesanderson)
library(readxl)

res <- X02092020_nucleus_alldata_usedforplots
head(res)
res["group"] <- "NotSignificant"
# change the grouping for the entries with significance but not a large enough Fold change
res[which(res['NOER_Nucl_vs_ER_Nucl.worst_fdr'] <= 0.05 & abs(res['NOER_Nucl_vs_ER_Nucl.log2fc'])<= 0.85),"group"] <- "log2FC<=0.85 or >= -0.85,FDR<= 0.05"
# change the grouping for the entries a large enough Fold change but not a low enough p value
res[which(res['NOER_Nucl_vs_ER_Nucl.worst_fdr'] > 0.05 & abs(res['NOER_Nucl_vs_ER_Nucl.log2fc']) > .85 ),"group"]<- "log2FC >0.85 or <-0.85,FDR > 0.05"
# change the grouping for the entries with both significance and large enough fold change
res[which(res['NOER_Nucl_vs_ER_Nucl.worst_fdr'] <= 0.05 & abs(res['NOER_Nucl_vs_ER_Nucl.log2fc']) > .85 ),"group"] <- "log2FC>0.85 or <-0.85 & FDR<= 0.05"
# Convert group as a grouping variable
 res$group<- as.factor(res$group)
sp <- ggplot(res, aes(x=NOER_Nucl_vs_ER_Nucl.log2fc, y= (-log10(NOER_Nucl_vs_ER_Nucl.worst_fdr)),color=factor(group)))+geom_point()
sp+scale_color_manual(values = wes_palette(n=4, name="GrandBudapest2"))