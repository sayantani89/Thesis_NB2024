library(ggplot2)
install.packages("ggThemeAssist")
install.packages("esquisse")
library(ggThemeAssist)
library(esquisse)
install.packages("colorbrewer",dependencies = TRUE)
library("colorbrewer")
a <- X02092020_nucleus_alldata_usedforplots
p <- ggplot(data=a, aes(x=NOER_Nucl_vs_ER_Nucl.log2fc, y=-log10((NOER_Nucl_vs_ER_Nucl.worst_fdr)))) + geom_point()+theme_minimal()
p2 <- p + geom_vline(xintercept=c(-0.6, 0.6), col="red") +geom_hline(yintercept=-log10(0.05), col="red")
p2

# add a column of NAs
a$diffexpressed <- "NO"
# if log2Foldchange > 0.85 and pvalue < 0.05, set as "UP" 
a$diffexpressed[a$NOER_Nucl_vs_ER_Nucl.log2fc > 0.85 & a$NOER_Nucl_vs_ER_Nucl.worst_fdr < 0.05] <- "UP"
# if log2Foldchange < -0.85 and pvalue < 0.05, set as "DOWN"
a$diffexpressed[a$NOER_Nucl_vs_ER_Nucl.log2fc < -0.85 & a$NOER_Nucl_vs_ER_Nucl.worst_fdr < 0.05] <- "DOWN"


p <- ggplot(data=a, aes(x=NOER_Nucl_vs_ER_Nucl.log2fc, y=-log10(NOER_Nucl_vs_ER_Nucl.worst_fdr), col=diffexpressed)) + 
  geom_point(shape = "circle",size = 1.5,alpha=1) +labs(x = "log2fc", y = "-log10(worst FDR)", title = "NOER vs ER", subtitle = "Nucleus",col="Differential expression") +theme_minimal()

p2 <- p + geom_vline(xintercept=c(-0.85, 0.85), col="red") +geom_hline(yintercept=-log10(0.05), col="red")

p3<-p2+
  theme(plot.title = element_text(size = 14L, hjust = 0.5), plot.subtitle = element_text(size = 12L), 
        axis.title.y = element_text(size = 12L), axis.title.x = element_text(size = 12L)) +
  xlim(-10, 
       10) +
  ylim(0, 5)
p3
mycolors <- c("#2c7bb6", "#d7191c", "#404040")
names(mycolors) <- c("DOWN", "UP", "NO")
p4 <- p3 + scale_colour_manual(values = mycolors)
p4

p5<-p4 + theme(plot.subtitle = element_text(hjust  =  0.5), axis.title = element_text(vjust  =  2), plot.title = element_text(vjust  =  2))
p5+theme_linedraw() + theme(plot.subtitle = element_text(hjust = 0.5),
    plot.title = element_text(hjust = 0.5)) + theme(axis.title = element_text(vjust = 2),
    axis.text = element_text(size = 12,hjust = 1, vjust = 1))+theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),axis.title.x = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)))


ggsave("NOER vs ER Nucleus.png", 
       width = 15, height = 10, units="cm", dpi = 600, device ="png",path = "/Users/sayantanibhattacharjee/Documents/R" ) 
