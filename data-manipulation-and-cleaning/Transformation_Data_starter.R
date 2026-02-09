# Load the tidyverse library
library(tidyverse)  # This loads the tidyverse package, making its functions available.

# ================================================
# Activity 1: Inspecting Your Dataset Structure
# ================================================

# Step 1:  Load the retail dataset (retail_set2.csv)
retail_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/retail_set2.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Step 2: Examine the data structure
print(head(retail_data)) #head() shows the first few rows of data

print(str(retail_data))   # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 2: Creating Calculated Variables
# ================================================
# Create the new variable using mutate():

# Example:
# retail_data <- retail_data %>%
#  mutate(total_review_score = Rating * Customer_Reviews)


# Try it Out #1 : Create a new column called "potential_revenue," calculated as Price × Customer_Reviews. This will help them gauge how much each product can earn based on customer reviews.Create the new variable using mutate().

retail_data <- retail_data %>% mutate(
  potential_revenue = Price * Customer_Reviews
)
print(head(retail_data))

# Try it Out #2 : Create a new column called "value_ratio," calculated as Price ÷ Rating. This metric will help them assess the cost-effectiveness of products based on their ratings.

retail_data <- retail_data %>% mutate(
  value_ratio = Price / Rating
)
print(head(retail_data))

# View your data using print()

# ================================================
# Activity 3: Summarizing Data
# ================================================
# Summarize average rating by category using summarize():

# Example
# average_rating_by_category <- retail_data %>%
#   group_by(Category) %>%
#   summarize(avg_rating = mean(Rating))

# print(average_rating_by_category)


# Try it Out #1 : Summarize the total number of customer reviews by category using summarize().

average_reviews_category <- retail_data %>%
  group_by (Category) %>%
  summarize(sum(Customer_Reviews))
print(head(average_reviews_category))

# Try it Out #2 : Summarize the average price by shipping speed using summarize().

average_price_shipping <- retail_data %>%
  group_by (Shipping_Speed) %>%
  summarize(mean(Price))
print(head(average_price_shipping))

# ================================================
# Activity 4: Grouping Data with group_by()
# ================================================
# Summarize average ratings grouped by product category using group_by() and summarize():

# Example
# ratings_by_category <- retail_data %>%
#  group_by(Category) %>%
#  summarize(average_rating = mean(Rating))

# print(ratings_by_category)


# Try it Out #1 : Summarize the number of reviews per shipping speed using summarize().

reviews_speed <- retail_data %>%
  group_by(Shipping_Speed) %>%
  summarize(sum(Customer_Reviews))
print(reviews_speed)

# Try it Out #2 : Using mutate(), group_by(), and summarize(), summarize the average rating grouped by two price ranges: above $100 and at $100 or below.

price_ranges <- retail_data %>% 
  mutate(price_range = ifelse(Price > 100, "Above $100", "At $100 or Below")) %>%
  group_by(price_range) %>%
  summarize(mean(Rating))
print(price_ranges)

# ================================================
# Bringing it all Together
# ================================================

# Fill in the blanks with the appropriate code below:

# Problem #1

books_revenue <- retail_data %>%
  mutate(total_revenue = Price * Customer_Reviews) %>%
  filter(Category == "Books"
         & Price > 10) %>%
  summarize(revenue_books_10 = sum(total_revenue))

print(books_revenue)

# Problem #2

sports_ratings_by_shipping <- retail_data %>%
  filter(Category == "Sports & Outdoors") %>%
  group_by(Shipping_Speed) %>%
  summarize(avg_rating = mean(Rating))

print(sports_ratings_by_shipping)
