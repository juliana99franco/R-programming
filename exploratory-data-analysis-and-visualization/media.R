# Install required packages if needed
# install.packages(c("ggplot2", "rmarkdown", "knitr"))

# Load libraries
library(ggplot2)      # For high-quality data visualizations
library(rmarkdown)    # For creating reproducible reports
library(knitr)        # For knitting R Markdown documents

# Load dataset
advertising_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/media_13.csv")

# ================================================
# Activity 1: Create a Publication-Quality Visualization
# ================================================

# Create a summary data frame of total conversions by region
# Use ggplot2 to build a bar chart
# Apply advanced styling to make it presentation-ready

# Summarize total conversions by region

# Example - leave these next 3 lines of code uncommented.
# You'll need these for plot_1 below.
conversions_by_region <- aggregate(Conversions ~ Region, data = advertising_data, sum)

# Create base plot
plot <- ggplot(conversions_by_region, aes(x = Region, y = Conversions)) +
    geom_bar(stat = "identity", fill = "#007bff")
print(plot)

# Apply styling
 plot_a <- plot +
  labs(title = "Total Conversions by Region", x = "Region", y = "Total Conversions") +
  theme_light() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "darkblue"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10)
  )
 print(plot_a)


# ================================================
# Activity 2: Annotate and Style for Professional Reports
# ================================================

# Use the conversions_by_region summary table
# Identify the region with the highest total conversions
# Add a label annotation above that bar using geom_text()
# Adjust the label’s vertical position using vjust

# Identify region with highest conversions
# Example:
max_conversion_region <- conversions_by_region[which.max(conversions_by_region$Conversions), ]

# Add annotation to the plot
# plot_b <- plot +
#  geom_text(data = max_conversion_region,
#            aes(label = Conversions, y = Conversions),
#            vjust = -0.5,
#            size = 4,
#            fontface = "bold")
# print(plot_b)

# Try It Out #1: Customize your annotation
# Place label inside the bar using vjust = 1.5
# Use paste() for clearer labels like "Top region: North America"
# Hint: geom_text() adds text to your plot. Adjusting vjust moves the label vertically.

plot_2 <- plot_a +
    geom_text(
        data = max_conversion_region,
        aes(label = paste("Top Region: ", max_conversion_region$Region), y = Conversions),
        vjust = 1.5, 
        size = 4, 
        fontface = "bold", 
        color = "white"
    )
print(plot_2)

# ================================================
# Activity 3: Build a Reproducible Report
# ================================================

# Create a new .Rmd file
# Write the YAML header to set title, author, and output format
# Add sections for Introduction, Methodology, and Executive Summary
# Embed visualizations using R code chunks

# This activity will be completed in a separate .Rmd file
# Here's a sample YAML header and structure to guide you:

# ---
# title: "Advertising Report"
# author: "Your Name"
# date: "2024-07-27"
# output: html_document
# ---

# # Executive Summary
# Brief overview of key findings

# # Introduction
# This report analyzes digital advertising campaign performance.

# # Methodology
# Describe how you calculated conversions and created visualizations.

# # Visualization
# ```{r}
# Insert your ggplot2 chart code here from Activities 1 and 2 (plot_1 and plot_2)
# ```

# Try It Out #1: Add Methodology and Executive Summary sections
# Use headers (#) and plain text to describe your process and results
# Hint:  Use `#` for headers and plain text to narrate your insights.

# Add YOUR CODE to the new .Rmd file
