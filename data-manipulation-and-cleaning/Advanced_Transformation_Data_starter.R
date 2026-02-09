# Ungraded Lab: Advanced Data Transformation Practice

# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse)  # This loads the tidyverse package, making its functions available.

# ================================================
# Activity 1: Load and Examine the Data
# ================================================

# Load the retail dataset (retail_set3.csv)
item_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/retail_set3.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
print(head(item_data)) # head() shows the first few rows of data.

print(str(item_data))  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 2: Creating New Calculated Fields
# ================================================
# Create a new field named composite_score by combining existing fields. This example weights ratings and customer reviews.

# Example:
item_data <- item_data %>%
  mutate(composite_score = (Rating * 0.7 + Customer_Reviews * 0.3))

#Add a new binary variable, fast_shipping, to indicate whether the item has a shipping speed of "Fast".

#Example:
item_data <- item_data %>%
  mutate(fast_shipping = if_else(Shipping_Speed == "Fast", TRUE, FALSE))

#Additionally, create a new field called revenue by multiplying the Price by the Customer_Reviews to estimate the total revenue for each item. 

item_data <- item_data %>%
  mutate(revenue = Price * Customer_Reviews)

#output
head(item_data)


# Try it Out #1 : Create the new variable using mutate().
item_data <- item_data %>%
  mutate(eco_friendly = if_else(Category == "Eco-Friendly", TRUE, FALSE))
print(head(item_data))


# ================================================
# Activity 3: Summarizing Data
# ================================================
# Calculate the average rating for all items.

# Example
avg_rating <- item_data %>%
  summarize(avg_rating = mean(Rating, na.rm = TRUE))
print(avg_rating)

#Calculate the total revenue for each category.

#Example
category_revenue_summary <- item_data %>%
  group_by(Category) %>%
  summarize(total_revenue = sum(revenue, na.rm = TRUE))
print(category_revenue_summary)

#Calculate the total revenue for items that have "Fast" shipping speed. Use the filter() to select them before summarizing.

#Example
fast_shipping_summary <- item_data %>%
  filter(Shipping_Speed == "Fast") %>%
  group_by(Category) %>%
  summarize(total_revenue = sum(revenue, na.rm = TRUE))
print(fast_shipping_summary)

#Find the overall count of items in each category to understand product distribution.

#Example
category_item_count <- item_data %>%
  group_by(Category) %>%
  summarize(item_count = n())
print(category_item_count)


# Try it Out #1 : Summarize the count of fast shipping items for each category using summarize().

category_by_shipping <- item_data %>%
  filter(Shipping_Speed == "Fast") %>%
  group_by(Category) %>%
  summarize(item_count = n())
print(category_by_shipping)

# ================================================
# Activity 4: Performing Grouped Analysis
# ================================================
# Compare average customer reviews and total revenue within each shipping speed to understand how shipping speed impacts sales and satisfaction.

# Example
shipping_analysis <- item_data %>%
  group_by(Shipping_Speed) %>%
  summarize(
    avg_rating = mean(Rating, na.rm = TRUE),
    revenue = sum(revenue, na.rm = TRUE)
  )
print(shipping_analysis)

# Analyze and compare category rating performance based on total revenue.

# Example
# category_performance_analysis <- item_data %>%
#   group_by(Category) %>%
#   summarize(
#     avg_rating = mean(Rating, na.rm = TRUE),
#     revenue = sum(total_revenue, na.rm = TRUE)
#   )
# print(category_performance_analysis)

#Combine category and shipping speed for a more detailed analysis to identify trends within specific segments.

# Example
# combined_analysis <- item_data %>%
#   group_by(Category, Shipping_Speed) %>%
#   summarize(
#     avg_rating = mean(Rating, na.rm = TRUE),
#     revenue = sum(total_revenue, na.rm = TRUE)
#   )
# print(combined_analysis)


# Try it Out #1 : Summarize the total revenue for standard shipping items by category using group_by() and summarize(). Save in a variable called "revenue".

revenue <- item_data %>%
  filter(Shipping_Speed == "Standard") %>%
  group_by(Category) %>%
  summarize(total_revenue = sum(revenue, na.rm =TRUE))
print(revenue)

# ================================================
# Bringing it all Together
# ================================================
# Fill in the blanks with the appropriate code below:

# Problem #1 : Create a report that highlights average rating and total revenue.

# Step 1: Calculate average rating for each category
avg_rating_by_category <- item_data %>%
  group_by(Category) %>%
  summarize(avg_rating = mean(Rating, na.rm = TRUE))
  # Group by Category, then calculate the average rating (excluding missing values)

print(avg_rating_by_category)

# Step 2: Calculate total revenue for each category
total_revenue_by_category <- item_data %>%
  group_by(Category) %>%
  summarize(total_revenue = sum(revenue, na.rm = TRUE))
  # Group by Category, then sum up the revenue (ignoring NA values)

print(total_revenue_by_category)
# Step 3: Combine both summaries into a final report
final_report <- avg_rating_by_category %>%
  inner_join(total_revenue_by_category, by = "Category")
  # Join the two summaries on the Category column
print(final_report)
