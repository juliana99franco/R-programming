# ================================================
# Investment Portfolio Analysis
# Practice Project 2 - Starter Code
# ================================================
library(dplyr)

# ================================================
# Activity 1: Data Import & Cleaning
# ================================================

# Check for missing values in a specific column
# is.na(data_set$column)

# Remove rows where that column has missing values
# new_data <- filter(old_data, !is.na(column))

### CHALLENGE 1 #### 

# Import transaction_data.csv and portfolio_data.csv
transaction_data <- read.csv("/Users/juliana/Desktop/R Programming/Sample 2/data/transaction_data.csv")
portfolio_data <- read.csv("/Users/juliana/Desktop/R Programming/Sample 2/data/portfolio_data.csv")

# Print the structure of both datasets using str()
str(transaction_data)
str(portfolio_data)

# Handle missing values
# 1. Find missing ages in portfolio_data
# 2. Remove missing values using filter()
# 3. Verify no missing ages remain

# Find missing ages in portfolio_data
any_missing_ages <- is.na(portfolio_data$Age)
print(paste("Checking for missing values", any_missing_ages))

# Remove missing values using filter()
portfolio_data <- portfolio_data %>% filter(!is.na(portfolio_data$Age))

# Verify no missing ages remain
remaining_na_values <- sum(is.na(portfolio_data$Age))
print(paste("Checking for remaining missing values after filtering:", remaining_na_values))



# ================================================
# Activity 2: Basic Data Analysis
# ================================================

# Example Code:
# Filter with a single condition
# df_filtered <- set_data %>% filter(Condition1 == "value")

# Filter with multiple conditions
# df_filtered <- set_data %>% filter(Condition1 == "value" & Condition2 > value)

# Select specific columns
# df_selected <- set_data %>% select(Column1, Column2)

### CHALLENGE 2 ###
# - Filter and Select Transaction Data
# - Filter transaction_data for Amount > 10000. Save in Above_10000
# - Filter portfolio_data for Category "A" Clients that are older than 40 . Save in df_filtered.
# - Select data from df_filtered (ClientID, Age, Category). Store in df_selected

# - Filter transaction_data for Amount > 10000. Save in Above_10000
Above_10000 <- transaction_data %>% filter(Amount > 10000)
print(head(Above_10000))

# Filter Data for Category "A" Clients that are older than 40 years old. Save in df_filtered
df_filtered <- portfolio_data %>% filter(Category == "A" & Age > 40)
print(head(df_filtered))

# Select the ClientID, Age, and Category columns
# Store in df_selected
df_selected <- portfolio_data %>% select(ClientID, Age, Category)
print(head(df_selected))

# ================================================
# Activity 3: Client Tier Analysis
# ================================================

### CHALLENGE 3 ###
# Create a new column (Tier)  that categorizes clients based on their salary range on the Above_10000 dataframe:
# - Low Salary < 40000
# - Medium Salary < 60000
# - High Salary >= 60000

Above_10000 <- Above_10000 %>%
    mutate(Tier = case_when(
        Salary < 40000 ~"Low Salary",
        Salary < 60000 ~"Medium Salary",
        TRUE ~"High Salary"
    ))
print(head(Above_10000))

# ================================================
# Activity 4: Report Generation
# ================================================

### CHALLENGE 4 ###
# Generate analysis report
# Save report as a csv named df_filtered to revised_portfolio.csv and Above_1000 to revised_transactions.csv
write.csv(df_filtered, "/Users/juliana/Desktop/R Programming/Sample 2/data/revised_portfolio.csv")
write.csv(Above_10000, "/Users/juliana/Desktop/R Programming/Sample 2/data/revised_transactions.csv")
