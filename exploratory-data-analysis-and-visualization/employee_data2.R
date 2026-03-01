# Ungraded Lab: Complex Pattern Recognition

# Load necessary libraries
library(ggplot2)      # Visualization framework
library(tidyverse)    # Data wrangling and reshaping

# Load the dataset
retail_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/retail_9.csv")
str(retail_data)

# ================================
# Activity 1: Sales-Profit-Quantity Relationships
# ================================

# Create a new column: `Sales = Price * Amount`
# Plot `Cat_A` vs `Cat_B`
# Plot `Cat_C` vs `Cat_D` with color = CAT_E

# Example
# ggplot(retail_data, aes(x = Cat_A, y = Cat_B)) +
    # geom_point()

# ggplot(retail_data, aes(x = Cat_C, y = Cat_D, color = Cat_E)) +
    # geom_point()

# Try It Out #1: Volume vs. Profit by Product Category

# Create a new TotalSales column
retail_data <- retail_data %>%
    mutate(TotalSales = UnitPrice * QuantityOrdered)

# Scatter plot: TotalSales vs ProfitAmount
plot_1 <- ggplot(retail_data, aes(x = TotalSales, y = ProfitAmount)) +
    geom_point(color = "darkred") +
    labs(title = "Total Sales vs Profit Amount", x = "Total Sales", y = "Profit Amount")
print(plot_1)

# Scatter plot: QuantityOrdered vs ProfitAmount and color by ProductCategory
plot_1.1 <- ggplot(retail_data, aes(x = QuantityOrdered, y = ProfitAmount, color = ProductCategory)) +
    geom_point() + 
    labs(title = "Quantity vs Profit Amount By Product Category", x = "Quantity", y = "Profit")
print(plot_1.1)

# ================================
# Activity 2: Customer-Product-Region Patterns
# ================================

# Summarize TotalSales by Region
# Create a bar chart with geom_bar(stat = "identity") with Region as x and TotalSales as y
# Use group_by() and summarize() to find average UnitPrice


# Try It Out #2: Avg UnitPrice by ProductCategory within Region

# Summarize TotalSales by Region 
total_by_region <- retail_data %>%
    group_by(Region) %>%
    summarize(TotalRegion = sum(TotalSales))
print(total_by_region)

# Create a bar chart with geom_bar(stat = "identity") with Region as x and TotalSales as y
plot_2 <- ggplot(retail_data, aes(x = Region, y = TotalSales)) +
    geom_bar(stat = "identity") +
    labs(title = "Sales across Region", x = "Region", y = "Sales")
print(plot_2)

# Use group_by() and summarize() to find average UnitPrice
avg_unit_price <- retail_data %>%
    group_by(Region, ProductCategory) %>%
    summarize(AvgPrice = mean(UnitPrice, na.rm = TRUE))

# ================================
# Activity 3: Time-Price-Demand Connections
# ================================
# Example:
# Aggregate TotalSales by OrderSeason
# sales_by_season <- aggregate(Cat_A ~ Cat_B, retail_data, sum)


# Try It Out #3: 
# Aggregate TotalSales by OrderSeason
seasonal_sales <- aggregate(TotalSales ~ OrderSeason, data = retail_data, FUN = sum)

# Use geom_line() to visualize seasonal sales patterns. Show TotalSales across OrderSeason
plot_3 <- ggplot(seasonal_sales, aes( x = OrderSeason, y = TotalSales, group = 1)) +
    geom_line(color = "darkred") +
    labs(title = "Sales by Season", x = "Season", y = "Sales") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(plot_3)
