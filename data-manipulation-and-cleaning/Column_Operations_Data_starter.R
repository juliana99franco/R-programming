# Ungraded Lab: Column Operations Practice

# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse)  # This loads the tidyverse package, making its functions available.


# ================================================
# Activity 1: Load and Examine the Data
# ================================================

# Load the retail dataset (retail_set5.csv)
customer_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/retail_set5.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
str(customer_data)  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 2: Separating Combined Address Data
# ================================================
# Separate the address column into street, city, state, and ZIP code.

# Example:
# Separate the combined 'address' column

# customer_data_clean <- customer_data %>%
#  separate(Address, into = c("street", "city", "state_zip"), sep = ", ")


# Try it Out #1 : For customers in the Phoenix and Seattle regions, separate the address column into street, city, and state_ZIP code.

customer_data_clean <- customer_data %>%
  separate(Address, into = c("street", "city", "state_zip"), sep = ", ")
data_phoenix_seattle <- customer_data_clean %>%
  filter(city == "Phoenix" | city == "Seattle")
print(data_phoenix_seattle)

# ================================================
# Activity 3: Uniting Customer Name Columns
# ================================================
# Let's say an example dataset includes first_name and last_name fields and you wanted to convert these into a single, formatted "full_name" column. You could use code similar to the following:
# Example
# Unite names into a single column
# names_united <- customer_data %>%
#  unite(full_name, first_name, last_name, sep = " ")


# Try it Out #1 : Combine FullName and CustomerID fields into a single, formatted "FullName_ID" column. Save to variable called names_united.

names_united <- customer_data %>% 
  unite(FullName_ID, FullName, CustomerID, sep=" ")
print(names_united)

# ================================================
# Activity 4: Manage Addresses with Custom Separators
# ================================================
# Separate combined address data using ";" as a custom separator.

# Example dataset
 address_data <- data.frame(
  customer_id = c(101, 102, 103),
  address = c("10 Elm Street;Boston;MA;02101", 
             "42 Oak Road;Austin;TX;73301", 
             "425 Vine St.;Seattle;WA;98101"))
print(address_data)

# Separate columns using ";" as the separator
# address_data_clean <- address_data %>%
#  separate(address, into = c("street", "city", "state", "zip"), sep = ";")

# Try it Out #1 : For older customer records using semicolons, separate the 'address' column into street, city, state, and zip.

address_data_clean <- address_data %>% 
  separate(address, into= c("Street", "City", "State", "Zip"), sep = ";")
print(address_data_clean)


# ================================================
# Bringing it all Together
# ================================================

# Step 1: Unite FullName and CustomerID into a single column
customer_data <- customer_data %>%
  unite(FullName_ID, FullName, CustomerID, sep = " ")

# Step 2: Separate the 'Address' column into street, city, and state_zip
customer_data_clean <- customer_data %>%
  separate(Address,
           into = c("Street", "City", "State_zip"),
           sep = ", ")

# Step 3: Preview the cleaned data
print(customer_data_clean)

