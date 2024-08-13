b <- X02092020_nucleus_alldata_usedforplots
q <- ggplot(data=b, aes(x=CHX_NOER_Nucl_vs_CHX_ER_Nucl.log2fc, y=-log10((CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr)))) + geom_point()+theme_minimal()
q2 <- q + geom_vline(xintercept=c(-0.6, 0.6), col="red") +geom_hline(yintercept=-log10(0.05), col="red")
q2

# add a column of NAs
b$diffexpressed <- "NO"
# if log2Foldchange > 0.85 and pvalue < 0.05, set as "UP" 
b$diffexpressed[b$CHX_NOER_Nucl_vs_CHX_ER_Nucl.log2fc > 0.85 & b$CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr < 0.05] <- "UP"
# if log2Foldchange < -0.85 and pvalue < 0.05, set as "DOWN"
b$diffexpressed[b$CHX_NOER_Nucl_vs_CHX_ER_CNucl.log2fc < -0.85 & b$CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr < 0.05] <- "DOWN"


q <- ggplot(data=b, aes(x=CHX_NOER_Nucl_vs_CHX_ER_Nucl.log2fc, y=-log10(CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr), col=diffexpressed)) + 
  geom_point(shape = "circle",size = 1.5,alpha=1) +labs(x = "log2fc", y = "-log10(worst FDR)", title = "CHX_NOER vs CHX_ER", subtitle = "Nucleus",col="Differential regulation") +theme_minimal()

q2 <- q+ geom_vline(xintercept=c(-0.85, 0.85), col="red") +geom_hline(yintercept=-log10(0.05), col="red")

q3<-q2+
  theme(plot.title = element_text(size = 14L, hjust = 0.5), plot.subtitle = element_text(size = 12L), 
        axis.title.y = element_text(size = 12L), axis.title.x = element_text(size = 12L)) +
  xlim(-10, 
       10) +
  ylim(0, 5)
q3

mycolors <- c("#2c7bb6", "#d7191c", "#404040")
names(mycolors) <- c("DOWN", "UP", "NO")
q4 <- q3 + scale_colour_manual(values = mycolors)
q4


mycolors <- c("blue", "red", "black")
names(mycolors) <- c("DOWN", "UP", "NO")
q5<-q4 + theme(plot.subtitle = element_text(hjust  =  0.5), axis.title = element_text(vjust  =  2), plot.title = element_text(vjust  =  2))
q6<-q5+theme_linedraw() + theme(plot.subtitle = element_text(hjust = 0.5),
                                plot.title = element_text(hjust = 0.5)) + theme(axis.title = element_text(vjust = 2),
                                                                                axis.text = element_text(size = 12,hjust = 1, vjust = 1))+theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),axis.title.x = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)))
q7<-q6+geom_point() +facet_wrap(vars(biotype_sorted))
q7

q7 + theme(panel.grid.major = element_line(linetype = "solid"),
           panel.grid.minor = element_line(linetype = "solid"),
           plot.background = element_rect(fill = "white")) +labs(colour = "Differential regulation",
                                                                 caption = "Biotypes") + theme(panel.grid.major = element_line(linetype = "solid"),
                                                                                               panel.grid.minor = element_line(linetype = "solid"))

ggsave("CHX_NOER vs CHX_ER Nucleus_biotypes.png", 
       width = 15, height = 10, units="cm", dpi = 600, device ="png",path = "/Users/sayantanibhattacharjee/Documents/R" ) 
