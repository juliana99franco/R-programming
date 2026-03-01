# Ungraded Lab: Advanced Univariate Analysis Techniques

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("lubridate")

# Load required libraries
library(tidyverse)
library(lubridate)
library(ggplot2)      # Extensive plotting capabilities

# Load your dataset
retail_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 3/retail_5.csv")

# ================================================
# Activity 1: Numerical Variable Analysis
# ================================================

# Compute the mean, median, and standard deviation for Quantity
# Visualize distribution using a histogram
# Identify outliers using a boxplot

# Example
# mean_value <- mean(my_data$NumericVar)
# median_value <- median(my_data$NumericVar)
# sd_value <- sd(my_data$NumericVar)

# ggplot(my_data, aes(x = NumericVar)) +
#   geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
#   labs(title = "Value Distribution", x = "Value", y = "Frequency")

# ggplot(my_data, aes(y = NumericVar)) +
#   geom_boxplot(fill = "lightblue", color = "black") +
#   labs(title = "Outlier Detection", y = "Value")

# Try It Out #1: You're analyzing product movement to inform stock decisions.
# Steps:
# Calculate summary statistics for Quantity
mean_quantity <- mean(retail_data$Quantity, na.rm = TRUE)
print(mean_quantity) # 1.82
median_quantity <- median(retail_data$Quantity, na.rm = TRUE)
print(median_quantity) # 2
sd_quantity <- sd(retail_data$Quantity, na.rm = TRUE)
print(sd_quantity) # 0.75, it isn't that high, but indicates certain variability. 


# Use geom_histogram to visualize distribution
plot1 <- ggplot(retail_data, aes(x = Quantity)) +
    geom_histogram(binwidth = 1, fill = "forestgreen", color = "black") +
    labs(title = "Quantity Distribution", x = "Quantity", y = "Frequency")
print(plot1)


# Use geom_boxplot to detect outliers
plot1.1 <- ggplot(retail_data, aes(x = "", y = Quantity)) +
    geom_boxplot(fill = "orange", color = "black") +
    labs(title = "Quantity Outlier Detection", y = "Quantity", x = NULL)
print(plot1.1)

# ================================================
# Activity 2: Price Analysis
# ================================================

# Compute the mean, median, and standard deviation for UnitPrice
# Visualize the distribution using a histogram
# Identify pricing outliers with a boxplot

# Example
# mean_value <- mean(my_data$NumericVar)
# median_value <- median(my_data$NumericVar)
# sd_value <- sd(my_data$NumericVar)

# ggplot(my_data, aes(x = NumericVar)) +
#   geom_histogram(binwidth = 5, fill = "green", color = "black") +
#   labs(title = "Value Distribution", x = "Value", y = "Frequency")

# ggplot(my_data, aes(y = NumericVar)) +
#   geom_boxplot(fill = "salmon", color = "black") +
#   labs(title = "Outlier Detection", y = "Value")


# Try It Out #1: Investigate whether prices are clustered or widely spread to inform pricing strategy.
# Steps:
# Summarize UnitPrice with descriptive stats
mean_price <- mean(retail_data$UnitPrice, na.rm = TRUE)
print(mean_price) # 53.5
median_price <- median(retail_data$UnitPrice, na.rm = TRUE)
print(median_price) # 47.5
sd_price <- sd(retail_data$UnitPrice, na.rm = TRUE)
print(sd_price) # 26.4, very variable data. 

# Create a histogram and boxplot for price distribution
plot2 <- ggplot(retail_data, aes(x = UnitPrice)) +
    geom_histogram(binwidth = 5, fill = "forestgreen", color = "black") +
    labs(title = "Price Distribution", x = "Price", y = "Frequency")
print(plot2)

# Reflect on pricing tiers or anomalies
# There are weird gaps between and certain outliers. 
# Checking with a boxplot. 
plot2.1 <- ggplot(retail_data, aes(x = "", y = UnitPrice)) +
    geom_boxplot(fill = "orange", color = "black") +
    labs(title = "Price Outlier Detection", y = "Price", x = NULL)
print(plot2.1)

# Boxplot confirms an outlier at 125. 
# Additionally, the main price range is from 30- 60, eventhough there are up until 75. 


# ================================================
# Activity 3: Categorical Analysis
# ================================================

# Generate a frequency table for ProductName
# Visualize product frequency using a bar chart
# Explore PaymentMethod distributions

# Example
# table(my_data$CategoryVar)

# ggplot(my_data, aes(x = reorder(CategoryVar, CategoryVar, function(x) -length(x)))) +
#   geom_bar(fill = "steelblue") +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#   labs(title = "Category Frequency", x = "Category", y = "Count")

# ggplot(my_data, aes(x = SubCategoryVar)) +
#   geom_bar(fill = "lightgreen", color = "black") +
#   labs(title = "Subcategory Distribution", x = "Subcategory", y = "Frequency")


# Try It Out #1: Which products are customer favorites? Which payment methods dominate?
# Steps:
# Use table() and ggplot2 to visualize ProductName frequency
product_distribution <- table(retail_data$ProductName)
print(product_distribution) #Even distribution, checking with pie chart.  
plot3 <- ggplot(retail_data, aes(x = "", fill = factor(ProductName))) +
    geom_bar(width = 1) +
    coord_polar("y") +
    labs(title = "Product Distribution", fill = "Product Name")
print(plot3)


# Create a bar chart for PaymentMethod
plot3.1 <- ggplot(retail_data, aes(x = reorder(PaymentMethod, PaymentMethod, function(x) - length(x)))) +
    geom_bar(fill = "#0d5e6e") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
    labs(title = "Payment Method Preferences", x = "Payment Method", y = "Count")
print(plot3.1)

# Consider how this informs promotions or operations
# All products are equally popular, so promotions should include all products equally. 
# Additionally, the most popular PM is card, which should be the focus of promotions. 

# ================================================
# Activity 4: Date/Time Analysis
# ================================================

# Convert OrderDate to Date format
# Create a YearMonth variable
# Aggregate and visualize monthly sales totals

# Example
# my_data$TimeStamp <- as.Date(my_data$TimeStamp)
# my_data$TimePeriod <- format(my_data$TimeStamp, "%Y-%m")

# monthly_summary <- my_data %>%
#   group_by(TimePeriod) %>%
#   summarize(TotalValue = sum(NumericVar))

# ggplot(monthly_summary, aes(x = TimePeriod, y = TotalValue, group = 1)) +
#   geom_line(color = "purple") +
#   labs(title = "Monthly Value Trend", x = "Time Period", y = "Total Value") +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Try It Out #1: You’re presenting to leadership about seasonal shopping patterns.
# Steps:
# Create a YearMonth column
str(retail_data)
retail_data$YearMonth <- format(retail_data$OrderDate, "%Y-%m")


# Summarize total sales by month
monthly_sales <- retail_data %>%
    group_by(YearMonth) %>%
    summarize(TotalSales = sum(UnitPrice * Quantity, na.rm = TRUE))

# Plot with geom_line()
plot4 <- ggplot(monthly_sales, aes(x = YearMonth, y = TotalSales, group = 1)) +
    geom_line(color = "#690b8b", linewidth = 2) +
    labs(title = "Monthly Sales Trend", x = "Month", y = "Sales") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(plot4)
