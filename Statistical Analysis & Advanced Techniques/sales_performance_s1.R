# ================================================
# Sample Project 1: Sales Performance Prediction
# ================================================

# Load required packages
library(tidyverse)     # Data manipulation and visualization
library(broom)         # Tidying model outputs
library(car)           # Diagnostic tools for linear models


# Load dataset
sales_df <- read_csv("sales_performance_s1.csv")

# ================================================
# Activity 1: Prepare and Explore the Data
# ================================================

# Step 1: Check structure and summary
str(sales_df)
summary(sales_df)

# Step 2: Identify and remove missing values
sum(is.na(sales_df))
drop_na(sales_df)

# Step 3: Compute mean and standard deviation  SalesAmount, UnitsSold, and UnitPrice
sales_summary <- sales_df %>%
    summarise(
        mean_sales = mean(SalesAmount, na.rm = TRUE), 
        sd_sales = sd(SalesAmount, na.rm = TRUE), 
        mean_units = mean(UnitsSold, na.rm = TRUE), 
        sd_units = sd(UnitsSold, na.rm = TRUE), 
        mean_price = mean(UnitPrice, na.rm = TRUE), 
        sd_price = sd(UnitPrice, na.rm = TRUE)
    )
print(sales_summary)    

# ================================================
# Activity 2: Visualize the Data
# ================================================

# Step 1: Histogram of SalesAmount
plot_1 <- ggplot(sales_df, aes(x = SalesAmount)) + 
    geom_histogram(bins = 30, color = "black", fill = "steelblue") +
    labs(title = "Distribution of Sales Amount", x = "Sales Amount", y = "Frequency")
print(plot_1)

# Step 2: Boxplot of SalesAmount by Region
plot_2 <- ggplot(sales_df, aes(x = Region, y = SalesAmount)) +
    geom_boxplot(fill = "lightgreen") +
    labs (title =  "Sales Amount by Region", x = "Region", y = "Sales Amount")
print(plot_2)

# Step 3: Scatterplot of UnitsSold vs. SalesAmount, colored by Region
plot_3 <- ggplot(sales_df, aes(x = UnitsSold, y = SalesAmount, color = Region)) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(title = "Units Sold vs. Sales Amount by Region", x = "Units Sold", y = "Sales Amount")
print(plot_3)


# ================================================
# Activity 3: Build a Regression Model
# ================================================

# Step 1: Simple regression model
model1 <- lm(SalesAmount ~ UnitsSold, data = sales_df)
summary(model1)

# Step 2: Multiple regression model
model2 <- lm(SalesAmount ~ UnitsSold + UnitPrice + Promotion, data = sales_df)
summary(model2)
glance(model2)
