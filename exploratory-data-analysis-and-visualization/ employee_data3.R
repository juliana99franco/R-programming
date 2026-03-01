# Ungraded Lab: Dimensionality Reduction Practice

# Load necessary libraries
library(ggplot2)      # For plotting
library(tidyverse)    # Data manipulation

# Load the dataset
employee_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 3/employee_10.csv")
str(employee_data)
# =============================
# Activity 1: Preparing Data for PCA
# =============================

# Scale all relevant numeric variables
# Check for high correlations
# Drop or combine highly correlated features if needed

# Example:
# Scale relevant numeric variables. Check for Correlations
# scaled_data <- scale(data[, c("A", "B", "C", "D")])
# cor_matrix <- cor(scaled_data)  # Create the correlation matrix
# high_cor_pairs <- which(abs(cor_matrix) > 0.9 & abs(cor_matrix) < 1, arr.ind = TRUE)

# Try It Out #1: Check for high correlations

# Scale all relevant numeric variables
scaled_employee_data <- scale(employee_data[, c("Age", "JobSatisfaction", "WorkLifeBalance", "Salary", "PerformanceRating")])


# Use cor() to compute a correlation matrix
cor_matrix <- cor(scaled_employee_data)

# Use which() with a condition to find high correlations (e.g., > 0.9)
high_cor_pairs <- which(abs(cor_matrix) > 0.9 & abs(cor_matrix) <1, arr.ind = TRUE)
print(high_cor_pairs)

# Decide whether to drop or combine highly correlated variables
# Not gonna drop because the goal is dimensionality reduction. 

pca_result <- prcomp(scaled_employee_data)


# =============================
# Activity 2: Running PCA and Understanding Variance
# =============================

# Use prcomp() to compute PCA
# Review output with summary() and print()
# Calculate variance explained and cumulative variance

# Example:

# pca_result <- prcomp(data)
# variance_explained <- pca_result$sdev^2 / sum(pca_result$sdev^2)
# cumulative_variance <- cumsum(variance_explained)
# summary(pca_result) 
# num_components <- which(cumulative_variance >= cutoff)  

# Try It Out #1: Decide how many components to retain
# Use summary(pca_result) to view variance explained
print(summary(pca_result))

# Calculate cumulative variance using cumsum()
explained_var <- pca_result$sdev^2 / sum(pca_result$sdev^2)
cumulative_var <- cumsum(explained_var)
print(cumulative_var)

# Choose a cutoff (e.g., ~85%) to guide how many components to retain
components_retained <- which(cumulative_var >= 0.85) [1]
print(components_retained)
# The first component alone explains > 85% of the variance, so we can retain just that one. 


# =============================
# Activity 3: Visualizing PCA Results
# =============================

# Steps:
# Create scree plots to show variance distribution
# Generate biplots for component interpretation

# Plot PCA-transformed data with enhancements

# Example
# screeplot(pca_data, type = "lines")
# biplot(pca_data, scale = 0)

# Try It Out #1: Create PCA visuals for dashboard

# Create scree plots to show variance distribution
screeplot(pca_result, type = "lines", main = "Scree Plot")

# Generate biplots for component interpretation
biplot(pca_result, scale = 0, main = "PCA Biplot")

