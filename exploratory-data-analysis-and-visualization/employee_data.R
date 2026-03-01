# Ungraded Lab: Employee Healthcare Analysis
# CRAN
install.packages("corrplot")

# Load necessary libraries
library(ggplot2)      # Visualization framework
library(dplyr)        # Data wrangling
library(tidyr)        # Data reshaping
library(corrplot)     # Correlation plots
library(GGally)       # Enhanced scatter plot matrices

# Load the dataset
employee_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/employee_8.csv")
str(employee_data)


# ================================
# Activity 1: Scatter Plot Matrices
# ================================

# Load the relevant subset of columns from employee_data.
# Use the pairs() function to generate a basic scatter plot matrix.
# Explore customization options with the GGally::ggpairs() function.

# Example: Basic scatter plot matrix
# pairs(employee_data[, c("Cat_A", "Cat_B", "Cat_C")],aes(color = Cat_C))

# Try it Out #1: You're creating an enhanced matrix with labeled axes and custom color schemes.

# Steps:

# Use ggpairs() to visualize 6 variables ("ProductivityScore", "EngagementScore", "SatisfactionScore", "EfficiencyScore", "InnovationScore", "Department")
# Explore how to add color based on Department

plot_1 <- ggpairs(employee_data[, c("ProductivityScore", "EngagementScore", "SatisfactionScore", "EfficiencyScore", "InnovationScore", "Department")],
    aes(color = Department))

print(plot_1)


# ================================
# Activity 2: Correlation Heatmaps
# ================================

# Create a correlation matrix using cor()
# Use corrplot() to visualize the results
# Test customizations like displaying coefficients or adjusting colors

# Example: Correlation matrix and heatmap
# cor_matrix <- cor(employee_data[, c("Cat_A", "Cat_B", "Cat_C", "Cat_D","Cat_E")])
# corrplot(cor_matrix, method = "color",
# addCoef.col = "black",  # Display the correlation values
# col = colorRampPalette(c("blue", "white", "red"))(200),  # Customize color scale
# order = "hclust")

# Try it Out #1: Improve your heatmap to make it easier for stakeholders to interpret.
# Steps:

# Create a cor_matrix with: "ProductivityScore", "EngagementScore", "SatisfactionScore",   #"EfficiencyScore", "InnovationScore"
 cormat <- cor(employee_data[, c("ProductivityScore", "EngagementScore", "SatisfactionScore", "EfficiencyScore", "InnovationScore")], use = "complete.obs")

# Add correlation coefficients with addCoef.col
# Adjust the color palette using col=colorRampPalette()
# Try sorting methods like "hclust"
plot_2 <- corrplot(cormat, method = "color", addCoef.col = "black", col = colorRampPalette(c("blue", "white", "red"))(200), order = "hclust")
print(plot_2)

# ================================
# Activity 3: Faceted Plots
# ================================

# Use ggplot() with geom_point() to plot Productivity vs Engagement
# Add facet_wrap(~ Department) to break it out by department
# Color code by ExperienceLevel to add another dimension

# Example: Faceted scatter plot by Department
# plot_a <- ggplot(employee_data, aes(x = Cat_A, y = Cat_B, color= Cat_C)) +
#   geom_point() +
#   facet_wrap(~ Cat_D)
# print(plot_a)

# Try it Out #1: Add more context by encoding a second categorical variable.
# Steps:
# Use color = ExperienceLevel inside aes()
# Solution

# Explore facet_wrap and facet_grid to compare layout styles
plot_3 <- ggplot(employee_data, aes(x = ProductivityScore, y = EngagementScore, color = ExperienceLevel)) +
    geom_point() +
     facet_wrap(~ Department)
print(plot_3)


# ================================
# Activity 4: Group-Based Analysis
# ================================

# Create a scatter plot of Productivity vs Engagement
# Group the color aesthetic by Team
# Add a faceting layer for ExperienceLevel
# Optionally test size, shape, or label encoding

# Example: Grouped scatter plot with Team colors
# plot_b <- ggplot(employee_data, aes(x = Cat_A, y = Cat_B, color = Cat_C)) +
#   geom_point() +
#   facet_wrap(~ Cat_D)
# print(plot_b)

# Try it Out #1: Highlight differences across experience levels using faceting.

# Steps:
# Add facet_wrap(~ ExperienceLevel)
# Maintain color grouping by team
plot_4 <- ggplot(employee_data, aes(x = ProductivityScore, y = EngagementScore, color = Team)) +
    geom_point() +
    facet_wrap(~ ExperienceLevel)
print(plot_4)

# Reflect on trends within and across panels
