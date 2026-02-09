# Ungraded Lab: String Functions in Action

# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse)  # This loads the tidyverse package, making its functions available.

# ================================================
# Activity 1: Detecting Patterns with str_detect()
# ================================================
# Check for "iPhone" or "Galaxy" in the ProductDescription column:
# Example:

# Add stringr library
library(stringr)

# Load survey dataset
#example_retail_data <- read.csv("your_retail_set.csv")

# Detect products with "iPhone" or "Galaxy"
iphone_galaxy_products <- str_detect(example_retail_data$ProductDescription, "iPhone|Galaxy")

# Display the matching rows
#print(example_retail_data[iphone_galaxy_products, ])


# Try it Out #1 : Load the datast. Then, detect products with "Pixel" in the ProductDescription column using str_detect().

dataset_6 <- read.csv("/Users/juliana/Desktop/R Programming/Course 2/retail_set6.csv")
print(dataset_6)
pixel_products <- str_detect(dataset_6$ProductDescription, "Pixel")
print(pixel_products)
print(dataset_6[pixel_products, ])

# Try it Out #2 : Detect products with "Motorola" in the ProductDescription column using str_detect().

motorola_products <- str_detect(dataset_6$ProductDescription, "Motorola")
print(dataset_6[motorola_products,])

# ================================================
# Activity 2: Pinpointing Patterns with str_which()
# ================================================
# Check for "Unlocked"

# Example:
# Locate indices of products with "Unlocked"
# unlocked_indices <- str_which(example_retail_data$ProductDescription, "Unlocked")

# Show the rows at these specific locations
# print(example_retail_data[unlocked_indices, ])


# Try it Out #1 : Locate the row indices of products with "Prepaid" in the ProductDescription column using str_which().

prepaid_items <- str_which(dataset_6$ProductDescription, "Prepaid")
print(dataset_6[prepaid_items, ])

# Try it Out #2 : Locate the row indices of products with " Protector" in the ProductDescription column using str_which().

protector_items <- str_which(dataset_6$ProductDescription, "Protector")
print(dataset_6[protector_items, ])


# ================================================
# Activity 3: Extracting Key Details with str_extract() and str_extract_all()
# ================================================
# Extract storage sizes:

# Example
# Extract storage sizes from product descriptions
# storage_sizes <- str_extract(retail_data$ProductDescription, "[0-9]+GB")
# print(storage_sizes)


# Try it Out #1 : Extract colors using str_extract() from the ProductDescription column.

color_devices <- str_extract_all(dataset_6$ProductDescription, "Blue|Red|White|Black|Gray")
print(color_devices) # Prints a list containing extracted colors for each product description.
print(dataset_6[color_devices != "", ]) # Display rows with extracted colors

# ================================================
# Bringing it all Together
# ================================================

# Problem #1 : Identify the necessary function(s) and code the solution.

# Goal: Find all products that mention BOTH "128GB" and "Blue" in their descriptions.
# HINT:
# Use str_detect() to check if text contains a specific word or number.
# Use & to require that BOTH conditions must be true.

blue_128gb_products <- dataset_6[
  str_detect(dataset_6$ProductDescription, "128GB") &   # Look for "128GB"
  str_detect(dataset_6$ProductDescription, "Blue"),    # Look for "Blue"
]
print(blue_128gb_products)


# Problem #2 : Identify the necessary function(s) and code the solution.

# Goal: Find all "Unlocked" products that are either Blue, White, or Gray.
# HINT:
# Use | inside a string to mean OR (e.g., "Blue|White|Gray")
# Combine with & to require both "Unlocked" AND one of the colors

unlocked_color_products <- dataset_6[
  str_detect(dataset_6$ProductDescription, "Unlocked") & 
  str_detect(dataset_6$ProductDescription, "Blue|White|Gray"),
]
print(unlocked_color_products)
