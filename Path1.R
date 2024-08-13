# dependencies:
# install.packages("ggplot2")
# install.packages("gridExtra")
# install.packages("plotly")
install.packages("ggpubr")
suppressPackageStartupMessages(library("plotly"))


# read the file into a dataframe
diff_df1 <- X02092020_cyto_alldata_usedfor_plots
diff_df1 <- diff_df1[c("symbol", "NOER_Cyto_vs_ER_Cyto.log2fc", "NOER_Cyto_vs_ER_Cyto.worst_fdr")]


# preview the dataset; data required for the plot
head(diff_df1)
# add a grouping column; default value is "not significant"
diff_df1["group"] <- "NotSignificant"

# for our plot, we want to highlight 
# FDR < 0.05 (significance level)
# Fold Change > 1.5



#Volcano cytoplasmic

# change the grouping for the entries with significance but not a large enough Fold change
diff_df1[which(diff_df1['NOER_Cyto_vs_ER_Cyto.worst_fdr'] <= 0.05 & abs(diff_df1['NOER_Cyto_vs_ER_Cyto.log2fc'])<= 0.85),"group"] <- "log2FC<=0.85 or >= -0.85,FDR<= 0.05" 

# change the grouping for the entries a large enough Fold change but not a low enough p value
diff_df1[which(diff_df1['NOER_Cyto_vs_ER_Cyto.worst_fdr'] > 0.05 & abs(diff_df1['NOER_Cyto_vs_ER_Cyto.log2fc']) > .85 ),"group"]<- "log2FC >0.85 or <-0.85,FDR > 0.05"

# change the grouping for the entries with both significance and large enough fold change
diff_df1[which(diff_df1['NOER_Cyto_vs_ER_Cyto.worst_fdr'] <= 0.05 & abs(diff_df1['NOER_Cyto_vs_ER_Cyto.log2fc']) > .85 ),"group"] <- "log2FC>0.85 or <-0.85 & FDR<= 0.05"


diff_df1
# Convert group as a grouping variable

diff_df1$group <- as.factor(diff_df1$group)
diff_df1



sp <- ggplot(diff_df1, aes(x=NOER_Cyto_vs_ER_Cyto.log2fc, y= (-log10(NOER_Cyto_vs_ER_Cyto.worst_fdr)),color=factor(group)))+geom_point()+theme_minimal()
sp+scale_color_manual(values = wes_palette(n=4, name="GrandBudapest2"))

sp+theme_minimal()



library(ggplot2)
# Install
install.packages("wesanderson")
library(wesanderson)