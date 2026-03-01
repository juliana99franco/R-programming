# ================================================
# Sample Project 1: Finance Transactions Summary
# SOLUTION CODE with Comments
# ================================================

# Load libraries
library(dplyr)      # For data manipulation
library(ggplot2)    # For plotting
library(plotly)     # For interactivity
library(lubridate)  # For date functions

# Load dataset
finance_df <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/finance_transactions.csv")
str(finance_df)


# ================================================
# Activity 1: Clean and Prepare Date Data
# ================================================

# Practice Challenges:
# Convert TransactionDate to Date format
finance_df$TransactionDate <- as.Date(finance_df$TransactionDate, format = "%Y-%m-%d")
str(finance_df) # Confirm date transformation. 

# Extract month and year in the format "YYYY-MM"
finance_df$Month <- format(finance_df$TransactionDate, "%Y-%m")
print(head(finance_df$Month))


# ================================================
# Activity 2: Explore Transaction Amounts by Customer Group
# ================================================

# Practice Challenges:

# Group by age group, calculate average, and sort in descending order
finance_summary <- finance_df %>%
  group_by(Age) %>%
  mutate(AverageAmount = mean(Amount, na.rm = TRUE)) %>%
  arrange(desc(AverageAmount))
print(finance_summary)


# ================================================
# Activity 3: Visualize Channel and Transaction Type Relationships
# ================================================

# Practice Challenges:

# Count number of transactions by category
channel_summary <- finance_df %>%
  count(Channel, TransactionType)
print(channel_summary)

# Build ggplot chart
p <- ggplot(channel_summary, aes(x = Channel, y = n, fill = TransactionType)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Transactions by Channel and Type", x = "Channel", y = "Count")

# Make interactive
print(plotly::ggplotly(p))

# ================================================
# Activity 4: Analyze Monthly Account Activity Trends
# ================================================

# Practice Challenges:

# Extract numeric month to control plot order
finance_df$MonthNum <- as.numeric(format(finance_df$TransactionDate, "%m"))
print(head(finance_df$MonthNum))


# Group and summarise transactions
monthly_summary <- finance_df %>%
  group_by(MonthNum, AccountType) %>%
  mutate(TotalTransactions = n())
print(monthly_summary$MonthNum)

# Plot monthly line chart
p2 <- ggplot(monthly_summary, aes(x = MonthNum, y = TotalTransactions, color = AccountType)) +
  geom_line() +
  scale_x_discrete(labels = month.name[monthly_summary$MonthNum]) +
  labs(title = "Monthly Account Activity", x = "Month", y = "Total Transactions")

print(p2)

# ================================================
# Activity 5: Analyze Transaction Sizes by Channel
# ================================================

# Create TransactionSize
finance_df <- finance_df %>%
  mutate(TransactionSize = case_when(
    Amount < 100 ~ "Small",
    Amount >= 100 & Amount < 1000 ~ "Medium",
    Amount >= 1000 ~ "Large"
  ))

# Count by Channel and Size
size_summary <- finance_df %>%
  count(Channel, TransactionSize)
print(size_summary)

# Plot interactive bar chart
p3 <- ggplot(size_summary, aes(x = Channel, y = n, fill = TransactionSize)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Transaction Sizes by Channel", y = "Count", x = "Channel")

print(plotly::ggplotly(p3))
