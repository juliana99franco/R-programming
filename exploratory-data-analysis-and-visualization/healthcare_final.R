# ================================================
# Final Project: Exploring and Visualizing Patient Data
# ================================================

# ================================================
# Graded Challenge 1: Initial Summary Statistics & Data Types (20 points)
# ================================================

# Step 1: Load dependencies and dataset
library(dplyr)
library(ggplot2)
library(lubridate)
library(plotly)
library(readr)
library(tidyverse)

# Load dataset
healthcare_df <- read_csv("healthcare_final.csv")


# Step 2: Explore summary statistics. Save to "summary_stats" and print
# Variables to create:
# - mean_age # Mean Age
# - median_bmi # Median BMI
# - sd_cost # Standar Deviation Healthcare Cost
# - range_cost # Difference of Max and Min Healthcare Cost

summary_stats <- healthcare_df %>%
    summarise(
    mean_age = mean(Age, na.rm = TRUE),
    median_bmi = median(BMI, na.rm = TRUE),
    sd_cost = sd(HealthcareCost, na.rm = TRUE),
    range_cost = max(HealthcareCost, na.rm = TRUE) - min(HealthcareCost, na.rm = TRUE)
     )

print(summary_stats)

# Step 3: Examine variable types using str() or glimpse()
str(healthcare_df)

# ================================================
# Graded Challenge 2: Categorical Exploration & Bar Charts (20 points)
# ================================================

# Step 1: Count frequency of Region and VisitType and store these in two new tables:
# - table_region
# - table_visit
# Counting helps us understand the distribution of visits and coverage

# Count frequency of Region in table_region
table_region <- table(healthcare_df$Region)
print(table_region)

# Count frequency of VisitType in table_visitType
table_visit <- table(healthcare_df$VisitType)
print(table_visit)

# Step 2: Create bar charts using ggplot2 to visualize Region and VisitType counts
# Use geom_bar() to visualize frequency counts for categorical variables

# Create a bar chart to visualize the Count of Visits by Region
# Use ggplot() to map:
# - x = Region
# - y = Count

plot_region <- ggplot(healthcare_df, aes(x = Region)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    labs(title = "Counts of Visits by Region", x = "Region", y = "Count")
    # Add a fill color of the categorical variable
    # Give the plot the title "Count of Visits by Region"

# Print to visualize plot_region
print(plot_region)

# Create a bar chart to visualize the Count of VisitTypes
# Use ggplot() to map:
# - x = VisitType
# - y = Count
plot_visit <- ggplot(table_visit, aes(x = VisitType, y = Count, fill = VisitType)) + 
    geom_bar(stat = "identity") +
    labs(title = "Count of Visit Types", x = "Visit Type", y = "Count")
    # Add a fill color of the categorical variable
    # Give the plot the title "Count of Visit Types"

# Print to visualize plot_visit
print(plot_visit)

# ================================================
# Graded Challenge 3: Bivariate Relationships (20 points)
# ================================================

# Step 1: Create scatter plot of Age vs HealthcareCost called "plot_age_cost".
# This helps us examine any relationship between age and cost

plot_age_cost <- ggplot(healthcare_df, aes( x = Age, y = HealthcareCost)) +
    geom_point()

# Step 2: Color-code the same plot as above by Smoker status
# Using color helps highlight patterns for specific groups
# Title the final plot "Cost vs Age by Smoker Status" using the labs title attribute.

plot_age_cost <- ggplot(healthcare_df, aes( x = Age, y = HealthcareCost, color = Smoker)) +
    geom_point() +
    labs ( title = "Cost vs Age by Smoker Status", x = "Age", y = "Cost")
print(plot_age_cost)

# ================================================
# Graded Challenge 4: Multivariate Faceting & Boxplots (20 points)
# ================================================

# Step 1-3: Create an interactive boxplot of HealthcareCost by InsuranceProvider
# Boxplots help us see the spread and outliers

# Your boxplot should be stored in "plot_cost_by_insurance"
# Use ggplot() to map:
# - x = InsuranceProvider
# - y = HealthcareCost
# - Add geom_boxplot() to show the spread and any outliers in the data.
# Give your boxplot a title "Healthcare Cost Distribution by Insurance Provider".
# Make your plot interactive with ggplotly()

plot_cost_by_insurance <- ggplot(healthcare_df, aes(x = InsuranceProvider, y = HealthcareCost)) +
    geom_boxplot() + 
    labs(title = "Healthcare Cost Distribution by Insurance Provider", x = "Insurance Provider", y = "Cost")
    # Create a boxplot
    # Give your boxplot a title using labs

print(plot_cost_by_insurance)

# Use ggplotly() to make your boxplot interactive.

ggplotly(plot_cost_by_insurance)

# Step 4: Now look at how Region affects costs — and view this comparison separately for each Visit Type.
# Create a second boxplot to show variation by VisitType across Regions
# - Map x = Region and y = HealthcareCost.
# - Add geom_boxplot() again to visualize cost spread by region.
# - Use facet_wrap(~ VisitType) to create separate panels for each visit type.
# - Make it interactive with ggplotly().

# Your boxplot should be stored in "plot_visits_by_region"
plot_visits_by_region <- ggplot(healthcare_df, aes(x= Region, y = HealthcareCost)) +
    geom_boxplot() +
    facet_wrap(~ VisitType)
print(plot_visits_by_region)

# Use ggplotly() to make plot_visits_by_region interactive.
ggplotly(plot_visits_by_region)

# ================================================
# Graded Challenge 5: Calculated Fields & Exporting (20 points)
# ================================================

# Step 1: Create a new column in your existing dataset, healthcare_df called "CostPerDay". 
# This should divide the total HealthcareCost by DaysInHospital.
# CostPerDay (HealthcareCost / DaysInHospital)

healthcare_df <- healthcare_df %>%
    mutate(CostPerDay = HealthcareCost / DaysInHospital)
print(healthcare_df$CostPerDay)
    # Use the mutate() function from the dplyr package.
    # Your column name should be called "CostPerDay" exactly - please do not change this


# Step 2: Calculate summary statistics (mean, median, standard deviation) of CostPerDay for each Region. 
# Use group_by() and summarise() to group the data and compute into cost_summary:
# - mean_cpd
# - median_cpd
# - sd_cpd
# - Use na.rm = TRUE to ignore any missing values.

# Summarize CostPerDay by Region (mean, median, sd) and store in cost_summary.
cost_summary <- healthcare_df %>%
    group_by(Region) %>%
    summarise(mean_cpd = mean(CostPerDay, na.rm = TRUE), 
              median_cpd = median(CostPerDay, na.rm = TRUE), 
              sd_cpd = sd(CostPerDay, na.rm=TRUE))
    
    # Group by Region
    # Summarize into "mean_cpd", "median_cpd", and "sd_cpd" values

print(cost_summary)


# Step 3: Create a boxplot to show how CostPerDay varies across Regions. 
# Store the new boxplot as "final_plot" exactly
# Use ggplot() with:
# - x = Region
# - y = CostPerDay

# Plot the final figure
final_plot <- ggplot(healthcare_df, aes(x = Region, y = CostPerDay)) +
    geom_boxplot(fill = "orange") +
    labs(title = "Cost Per Day by Region", x = "Region", y = "Cost Per Day")
    # Add geom_boxplot() and use the fill argument with color "orange" to style it.
    # Use labs() to give your plot the exact title "Cost Per Day by Region"

print(final_plot)
