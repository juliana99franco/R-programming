# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse) # This loads the tidyverse package, making its functions available.

# Load the retail dataset (retail_set11.csv)
retail_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/retail_set11.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
str(retail_data)  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 1: Detecting Missing Values
# ================================================
# Add comments to guide Copilot in generating code to detect missing values.
# Example:

# Check if there are missing values in the dataset
any(is.na(retail_data)) # Returns TRUE if there are missing values, otherwise FALSE


# Try it Out #1 : Identify missing values in the "Customer ID" column, first separated and then counting them.
customer_id_missing <- is.na(retail_data$CustomerID)
sum(customer_id_missing)

# Try it Out #2 : Identify missing values in the "TransactionDate" column, first separated and then counting them.
transaction_date_missing <- is.na(retail_data$TransactionDate)
sum(transaction_date_missing)

# ================================================
# Activity 2: Imputing Missing Values
# ================================================
# Use comments to employ Copilot to generate input code. Focus on replacing NAs in 'ReviewRating' with the column's median value.
# Example:

# Impute missing values in ReviewRating with median
retail_data$ReviewRating[is.na(retail_data$ReviewRating)] <- median(retail_data$ReviewRating, na.rm = TRUE)

# Try it Out #1 : Impute missing values in the "UnitPrice" column with the column's median value
retail_data$UnitPrice[is.na(retail_data$UnitPrice)] <- median(retail_data$UnitPrice, na.rm = TRUE)
is.na(retail_data$UnitPrice) # Check if there are still any NAs in the UnitPrice column

# Try it Out #2 : Impute missing values in the "ReviewRating" column with the column's mean value, then check everything went well.
retail_data$ReviewRating[is.na(retail_data$ReviewRating)] <- mean(retail_data$ReviewRating, na.rm = TRUE)
is.na(retail_data$ReviewRating) # Check if there are still any NAs in the ReviewRating column

# ================================================
# Activity 3: Anomaly Detection
# ================================================
# Use comments to help Copilot generate a script that flags abnormally high or low prices and quantities, applying realistic thresholds based on your understanding of retail transactions.
# Example


# Detect anomalies in Quantity
filtered_data <- retail_data %>%
  filter(Quantity < 1 | Quantity > 100)

print(filtered_data)

# Try it Out #1 : Detect anomalies in UnitPrice, flagging transactions where the price is lower than $5.
filtered_data_price <- retail_data %>%
  filter(UnitPrice < 5)

# Try it Out #2 : Detect anomalies in Quantity, flagging those that are above 10
filtered_data_quantity <- retail_data %>%
  filter(Quantity > 10)


