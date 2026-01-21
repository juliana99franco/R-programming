# ===============================================================
# FitLife Fitness Club Loyalty Program Analysis - Starter Code
# ===============================================================

# === Step 1: Data Import & Cleaning ===

# Make sure to import any packages or libraries needed
library(dplyr)

# Import customer_data.csv and loyalty_data.csv
customer_data <- read.csv("/Users/juliana/Desktop/R Programming/Sample 1/data/customer_data.csv")
loyalty_data <- read.csv("/Users/juliana/Desktop/R Programming/Sample 1/data/loyalty_data.csv")

# Check initial data structures
print("Initial customer data structure:")
str(customer_data)
print("Initial loyalty data structure:")
str(loyalty_data)

# Handle any missing values in the `Age` and `PurchaseAmount` columns using the filter function.
customer_data <- customer_data %>% filter(!is.na(Age) & !is.na(PurchaseAmount))

# Verify data types and print the structure of the data frames.
print("Cleaned customer data structure:")
str(customer_data)
print(sum(is.na(customer_data$Age)))
print(sum(is.na(customer_data$PurchaseAmount)))

# Hint: Use `str()` to check the structure and `!is.na())` to find missing values.

# === Step 2: Customer Analysis ===

# Filter data by Age > 30
Above_30 <- customer_data %>% filter(Age > 30)
str(Above_30)

# Filter data for Female customers who bought Yoga Class
df_filtered <- customer_data %>% filter( Gender == "Female" & Product == "Yoga Class")
str(df_filtered)

# Select the Age and Product columns
df_selected <- customer_data %>% select(Age, Product)
str(df_selected)

# Hint: Use functions like `filter()` for filtering and `select()` from `dplyr` package for column selection.

# === Step 3: Loyalty Program Analysis ===
# Create a new column in loyalty_data called Tier
loyalty_data <- loyalty_data %>% mutate(Tier = case_when(
    LoyaltyPoints >= 500 ~ "Gold", 
    LoyaltyPoints >= 200 & LoyaltyPoints < 500 ~"Silver", 
    LoyaltyPoints < 200 ~"Bronze"

))
str(loyalty_data)

# Create new column called PurchaseAmount_EUR
customer_data <- customer_data %>% mutate(
    PurchaseAmount_EUR = PurchaseAmount * 0.92
)
str(customer_data)

# Hint: Think back to how we created new columns using existing data. For the first task, use a tool that helps apply different labels based on multiple conditions. For the second task, use arithmetic inside a transformation.


# === Step 4: Report Generation ===

# Export the two dataset (customer_data & loyalty_data) as csv files and save the report as `revised_customer_analysis_report.csv` and revised_loyaltyfitlife_analysis_report.csv.
write.csv(customer_data, "/Users/juliana/Desktop/R Programming/Sample 1/data/revised_customer_analysis_report.csv", row.names = FALSE)
write.csv(loyalty_data, "/Users/juliana/Desktop/R Programming/Sample 1/data/revised_loyaltyfitlife_analysis_report.csv", row.names = FALSE)
# Hint: Use functions like `write.csv()` to compile text and save to csv file.
