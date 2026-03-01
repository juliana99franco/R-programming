# Ungraded Lab: Exploring Individual Variables in Healthcare Data

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("lubridate")

# Load the required libraries
library(tidyverse)
library(lubridate)
library(ggplot2)

# Load your data into R using read_csv()
pharmacy_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 3/healthcare_4.csv")

# ================================================
# Activity 1: Numerical Variable Analysis
# ================================================

# Compute the mean, median, and standard deviation for 'Quantity'.
# Example

# First compute the values
# mean_value <- mean(my_data$NumericVar, na.rm = TRUE)
# median_value <- median(my_data$NumericVar, na.rm = TRUE)
# sd_value <- sd(my_data$NumericVar, na.rm = TRUE)

# Now let's visualize the data using ggplot
# ggplot(my_data, aes(x = NumericVar)) +
    # geom_histogram(binwidth = 1, fill = "blue", color = "black") +
    # labs(title = "Distribution of Values", x = "Value", y = "Frequency")

# ggplot(my_data, aes(y = NumericVar)) +
    # geom_boxplot(fill = "lightblue", color = "black") +
    # labs(title = "Outlier Detection", y = "Value")

# Try it Out #1: Calculate and interpret key statistics for sales quantities.

# Steps:
# Compute the mean, median, and standard deviation for Quantity.
quantity_mean <- mean(pharmacy_data$Quantity, na.rm =TRUE)
print(quantity_mean) # 2.57
quantity_median <- median(pharmacy_data$Quantity, na.rm =TRUE)
print(quantity_median) # 2
quantity_sd <- sd(pharmacy_data$Quantity, na.rm = TRUE)
print(quantity_sd) # 1.24, varies a lot. 

# Visualize the distribution with a histogram.
 plot_1 <- ggplot(pharmacy_data, aes(x = Quantity)) +
    geom_histogram(binwidth = 1, fill = "blue", color = "black") +
    labs(title = "Distribution of Quantities Sold", x = "Quantity", y = "Frequency")
 print(plot_1)


# Identify outliers using a boxplot.
plot_1.1 <- ggplot(pharmacy_data, aes(x = "", y = Quantity)) +
    geom_boxplot(fill = "purple", color = "white") +
    labs(title = "Quantities Sold", y = "Quantity", x = NULL)
print(plot_1.1)

# Make inventory recommendations using comments based on the analysis.
#Since there most common quantities sold are between 1-3 units, 
#I would keep no more than 5 units in stock for each product. 
#There are not high enough outliers to justify keeping more inventory. 

# ================================================
# Activity 2: Price Analysis
# ================================================

# Compute summary statistics for 'PricePerUnit'.
# Example
# mean_value <- mean(my_data$NumericVar, na.rm = TRUE)
# median_value <- median(my_data$NumericVar, na.rm = TRUE)
# sd_value <- sd(my_data$NumericVar, na.rm = TRUE)

# ggplot(my_data, aes(x = NumericVar)) +
    # geom_histogram(binwidth = 5, fill = "green", color = "black") +
    # labs(title = "Value Distribution", x = "Value", y = "Frequency")

# ggplot(my_data, aes(y = NumericVar)) +
    # geom_boxplot(fill = "salmon", color = "black") +
    # labs(title = "Outlier Analysis", y = "Value")

# Try it Out #1: Compute and analyze the distribution of price data.

# Steps:
# Compute summary statistics for PricePerUnit.
price_mean <- mean(pharmacy_data$PricePerUnit, na.rm = TRUE)
print(price_mean) #33.33
price_median <- median(pharmacy_data$PricePerUnit, na.rm = TRUE)
print(price_median) #30.75
price_sd <- sd(pharmacy_data$PricePerUnit, na.rm = TRUE)
print(price_sd) #13.5, varies a lot too. 

