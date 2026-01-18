# Load necessary packages
library(dplyr)

# Example dataset (simulating weekly engagement data)
engagement <- data.frame(
  region = c("North", "South", "East", "West", "East", "North"),
  week = c("2025-06-01", "2025-06-01", "2025-06-01", "2025-06-01", "2025-06-08", "2025-06-08"),
  clicks = c(120, 85, 95, 110, 130, 100),
  impressions = c(1500, 1300, 1250, 1400, 1600, 1450)
)

# Filter for East region
east_data <- filter(engagement, region == "East")

# Select relevant columns
east_metrics <- select(east_data, week, clicks, impressions)

# Calculate summary statistics
mean_clicks <- mean(east_metrics$clicks)
median_impressions <- median(east_metrics$impressions)
click_variance <- var(east_metrics$clicks)
click_covariance <- cov(east_metrics$clicks, east_metrics$impressions)

# Help reference
# help(mean)

# Print results
print(mean_clicks)
print(median_impressions)
print(click_variance)
print(click_covariance)