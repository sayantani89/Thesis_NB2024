library(ggplot2)
install.packages("ggThemeAssist")
install.packages("esquisse")
library(ggThemeAssist)
library(esquisse)
install.packages("colorbrewer",dependencies = TRUE)
library("colorbrewer")
a <- X02092020_cyto_alldata_usedfor_plots
library(ggplot2)

# Prepare the dataset
a <- X02092020_cyto_alldata_usedfor_plots

# Define differentially expressed categories
a$diffexpressed <- "NO"
a$diffexpressed[a$NOER_Cyto_vs_ER_Cyto.log2fc > 0.85 & a$NOER_Cyto_vs_ER_Cyto.worst_fdr < 0.05] <- "UP"
a$diffexpressed[a$NOER_Cyto_vs_ER_Cyto.log2fc < -0.85 & a$NOER_Cyto_vs_ER_Cyto.worst_fdr < 0.05] <- "DOWN"

# Manually adjust counts for each category
down_count <- "DOWN (5405)"
up_count <- "UP (4763)"
no_count <- "NO (25291)"  # Adjusted based on the difference

# Base plot
p <- ggplot(data = a, aes(x = NOER_Cyto_vs_ER_Cyto.log2fc, 
                          y = -log10(NOER_Cyto_vs_ER_Cyto.worst_fdr), 
                          col = diffexpressed)) + 
  geom_point(shape = "circle", size = 1.5, alpha = 0.6) +
  labs(x = "log2(fold change)", y = "-log10(adj.p-value)", 
       title = "NOER vs ER", subtitle = "Cytoplasm", 
       col = "Differential expression") + 
  theme_minimal() +
  geom_vline(xintercept = c(-0.85, 0.85), col = "red", linetype = "dashed") + 
  geom_hline(yintercept = -log10(0.05), col = "red", linetype = "dashed") +
  xlim(-10, 10) + ylim(0, 5)

# Set color scale manually
mycolors <- c("DOWN" = "#2c7bb6", "UP" = "#d7191c", "NO" = "#404040")
p <- p + scale_colour_manual(values = mycolors)

# Adding counts as text annotations
p <- p + 
  annotate("text", x = -9, y = 4.5, label = down_count, 
           color = mycolors["DOWN"], size = 4, hjust = 0) +
  annotate("text", x = 9, y = 4.5, label = up_count, 
           color = mycolors["UP"], size = 4, hjust = 1) +
  annotate("text", x = 5.5, y = 1, label = no_count,  # Shifted the NO label inside and to the right
           color = mycolors["NO"], size = 4, hjust = 0.5)

# Further theme customization
p <- p + theme(
  plot.title = element_text(size = 14L, hjust = 0.5, face = "bold"),
  plot.subtitle = element_text(size = 12L, hjust = 0.5),
  axis.title.y = element_text(size = 12L, margin = margin(t = 0, r = 10, b = 0, l = 0)),
  axis.title.x = element_text(size = 12L, margin = margin(t = 10, r = 0, b = 0, l = 0)),
  axis.text = element_text(size = 12),
  axis.text.x = element_text(angle = 0, hjust = 1),
  panel.grid.major = element_line(size = 0.5),
  panel.grid.minor = element_line(size = 0.25)
)

# Save the final plot as PNG with high resolution
ggsave("NOER_vs_ER_Cytoplasm.jpeg", plot = p,
       width = 15, height = 10, units = "cm", dpi = 600, 
       path = "/Users/nini/Documents/Thesis_figures", device = "jpeg")
