setwd("/Users/nini/Downloads")
df<- read_xlsx("Only_nuc_cyto_both_figuredata.xlsx",sheet=2)

df<- Only_nuc_cyto_both_figuredata

library(dplyr)

# Assuming df is your dataframe

# Create a new dataframe with unique gene names from each column
nuc_down_unique <- unique(df$NOER_ER_NUC_DOWN)
cyto_down_unique <- unique(df$NOER_ER_CYTO_DOWN)

duplicates_nuc <- df$NOER_ER_NUC_DOWN[duplicated(df$NOER_ER_NUC_DOWN), drop = NA]
duplicates_cyto <- df$NOER_ER_CYTO_DOWN[duplicated(df$NOER_ER_CYTO_DOWN), drop = NA]


# Create dataframes for each category
nuc_only <- data.frame(Gene_Name = setdiff(nuc_down_unique, cyto_down_unique))
cyto_only <- data.frame(Gene_Name = setdiff(cyto_down_unique, nuc_down_unique))
both <- data.frame(Gene_Name = intersect(nuc_down_unique, cyto_down_unique))

# Rename columns
names(nuc_only) <- "Nuc_Only"
names(cyto_only) <- "Cyto_Only"
names(both) <- "Both"

# Print the number of rows in each category
cat("Number of genes in NOER_ER_NUC_DOWN but nolibrat in NOER_ER_CYTO_DOWN:", nrow(nuc_only), "\n")
cat("Number of genes in NOER_ER_CYTO_DOWN but not in NOER_ER_NUC_DOWN:", nrow(cyto_only), "\n")
cat("Number of genes common in both NOER_ER_NUC_DOWN and NOER_ER_CYTO_DOWN:", nrow(both), "\n")

# Load the nVennR package
library(VennDiagram)

# Define the counts for each set based on your dataframe
nuc_total <- 4187  # Number of genes in NOER_ER_NUC_UP but not in NOER_ER_CYTO_UP
cyto_total <- 5405  # Number of genes in NOER_ER_CYTO_UP but not in NOER_ER_NUC_UP
both <- 3177  # Number of genes common in both NOER_ER_NUC_UP and NOER_ER_CYTO_UP

# Plot the pairwise comparison Venn diagram
draw.pairwise.venn(
  nuc_total, 
  cyto_total, 
  both, 
  category = c("nuc","cyto"), 
  lty = rep("blank", 2), 
  fill = c("orange", "purple"), 
  alpha = rep(0.5, 2), 
  cat.pos = c(0, 0), 
  cat.dist = rep(0.025, 2,scaled = TRUE)
)


