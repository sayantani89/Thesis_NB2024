library(readxl)
library(dplyr)
setwd("/Users/nini/Downloads")
df<- read_xlsx("Only_nuc_cyto_both_figuredata.xlsx",sheet=3)



# Assuming df is your dataframe

# Create a new dataframe with unique gene names from each column
nuc_up_unique <- unique(df$direct_target_nuc_up)
cyto_up_unique <- unique(df$direct_target_cyto_up)

duplicates_nuc <- df$direct_target_nuc_up[duplicated(df$direct_target_nuc_up), drop = NA]
duplicates_cyto <- df$direct_target_cyto_up[duplicated(df$direct_target_cyto_up), drop = NA]


# Create dataframes for each category
nuc_only <- data.frame(Gene_Name = setdiff(nuc_up_unique, cyto_up_unique))
cyto_only <- data.frame(Gene_Name = setdiff(cyto_up_unique, nuc_up_unique))
both <- data.frame(Gene_Name = intersect(nuc_up_unique, cyto_up_unique))

# Rename columns
names(nuc_only) <- "Nuc_Only"
names(cyto_only) <- "Cyto_Only"
names(both) <- "Both"

# Print the number of rows in each category
cat("Number of genes in direct_target_nuc_up but nolibrat in direct_target_cyto_up:", nrow(nuc_only), "\n")
cat("Number of genes in direct_target_cyto_up but not in direct_target_nuc_up:", nrow(cyto_only), "\n")
cat("Number of genes common in both direct_target_nuc_up and direct_target_cyto_up:", nrow(both), "\n")

# Load the nVennR package
library(VennDiagram)

# Define the counts for each set based on your dataframe
nuc_total <- 90  # Number of genes in direct_target_nuc_up but not in direct_target_cyto_up
cyto_total <- 63  # Number of genes in direct_target_cyto_up but not in direct_target_nuc_up
both <- 27  # Number of genes common in both direct_target_nuc_up and direct_target_cyto_up
# Load the nVennR package
library(VennDiagram)

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


