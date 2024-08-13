library(ggplot2)

a <- X02092020_cyto_alldata_usedfor_plots
p <- ggplot(data=a, aes(x=NOER_Cyto_vs_ER_Cyto.log2fc, y=-log10((NOER_Cyto_vs_ER_Cyto.worst_fdr)))) + geom_point()+theme_minimal()
p2 <- p + geom_vline(xintercept=c(-0.6, 0.6), col="red") +geom_hline(yintercept=-log10(0.05), col="red")
p2

# add a column of NAs
a$diffexpressed <- "NO"
# if log2Foldchange > 0.85 and pvalue < 0.05, set as "UP" 
a$diffexpressed[a$NOER_Cyto_vs_ER_Cyto.log2fc > 0.85 & a$NOER_Cyto_vs_ER_Cyto.worst_fdr < 0.05] <- "UP"
# if log2Foldchange < -0.85 and pvalue < 0.05, set as "DOWN"
a$diffexpressed[a$NOER_Cyto_vs_ER_Cyto.log2fc < -0.85 & a$NOER_Cyto_vs_ER_Cyto.worst_fdr < 0.05] <- "DOWN"
p <- ggplot(data=a, aes(x=NOER_Cyto_vs_ER_Cyto.log2fc, y=-log10(NOER_Cyto_vs_ER_Cyto.worst_fdr), col=diffexpressed)) + geom_point() + theme_minimal()
p2 <- p + geom_vline(xintercept=c(-0.85, 0.85), col="red") +geom_hline(yintercept=-log10(0.05), col="red")
p2
p3 <- p2 + scale_color_manual(values=c("blue", "black", "red"))
mycolors <- c("blue", "red", "black")
names(mycolors) <- c("DOWN", "UP", "NO")
p3 <- p2 + scale_colour_manual(values = mycolors)

# Create a new column "delabel" to de, that will contain the name of genes differentially expressed (NA in case they are not)
a$delabel <- NA
a$delabel[a$diffexpressed != "NO"] <- a$symbol[a$diffexpressed != "NO"]



ggplot(data=a, aes(x=NOER_Cyto_vs_ER_Cyto.log2fc, y=-log10(NOER_Cyto_vs_ER_Cyto.worst_fdr), col=diffexpressed, label=delabel)) + 
  geom_point() + 
  theme_minimal() +
  geom_text()
a
install.packages("ggrepel")
library(ggrepel)

# plot adding up all layers we have seen so far
b<- ggplot(data=a, aes(x=NOER_Cyto_vs_ER_Cyto.log2fc, y=-log10(NOER_Cyto_vs_ER_Cyto.worst_fdr), col=diffexpressed, label=delabel)) +
  geom_point() + theme_minimal() + geom_text_repel() +scale_color_manual(values=c("blue", "black", "red")) +geom_vline(xintercept=c(-0.85, 0.85), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")
b