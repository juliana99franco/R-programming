# Ungraded Lab: Missing Value Practice

# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse)  # This loads the tidyverse package, making its functions available.

# Load the retail dataset (retail_set9.csv)
retail_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/retail_set9.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
str(retail_data)  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 1: Identifying Missing Values with is.na()
# ================================================

# Use is.na() to check for missing values in the entire dataset and specific columns.
# Example:

# Check for missing values in the entire dataset
# missing_values <- is.na(retail_data)
# print(missing_values[1:10, ]) # Print the first 10 rows for readability

# Check for missing values in specific columns
# missing_quantity <- is.na(retail_data$Quantity)
# missing_unit_price <- is.na(retail_data$UnitPrice)
# print(missing_quantity)
# print(missing_unit_price)

# Calculate total number of missing values in ProductName
# missing_product_name <- is.na(retail_data$ProductName)
# total_missing_product_name <- sum(missing_product_name)
# print(total_missing_product_name)

# Try it Out #1 : Use is.na() to check for missing values in the OrderDate column of the dataset.

missing_dates <- is.na(retail_data$OrderDate)
print(missing_dates)
total_missing_dates <- sum(missing_dates)
print(total_missing_dates)

# Try it Out #2 : Use is.na() to check for missing values in the ShippingAddress column.

missing_address <- is.na(retail_data$ShippingAddress)
print(missing_address)
total_missing_address <- sum(missing_address)
print(total_missing_address)


# ================================================
# Activity 2: Filtering Data based on Missing Values
# ================================================
# Remove rows with any missing values.
# Filter the dataset to keep only rows where Quantity or UnitPrice is missing.

# Example:

# Remove rows with any missing values
# complete_cases <- retail_data[complete.cases(retail_data), ]
# print(nrow(complete_cases)) # Print the number of complete cases

# Filter to keep only rows with missing values in 'Quantity'
# missing_quantity_rows <- retail_data[is.na(retail_data$Quantity), ]
# print(nrow(missing_quantity_rows)) # Print the number of rows with missing Quantity

# Filter rows where either Quantity or UnitPrice is missing
# either_missing <- retail_data[is.na(retail_data$Quantity) | is.na(retail_data$UnitPrice), ]
# print(nrow(either_missing)) # Print the number of rows with either Quantity or UnitPrice 
# missing

# Try it Out #1 : Use complete.cases() to filter the dataset to keep only rows with no missing values in either Quantity or UnitPrice.

complete_data <- retail_data[complete.cases(retail_data[c("Quantity", "UnitPrice")]), ]
print(nrow(complete_data)) # Print the number of complete cases for Quantity and UnitPrice

# Try it Out #2 : Use is.na() to filter the dataset to keep only rows where 'OrderDate' is missing.

missing_dates <- retail_data[is.na(retail_data$OrderDate),]
print(nrow(missing_dates)) # Print the number of rows with missing OrderDate

# ================================================
# Activity 3: Basic Missing Value Handling
# ================================================
# Calculate summary statistics excluding missing values.
# Calculate the sum of Quantity for complete cases.

# Example

# Calculate the mean of 'Price', ignoring missing values
# mean_price <- mean(retail_data$Price, na.rm = TRUE)
# print(mean_price)

# Calculate the median of 'Products', ignoring missing values
# median_product <- median(retail_data$Products, na.rm = TRUE)
# print(median_products)

# Calculate the sum of Quantity for complete cases
# sum_cases_complete <- sum(retail_data$Cases, na.rm = TRUE)
# print(sum_cases_complete)


# Try it Out #1 : Calculate the mean of UnitPrice, excluding missing values.

average_price <- mean(retail_data$UnitPrice, na.rm = TRUE)
print(average_price)

# Try it Out #2 : Calculate the sum of Quantity, excluding missing values.
quantity_sum <- sum(retail_data$Quantity, na.rm = TRUE)
print(quantity_sum)

# ================================================
# Bringing it all Together
# ================================================

# Problem #1: Identify the necessary function(s) and code the solution.

# Goal: Keep only rows where the OrderDate column is *not missing*
# HINT: Use complete.cases() to check for non-missing values in a specific column

# Step 1: Filter for rows where OrderDate is complete (not NA)
complete_orderdate_cases <- retail_data[complete.cases(retail_data$OrderDate), ]  

# Step 2: Print how many rows were kept
# HINT: nrow() counts the number of rows in a dataset
print(nrow(complete_orderdate_cases))
