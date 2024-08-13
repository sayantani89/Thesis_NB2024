a <- X02092020_nucleus_alldata_usedforplots
p <- ggplot(data=a, aes(x=CHX_NOER_Nucl_vs_CHX_ER_Nucl.log2fc, y=-log10((CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr)))) + geom_point()+theme_minimal()
p2 <- p + geom_vline(xintercept=c(-0.6, 0.6), col="red") +geom_hline(yintercept=-log10(0.05), col="red")
p2

# add a column of NAs
a$diffexpressed <- "NO"
# if log2Foldchange > 0.85 and pvalue < 0.05, set as "UP" 
a$diffexpressed[a$CHX_NOER_Nucl_vs_CHX_ER_Nucl.log2fc > 0.85 & a$CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr < 0.05] <- "UP"
# if log2Foldchange < -0.85 and pvalue < 0.05, set as "DOWN"
a$diffexpressed[a$CHX_NOER_Nucl_vs_CHX_ER_Nucl.log2fc < -0.85 & a$CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr < 0.05] <- "DOWN"

library(ggplot2)


# Calculate counts of UP and DOWN categories
down_count <- "DOWN (2)"
up_count <- "UP (90)"

# Base plot with jitter
p <- ggplot(data = filtered_data, aes(x = CHX_NOER_Nucl_vs_CHX_ER_Nucl.log2fc, 
                                      y = -log10(CHX_NOER_Nucl_vs_CHX_ER_Nucl.worst_fdr), 
                                      col = diffexpressed)) + 
  geom_jitter(data = subset(filtered_data, diffexpressed == "DOWN"), 
              width = 0.5, height = 0.2, shape = 16, size = 1.6, alpha = 0.6) +
  geom_jitter(data = subset(filtered_data, diffexpressed == "UP"), 
              width = 0.5, height = 0.2, shape = 16, size = 1.6, alpha = 0.6) +
  labs(x = "log2(fold change)", y = "-log10(adj.p-value)", title = "CHX_NOER vs CHX_ER", 
       subtitle = "Nucleus", col = "Differential expression") + 
  theme_minimal() +
  geom_vline(xintercept = c(-0.85, 0.85), col = "red", linetype = "dashed") + 
  geom_hline(yintercept = -log10(0.05), col = "red", linetype = "dashed") +
  xlim(-10, 10) +
  ylim(0, 5)

# Set color scale manually
mycolors <- c("DOWN" = "#2c7bb6", "UP" = "#d7191c")
p <- p + scale_colour_manual(values = mycolors)


p <- p + annotate("text", x = -9, y = 4.5, label = down_count, 
                  color = mycolors["DOWN"], size = 4, hjust = 0) +
  annotate("text", x = 9, y = 4.5, label = up_count, 
           color = mycolors["UP"], size = 4, hjust = 1)

# Further theme customization
p <- p + theme(plot.title = element_text(size = 14L, hjust = 0.5, face = "bold"),
               plot.subtitle = element_text(size = 12L, hjust = 0.5),
               axis.title.y = element_text(size = 12L, margin = margin(t = 0, r = 10, b = 0, l = 0)),
               axis.title.x = element_text(size = 12L, margin = margin(t = 10, r = 0, b = 0, l = 0)),
               axis.text = element_text(size = 12),
               axis.text.x = element_text(angle = 0, hjust = 1),
               panel.grid.major = element_line(size = 0.5),
               panel.grid.minor = element_line(size = 0.25))

# Save the final plot as JPEG
ggsave("CHX_NOER_vs_CHX_ER_Nucleus.jpeg", plot = p,
       width = 15, height = 10, units = "cm", dpi = 600, 
       path = "/Users/nini/Documents/Thesis_figures", device = "jpeg")
