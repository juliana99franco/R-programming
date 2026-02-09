# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse) # This loads the tidyverse package, making its functions available.

# Load the retail dataset (retail_set10.csv)
retail_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/retail_set10.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
str(retail_data)  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 1: Identifying Outliers in Unit Prices
# ================================================
# Identify outliers by inspecting the minimum and maximum of unit prices using min(), max() and summary():
# Example:

# Basic statistics for UnitPrice
# summary(retail_data$UnitPrice)

# Check extremes explicitly
# min(retail_data$UnitPrice)
# max(retail_data$UnitPrice)


# Try it Out #1 : Find the minimum and maximum unit prices for the Smartphone category and compare them to other products to spot any outliers.
#Min values
iphone_min <- min(retail_data$UnitPrice[retail_data$Product == "Smartphone"])
others_min <- min(retail_data$UnitPrice[retail_data$Product != "Smartphone"])
print(iphone_min)
print(others_min)
#Max values
iphone_max <- max(retail_data$UnitPrice[retail_data$Product == "Smartphone"])
others_max <- max(retail_data$UnitPrice[retail_data$Product != "Smartphone"])
print(iphone_max)
print(others_max)

# Try it Out #2 : Find the minimum and maximum unit prices for the Bluetooth Speaker category and compare them to other products to spot any outliers.

#Min values
speaker_min <- min(retail_data$UnitPrice[retail_data$Product == "Bluetooth Speaker"])
others_min <- min(retail_data$UnitPrice[retail_data$Product != "Bluetooth Speaker"])
print(speaker_min)
print(others_min)
#Max values
speaker_max <- max(retail_data$UnitPrice[retail_data$Product == "Bluetooth Speaker"])
others_max <- max(retail_data$UnitPrice[retail_data$Product != "Bluetooth Speaker"])
print(speaker_max)
print(others_max)


# ================================================
# Activity 2: Detecting Duplicate Transactions
# ================================================
# Identify duplicate rows clearly using duplicated():
# Example:
# Find duplicate rows
# duplicates <- retail_data[duplicated(retail_data), ]

# See duplicates clearly
# print(duplicates)

# Replace 'CustomerID' with the relevant column name

# table(data$CustomerID)  

# Output:  #C001 and C002 have more than 1 entries meaning they have duplicates.
# C001 C002 C003 C004
#   2    3    1    1 

# Try it Out #1 : Identify how many duplicates exist for the Product "Laptop". Use table() to count duplicates by CustomerID and Product combination within this category.

only_laptops <- retail_data %>%
    filter(Product == "Laptop")
duplicated_laptops <- only_laptops[duplicated(only_laptops), ]
print(only_laptops)
print(duplicated_laptops) #No duplicates for laptops. 
table(duplicated_laptops$CustomerID)


# Try it Out #2 : Identify how many duplicates exist for the Product "Winter Coat". Use table() to count duplicates by CustomerID and Product combination within this category.

only_wintercoat <- retail_data %>%
    filter(Product == "Winter Coat")
print(only_wintercoat)
duplicated_wintercoat <- only_wintercoat[duplicated(only_wintercoat), ]
print(duplicated_wintercoat) #No duplicates for winter coats 
table(duplicated_wintercoat$CustomerID)

# ================================================
# Activity 3: Removing Duplicate Transactions
# ================================================
# Remove duplicate transactions using unique():
# Example

# Remove duplicates
# clean_health_data <- unique(health_data)

# Verify removal
# nrow(health_data) - nrow(clean_health_data)


# Try it Out #1 : Remove duplicates for the Product "Laptop" and save the cleaned dataframe into a new dataframe.

clean_laptops <- unique(only_laptops)
nrow(only_laptops) - nrow(clean_laptops) #Confirms there are no duplicates to remove for laptops. 


# Try it Out #2 :Remove duplicates for the Product "Winter Coat" and save the cleaned dataframe into a new dataframe.

clean_wintercoat <- unique(only_wintercoat)
nrow(only_wintercoat) - nrow(clean_wintercoat) #Confirms there are no duplicates to remove for winter coats. 

# ================================================
# Bringing it all Together
# ================================================

# Problem #1 : Identify the necessary function(s) and code the solution.

# Goal: Find the lowest and highest UnitPrice across all products
# HINT: Use min() and max() on a single column of a data frame

# Step 1: Identify min and max values in the UnitPrice column
min_unitprice <- min(retail_data$UnitPrice)
max_unitprice <- max(retail_data$UnitPrice)

# Step 2: Print results to check your work
min_unitprice
max_unitprice


# Problem #2 : Identify the necessary function(s) and code the solution.

# Goal: Remove duplicate rows from the dataset
# HINT: Use unique() to keep only distinct rows

# Step 1: Drop duplicates
clean_retail_data <- unique(retail_data)

# Step 2: Check how many duplicates were removed
# HINT: Subtract the number of rows in the cleaned data from the original
nrow(retail_data) - nrow(clean_retail_data)