# Create a histogram to visualize the price distribution.
plot_2 <- ggplot(pharmacy_data, aes(x = PricePerUnit)) +
    geom_histogram(binwidth = 5, fill = "forestgreen", color = "black") +
    labs(title = "Price Distribution", x = "Price Per Unit", y = "Count")
print(plot_2)


# Create a boxplot to identify outliers.
plot_2.1 <- ggplot(pharmacy_data, aes( x = "", y = PricePerUnit)) +
    geom_boxplot(fill = "salmon", color = "black") +
    labs(title = "Price Per Unit Outliers", y = "Price Per Unit", x = NULL)
print(plot_2.1)


# Investigate the impact of outliers and suggest pricing adjustments.
# Most prices are between 20 to 45 dollars, with some outliers well above 60. 
# I would investigate these outliers, to recognize their origin. 
# Additionally, I would investigate the low prices outliers too. 

# ================================================
# Activity 3: Categorical Analysis
# ================================================

# Generate a frequency table for 'ProductName'.

# Example
# product_freq <- table(pharmacy_data$ProductName)

# Try it Out #1: Analyze product popularity through visualization.

# Steps:
# Generate a frequency table for ProductName.
product_freq <- table(pharmacy_data$ProductName)
print(product_freq)

# Visualize the frequency with a bar chart.
plot_3 <- ggplot(pharmacy_data, aes(x = reorder(ProductName, ProductName, function(x) - length(x)))) +
    geom_bar(fill = "steelblue") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Product Popularity", x = "Product Name", y = "Count")
print(plot_3)

# Show proportions with a pie chart.
plot_3.1 <- ggplot(pharmacy_data, aes(x = "", fill = factor(ProductName))) +
    geom_bar(width = 1) +
    coord_polar("y") +
    labs(title = "Product Popularity", fill = "Product Name")
print(plot_3.1)


# Propose marketing campaigns based on the analysis.
# I would focus marketing efforts on the most popular products, as they are likely to generate more sales. 
# Additionally, I would investigate the least popular products to understand if they can be improved or if
# they should be discontinued.

# ================================================
# Activity 4: Date/Time Analysis
# ================================================

# Convert 'TransactionDate' to a Date object and extract YearMonth.
# Example
# my_data$TimeStamp <- as.Date(my_data$TimeStamp)
# my_data$TimePeriod <- format(my_data$TimeStamp, "%Y-%m")

# monthly_summary <- my_data %>%
    # group_by(TimePeriod) %>%
    # summarize(TotalValue = sum(NumericVar))

# ggplot(monthly_summary, aes(x = TimePeriod, y = TotalValue, group = 1)) +
    # geom_line(color = "darkgreen") +
    # labs(title = "Monthly Value Trend", x = "Time Period", y = "Total Value") +
    # theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Try it Out #1: Analyze temporal data for insights.

# Steps:
# Convert TransactionDate to a Date object and extract YearMonth.
str(pharmacy_data)
pharmacy_data$TransactionDate <- as.Date(pharmacy_data$TransactionDate, format = "%Y-%m-%d")
pharmacy_data$TransactionMonth <- format(pharmacy_data$TransactionDate, "%Y-%m")
print(pharmacy_data$TransactionMonth)

# Aggregate sales data by month.
monthly_sales <- pharmacy_data %>%
    group_by(TransactionMonth) %>%
    summarize(TotalMonthlySales = sum(Quantity * PricePerUnit, na.rm =TRUE))
print(monthly_sales)

# Create a time series plot to analyze trends.
plot_4 <- ggplot(monthly_sales, aes(x = TransactionMonth, y = TotalMonthlySales, group = 1)) +
    geom_line(color = "#13a5ee") +
    labs(title = "Monthly Sales Trend", x = "Month", y = "Total Sales") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(plot_4)

# Recommend stock adjustments based on the analysis.
# Sales tend to peak every 3-4 months, the decrease. I would adjust stock levels
# According to this trend, to ensure having the needed material for peak months. 
