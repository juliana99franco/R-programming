# Ungraded Lab: Handling Missing Data, Duplicate Entries, and Outliers in Retail Sales Data

# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse)  # This loads the tidyverse package, making its functions available.

# Load the retail dataset (Practice_set12_P2.csv)
retail_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/Practice_set12_P2.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
str(retail_data)  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 1: Fill in Missing Values
# ================================================
# Calculate median prices per product and use these to fill missing price values.

median_prices <- retail_data%>%
    group_by(ProductDescription) %>%
    summarize(median_price = median(Price, na.rm = TRUE))
print(median_prices)


# Impute missing price values with median prices
missing_prices <- is.na(retail_data$Price)
print(missing_prices)
#retail_data$Price[is.na(retail_data$Price)] <- median_prices

# Replace any missing quantities with a default value of 1.
retail_data$Quantity[is.na(retail_data$Quantity)] <- 1

# ================================================
# Activity 2: Clean Up Duplicate Records
# ================================================
# Identify duplicate orders (same CustomerID, OrderDate, ProductDescription).
duplicates <- retail_data %>%
  filter(duplicated(select(retail_data, CustomerID, OrderDate, ProductDescription)))
print(duplicates)

# Remove duplicates with distinct().
retail_data <- distinct(retail_data)


# ================================================
# Activity 3: Adjust Problematic Outliers
# ================================================
# Identify your 1st and 99th percentile price points as upper/lower thresholds.

price_thresholds <- quantile(retail_data$Price, probs = c(0.01, 0.99), na.rm = TRUE)
quantity_thresholds <- quantile(retail_data$Quantity, probs = c(0.01, 0.99), na.rm = TRUE)

print(price_thresholds)
print(quantity_thresholds)

#Adjust Price and Quantity logically based on identified outliers.

retail_data <- retail_data %>%
    mutate(
        Price = if_else(Price < price_thresholds[1], price_thresholds[1], if_else(
            Price > price_thresholds[2], price_thresholds[2], Price
        )),
        Quantity = if_else(Quantity < quantity_thresholds[1], quantity_thresholds[1], if_else(
            Quantity > quantity_thresholds[2], quantity_thresholds[2], Quantity
        ))
    )

# ================================================
# Activity 4: Summarize and Validate Your Improvement
# ================================================
# Provide overall descriptive summaries (average, min, max) clearly showing data is analysis-ready.
summary_stats <- retail_data %>%
    summarize(
        avg_price = mean(Price, na.rm = TRUE),
        min_price = min(Price, na.rm = TRUE),
        max_price = max(Price, na.rm = TRUE),
        avg_quantity = mean(Quantity, na.rm = TRUE),
        min_quantity = min(Quantity, na.rm = TRUE),
        max_quantity = max(Quantity, na.rm = TRUE)
    )
print(summary_stats)

# Clearly illustrate the number of orders by products.
orders_by_product <- retail_data %>%
    group_by(ProductDescription) %>%
    summarize(total_orders_per_product = n())
print(orders_by_product)

# Create numeric summaries to show Price and Quantity improvements after outlier adjustments.

# Numeric summaries to show Price and Quantity improvements
price_quantity_summary <- retail_data %>%
  summarize(
    mean_price = mean(Price, na.rm = TRUE),
    median_price = median(Price, na.rm = TRUE),
    mean_quantity = mean(Quantity, na.rm = TRUE),
    median_quantity = median(Quantity, na.rm = TRUE)
)
print(price_quantity_summary)
