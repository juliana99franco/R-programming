# Ungraded Lab: Exploring Time Series Components

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("lubridate")
# install.packages("zoo")
# install.packages("forecast")

# Load the required libraries
library(tidyverse)     # Data manipulation and plotting
library(lubridate)     # Handling date/time formats
library(ggplot2)       # Data visualization
library(zoo)           # Rolling statistics
library(forecast)      # Time series decomposition
library(stats)         # STL decomposition and base functions

# Load the dataset
sales <- read_csv("exploring_time_series_data.csv")

# Review the dataset
head(sales)
str(sales)
summary(sales)

# ================================================
# Activity 1: Preparing Time Series Data
# ================================================

# Convert Date column to Date format
# Create a time series object with frequency = 365

# Example:
# sales <- sales %>% mutate(Date = as.Date(Date))
# ts_data <- ts(sales$DailySales, start = c(2022, 1), frequency = 365)

# Try It Out #1: Ensure completeness and structure
# You're confirming that there are no missing dates in the time series

# Steps:
# - Convert the Date column to Date format
sales <- sales %>%
    mutate(Date = as.Date(Date))

# - Check for regular daily frequency and missing dates
all_dates <- tibble(Date = seq(min(sales$Date), max(sales$Date), by = "day"))
sales <- all_dates %>% left_join(sales, by = "Date")

# - Create a time series object from DailySales
ts_object <- ts(sales$DailySales, start = c(2022, 1), frequency = 365)


# ================================================
# Activity 2: Visualizing Trends and Patterns
# ================================================

# Plot dates over time
# Highlight areas of trend or seasonal repetition
# Use rollmean() to create 5-day and 14-day moving averages
# Overlay these on the original line chart

# Example:
# Plot the raw time series
# plot_a <- ggplot(data, aes(x = EventDate, y = MetricValue)) +
#   geom_line() +
#   labs(title = "Metric Over Time", x = "Date", y = "Value")
#
# print(plot_a)

# Create smoothed short- and long-term trend lines
# data <- data %>%
#   mutate(
#     trend_5 = rollmean(MetricValue, k = 5, fill = NA, align = "right"),
#     trend_14 = rollmean(MetricValue, k = 14, fill = NA, align = "right")
#   )

# Overlay the smoothed trends on the original time series
# plot_b <- ggplot(data, aes(x = EventDate)) +
#   geom_line(aes(y = MetricValue), color = "grey70") +
#   geom_line(aes(y = trend_5), color = "blue") +
#   geom_line(aes(y = trend_14), color = "red") +
#   labs(title = "Metric with 5- and 14-Day Moving Averages", y = "Value")

# print(plot_b)

# Try It Out #1: Add 7-day and 30-day rolling averages

# Steps:
# - Plot daily sales over time
plot_a <- ggplot(sales, aes(x = Date, y = DailySales)) +
    geom_line() +
    labs(title = "Daily Sales over Time", x = "Date", y = "Sales")
print(plot_a)

# - Highlight areas of trend or seasonal repetition
# - Use rollmean() to create 7-day and 30-day moving averages
sales <- sales %>%
    mutate(
        trend_7 = rollmean(DailySales, k = 7, fill = NA, align = "right"),
        trend_30 = rollmean(DailySales, k = 30, fill = NA, align = "right")
    )

plot_2.1 <- ggplot(sales, aes(x = Date)) +
    geom_line(aes(y = DailySales), color = "grey70") +
    geom_line(aes(y = trend_7), color = "darkred") +
    geom_line(aes(y = trend_30), color = "purple") +
    labs(title = "Daily Sales with 7- and 30-Day Moving Averages", y = "Daily Sales")

print(plot_2.1)



# ================================================
# Activity 3: Classical Decomposition
# ================================================

# Use decompose() to split time series into components
# Plot the components to visualize structure

# Example:
# data <- data %>% mutate(EventDate = as.Date(EventDate))  # Ensure date column is in Date format
# ts_object <- ts(data$MetricValue, start = c(2022, 1), frequency = 365)

# decomp_result <- decompose(ts_object)
# plot(decomp_result)

# Try It Out #1: Decompose and describe component behavior

# Steps:
# - Use decompose() to split the time series from Activity 1 into components
decomp_obj <- decompose(ts_object)

# - Plot the components to visualize structure
plot(decomp_obj)

# - Write 1–2 sentences on observed trend and seasonality

# - The trend shows a gradual increase. 
# - The seasonality shows fluctuations. 

# ================================================
# Activity 4: STL Decomposition
# ================================================

# Use stl() to apply STL decomposition to the time series from Activity 1
# Compare STL vs classical output


# Example:
# Step 1: Format date and create a time series object
# data <- data %>% mutate(EventDate = as.Date(EventDate))  # Ensure date column is properly formatted
# ts_object <- ts(data$MetricValue, start = c(2022, 1), frequency = 7)

# Step 2: Apply STL decomposition
# stl_result <- stl(ts_object, s.window = "periodic")
# plot(stl_result)

# Try It Out #1: Compare STL and classical results

# Steps:
# - Apply both methods to the same data
ts_data <- ts(sales$DailySales, start = c(2022, 1), frequency = 7)
stl_comp <- stl(ts_data, s.window = "periodic")

# - Visually compare trends and seasonal components
plot(stl_comp)

# - Summarize what STL captures differently

# Seasonal trend is more noisy or has more detail in STL than in de classical one. 
# Trend seems to uphold. 

# ================================================
# Activity 5: Bringing it All Together
# ================================================

# You’ve cleaned the data, visualized seasonal trends, and applied decomposition techniques.
# Now it’s time to pull together your findings and share your interpretation.

# Scenario:
# Your manager is preparing a slide deck for an internal planning session
# and needs a short summary of your time series analysis.
# They’ve asked you to highlight what trends or patterns were found,
# and what they mean for the business.

# This isn’t about statistical jargon — it’s about being helpful and confident.
# Use # comments below to summarize your analysis and make a few practical recommendations.


# Task 1:
# Summary of Findings:
# The sales data showed an upward trend over the two years, especially in late Q4.
# Seasonal patterns were visible — spikes around holiday periods were consistent each year.
# The STL decomposition showed smoother, more flexible seasonal components than the classical approach.
# There were a few irregular dips in early spring that may reflect stock issues or external events.

# Task 2:
# Recommendations:
# Focus further analysis on holiday weeks in Q4 to optimize marketing and stock.
# Use STL decomposition for future seasonal reporting — it's more adaptable for our data shape.
# Investigate spring dips in sales — were they weather-related or operational?
# Consider creating monthly summaries to track ongoing trends more clearly.