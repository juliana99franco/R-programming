# ================================================
# Sample Project 2: Retail Product Trends
# ================================================

# Load required libraries
library(dplyr)      # Data manipulation
library(ggplot2)    # Plotting
library(plotly)     # Interactive plots
library(lubridate)  # Date functions

# Load your dataset
retail_df <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/retail_final.csv")
str(retail_df)


# ================================================
# Activity 1: Extract and Analyze Purchase Date Features
# ================================================

# Convert PurchaseDate to Date
retail_df$OrderDate <- as.Date(retail_df$OrderDate, format = "%Y-%m-%d")

# Extract Year, Month
retail_df <- retail_df %>%
    mutate(Year = format(OrderDate, "%Y"),
           Month = format(OrderDate, "%m"),
           Day = weekdays(OrderDate))
print(retail_df$Day)

# Create Weekend flag
retail_df <- retail_df %>%
    mutate(IsWeekend = Day %in% c("Saturday", "Sunday"))
print(retail_df$IsWeekend)


# ================================================
# Activity 2: Group Products into Price Bands
# ================================================

# Create PriceBand using case_when
retail_df <- retail_df %>%
    mutate(PriceBand = case_when(
        UnitPrice < 20 ~"Budget", 
        UnitPrice >= 20 & UnitPrice < 100 ~ "Mid-Range",
        UnitPrice >= 100 ~ "Premium"
    ))

# Count the number of products in each PriceBand.

price_band_counts <- retail_df %>%
    count(PriceBand, ProductName)
print(price_band_counts)

# Plot bar chart

plot_price_band <- ggplot(price_band_counts, aes(x = PriceBand, y = n, fill = ProductName)) +
    geom_bar(stat = "identity", position = "dodge") + 
    labs(title = "Products by Price Band", x = "Price Band", y = "Count")
print(plot_price_band)    

# ================================================
# Activity 3: Visualize Sales by Region and Category
# ================================================

# Count sales by Region and ProductCategory
region_category_sales <- retail_df %>%
    count(Region, ProductCategory)
print(region_category_sales)

# Plot stacked bar chart

plot_region_category <- ggplot(region_category_sales, aes(x = Region, y = n, fill = ProductCategory)) +
    geom_bar(stat = "identity") +
    labs(title = "Sales by Region and Product Category", x = "Region", y = "Count")
print(plot_region_category)

# ================================================
# Activity 4: Compare Average Profit by Region
# ================================================

# Group by Region
# Calculate average Profit
average_profit_region <- retail_df %>%
    group_by(Region) %>%
    summarise(AvgProfit = mean(Profit, na.rm = TRUE))

# Plot interactive bar chart

average_profit_region_plot <- ggplot(average_profit_region, aes(x = Region, y = AvgProfit, fill = Region)) + 
    geom_bar(stat = "identity") +
    labs(title = "Average Profit per Region", x = "Region", y = "Average Profit") + 
    theme(plot.title = element_text(size = 16, face = "bold", color = "darkred"),
          axis.title = element_text(size = 14, face = "bold", color = "darkred")
    )
print(plotly::ggplotly(average_profit_region_plot))


# ================================================
# Activity 5: Analyze Quantity Distribution by Category
# ================================================

# Create boxplot of Quantity by ProductCategory
plot_quantity_category <- ggplot(retail_df, aes(x = ProductCategory, y = Quantity, fill = ProductCategory)) +
    geom_boxplot() +
    labs(title = "Quantity Distribution by Product Category", x = "Product Category", y = "Quantity") + 
    theme(plot.title = element_text(size = 16, face = "bold", color = "darkred"),
          axis.title = element_text(size = 14, face = "bold", color = "darkred")
    )
print(plot_quantity_category)
# Convert to interactive with ggplotly

print(plotly::ggplotly(plot_quantity_category))



