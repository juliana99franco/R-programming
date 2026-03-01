# Ungraded Lab: Advanced Data Cleaning Techniques

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("lubridate")
# install.packages("stringr")
# install.packages("readr")

# Load the required libraries
library(tidyverse)
library(lubridate)
library(stringr)
library(readr)

# Load your data into R using read_csv() from the readr package within tidyverse
transactions <- read_csv("/Users/juliana/Desktop/R Programming/Course 3/healthcare_3.csv")

# Review the dataset using functions like head(), str(), and summary()
head(transactions)
str(transactions)
summary(transactions)

# ================================================
# Activity 1: Remove Duplicate Patient Records
# ================================================

# Find and remove duplicates:

# Example
# Detect duplicates explicitly by MedicineID
# pharma_data <- pharma_data %>%
# distinct(MedicineID, .keep_all = TRUE)  # Keep only one row per MedecineID
# unique_records_count <- nrow(pharma_data)  # Check the count of remaining unique records

# Try it Out #1: Remove duplicates based on TransactionID.

# Steps:
# Use distinct() to remove duplicates based on TransactionID.
transactions <- transactions %>%
  distinct(TransactionID, .keep_all = TRUE)

# Confirm how many unique records remain afterward.
unique_record_count <- nrow(transactions)
print(unique_record_count) #Quedaron 48, de 50. 

# ================================================
# Activity 2: Standardizing Product Names
# ================================================

# Clean product names by removing unwanted suffixes like "-Rev", "_new", etc.

#Example
# transactions <- transactions %>%
#   mutate(ProductName = str_replace_all(ProductName, "-Rev|_new|-v2|_updated", ""))  
  
# table(transactions$ProductName)

# Example: Product Name Before and After
# Before: "PainRelief_v2"
# After:  "PainRelief"

# Try it Out #1: Remove spaces and punctuation from ProductName.

# Steps:
# Use str_replace_all() to remove all spaces, underscores, and hyphens from ProductName.

print(transactions$ProductName)
transactions <- transactions %>%
  mutate(ProductName = str_replace_all(ProductName, "[\\s_\\-]", ""))
print(transactions$ProductName)

# Try it Out #2: Replace abbreviations with full product names in ProductName.

# Steps:
# Use str_replace_all() to replace known abbreviations in product names with their full names.Example: "Pain Relief-Rev" → "PainReliefRev"

transactions <- transactions %>%
  mutate(ProductName = str_replace_all(ProductName, "VitD", "VitaminD"))

# ================================================
# Activity 3: Fill Missing Prices with Median Values
# ================================================

# Fill missing PricePerUnit using product median.

#Example
# Calculate the median PricePerUnit for each ProductName
# product_median_prices <- transactions %>%
#   group_by(ProductName) %>%
#   summarize(ProductMedian = median(PricePerUnit, na.rm = TRUE))  # Compute median price for each product

#  Join these medians back to the transactions data
# transactions <- transactions %>%
#   left_join(product_median_prices, by = "ProductName") %>%
#   mutate(PricePerUnit = ifelse(is.na(PricePerUnit), ProductMedian, PricePerUnit)) %>%  # Replace missing prices
#   select(-ProductMedian)  # Clean up the helper column

#  Review the result
# summary(transactions$PricePerUnit)


# Try it Out #1: Impute missing prices using LocationCode median.

# Steps:
# Group transactions by LocationCode, calculate the median PricePerUnit, and fill missing values accordingly.

# Example: Filling a missing price using the median for a location

# Calculate the median PricePerUnit for each LocationCode
location_median_prices <- transactions %>%
    group_by(LocationCode) %>% # Group transactions by LocationCode
    summarize(LocationMedian = median(PricePerUnit, na.rm=TRUE))
    # Compute median price for each location

transactions <- transactions %>%
    left_join(location_median_prices, by="LocationCode") %>%
    # Add median price per location
    mutate(PricePerUnit = ifelse(is.na(PricePerUnit), LocationMedian, PricePerUnit))# Remove the helper column

# Review the result
summary(transactions$PricePerUnit)

# Try it Out #2: Impute missing prices with overall median without respect to ProductName or Location.

# Steps:
# Calculate the overall median for PricePerUnit and fill in missing values.
# Compare this with using LocationCode median replacement.

median_price <- median(transactions$PricePerUnit, na.rm =TRUE)
transactions$PricePerUnit[is.na(transactions$PricePerUnit)] <- median_price
summary(transactions$PricePerUnit)

# ================================================
# Activity 4: Formatting Transaction Dates
# ================================================

# Convert TransactionDate to Date format.

# Example: Converting TransactionDate and creating TransactionMonth
# Original: "2023-03-15"
# transactions$TransactionDate <- as.Date(transactions$TransactionDate, "%Y-%m-%d")
# transactions$TransactionMonth <- format(transactions$TransactionDate, "%Y-%m")

# transactions <- transactions %>%
#   mutate(TransactionDate = as.Date(TransactionDate, "%Y-%m-%d"))

# str(transactions$TransactionDate)

# Extract the year and month TransactionDate and add TransactionMonth as a new column.

# # Generate a new column, TransactionMonth, extracting year and month from TransactionDate
# transactions <- transactions %>%
#   mutate(TransactionMonth = format(TransactionDate, "%Y-%m"))  # Simplifies monthly reporting by condensing to month format


# Try it Out #1: Add a "Quarter" column derived from TransactionDate.

# Steps:
# Derive a new column named "Quarter" showing the corresponding quarterly period ("Q1-Q4") from TransactionDate.

transactions <- transactions %>%
  mutate(Quarter = quarter(TransactionDate, with_year = TRUE, fiscal_start = 1))
print(transactions$Quarter)

# ================================================
# Activity 5: Bringing it all together
# ================================================

# Problem 1: Standardize LocationCode into "LOC#" format.

transactions <- transactions %>%
  mutate(LocationCode = toupper(LocationCode),  # Hint: Make all letters uppercase for consistency
         LocationCode = str_replace_all(LocationCode, "^[a-zA-Z]+", "LOC"),  # Hint: Replace any leading letters with "LOC"
         LocationCode = ifelse(!grepl("^LOC\\d+$", LocationCode), "UNKNOWN", LocationCode))  # Hint: Anything not matching the pattern becomes "UNKNOWN"

# Problem 2: Categorize PricePerUnit into "Low", "Medium", and "High" price tiers.

transactions <- transactions %>%
  mutate(PriceCategory = cut(PricePerUnit,
                             breaks = c(-Inf, 15, 30, Inf),  # Hint: Set thresholds for price groupings
                             labels = c("Low", "Medium", "High")))  # Hint: Match each range with a label

# Problem 3: Perform final validation steps.

# Calculate the total transaction value by multiplying quantity by price per unit
transactions <- transactions %>%
  mutate(TransactionTotal = Quantity * PricePerUnit)  # Hint: Use the existing column that tracks per-unit cost

# Verify no duplicates remain
remaining_duplicates <- sum(duplicated(transactions$TransactionID))  # Hint: Which function finds repeated rows?
remaining_duplicates  # Ensures duplicates have been correctly omitted

# Verify data types and other preprocessing steps
summary(transactions$PriceCategory)  # Hint: Use this to summarize how many fall in each category
str(transactions)  # Hint: Use this to inspect structure and column types
