#Ungraded lab: Advanced Interactive Visualizations

# Load necessary libraries
library(plotly)     # For interactive visualizations
library(ggplot2)    # For static plots and ggplot objects
library(dplyr)      # For data wrangling and summarization

# Load the dataset
sales_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/sales_12.csv")
str(sales_data)
# --------------------
# Activity 1: Interactive Scatter Dashboard
# --------------------

# Create a scatter plot with SalesValue vs. ProfitMargin

# Basic Plots
# plot_a <- plot_ly(sales_data, x = ~X_Category, y = ~Y_Category, type = 'scatter', mode = 'markers')
# print(plot_a)
#
# Add Tooltips
# plot_b <- plot_ly(data = sales_data, 
#        x = ~X_Category, 
#        y = ~Y_Category, 
#        type = 'scatter', 
#        mode = 'markers',
#        color = ~Z_Category,
#        text = ~paste("Location:", Location, "<br>Sales:", Sales),
#        hoverinfo = 'text',
#        transforms = list(
#          list(
#            type = 'filter',
#            target = ~Location,
#            operation = '=',
#            value = unique(sales_data$Location)[1]  # Default filter value
#          )
#        )
#) %>%
#  layout(
#    updatemenus = list(
#      list(
#        buttons = lapply(unique(sales_data$Location), function(region) {
#          list(
#            method = "restyle",
#            args = list("transforms[0].value", region),
#            label = region
#          )
#        }),
#        direction = "down",
#        showactive = TRUE,
#        type = "dropdown"
#      )
#    )
#  )
# print(plot_b)


# Try It Out #1: Add color, tooltip, and dropdown

# Color points by ProductCategory
# Add tooltips with Region and SalesChannel
# Add dropdown to filter by Region
# Hint:Use color = ~... and customize tooltips with text = ~paste(...) and hoverinfo = 'text'.

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch

plot_1 <- plot_ly(sales_data, 
    x = ~SalesValue, 
    y = ~ProfitMargin, 
    color = ~ProductCategory,
    type = 'scatter', 
    mode = 'markers',
    text = paste("Region:", sales_data$Region, "<br>SalesChannel:", sales_data$SalesChannel),
    hoverinfo = 'text',
    transforms = list(
        list(
            type = 'filter',
            target = ~Region,
            operation = '=',
            value = unique(sales_data$Region)[1]
        )
    ) ) %>%
    layout(
        updatemenus = list(
            list(
                buttons = lapply(unique(sales_data$Region), function(region) {
                    list(
                        method = "restyle",
                        args = list("transforms[0].value", region),
                        label = region
                    )
                }),
                direction = "down",
                showactive = TRUE,
                type = "dropdown"
            )
        )
    )
print(plot_1)

# --------------------
# Activity 2: Interactive Heatmap
# --------------------

# Monthly Heatmap Example

# Convert 'Month' column to a factor with ordered levels (e.g., Jan to Dec)
# generic_df$Month <- factor(generic_df$Month, levels = month.name)

# Summarize data by Category and Month
# summary_df <- generic_df %>%
#  group_by(Category, Month) %>%
#  summarise(TotalValue = sum(Value), .groups = 'drop')

# Create heatmap plot
# heatmap_plot <- ggplot(summary_df, aes(x = Month, y = Category, fill = TotalValue)) +
#  geom_tile() +
#  scale_fill_gradient(low = "white", high = "steelblue") +
#  labs(
#    title = "Value by Category and Month",
#    x = "Month",
#    y = "Category",
#    fill = "Total Value"
#  )

# Make the plot interactive
# plot_c <- ggplotly(heatmap_plot)
# print(plot_c)

# Try It Out #1: Create a heatmap

# Group by ProductCategory and Month
# Summarize total sales
sales_data$Month <- factor(
  sales_data$Month,
  levels = month.name,
  ordered = TRUE
)
summary_monthly <- sales_data %>%
    group_by(ProductCategory, Month) %>%
    summarise(TotalSales = sum(SalesValue), .groups = 'drop')


# Build heatmap with geom_tile() and convert with ggplotly()

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plots for the VS Code Plot Viewer to auto-launch

plot_2.1 <- ggplot(summary_monthly, aes(x = Month, y = ProductCategory, fill =TotalSales)) +
    geom_tile() +
    scale_fill_gradient(low = "white", high = "darkred") +
    labs(
        title = "Total Sales by Product Category every Month", 
        x = "Month", 
        y = "Product Category",
        fill = "Total Sales"
    )
print(plot_2.1)

# Add interactivity
# Hint: Use group_by() + summarise(), then pass the ggplot object into ggplotly(). 

plot_2.2 <- ggplotly(plot_2.1)
print(plot_2.2)

# --------------------
# Activity 3: Animated Sales Trend
# --------------------

# Use plot_ly() with frame = ~Month to animate by time
# P ot SalesValue over Date

# Example: Animate sales over time
# plot_d <- plot_ly(data = generic_df, 
#         x = ~Time,                # Generic time-based variable
#         y = ~Value,               # Generic y-axis numeric variable
#         color = ~Category,        # Generic category grouping
#         frame = ~Group,           # Generic grouping for animation frames
#         type = 'scatter', 
#         mode = 'lines+markers')   # Combine lines and markers for visualization
# print(plot_d)

# Try It Out #1: Color trends and add animation by Region
# Color lines by ProductCategory
# Animate by Region
# Hint: Use color = ~ProductCategory and consider frame = ~Region after grouping by Date.

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch

plot_3 <- plot_ly(sales_data, 
    x = ~Date, 
    y = ~SalesValue,
    color = ~ProductCategory,
    frame = ~Region,
    type = 'scatter',
    mode = 'lines+markers') %>%
    layout(
        title = "Sales Trends Over Time by Region"
    ) 
print(plot_3)


# --------------------
# Activity 4: Profit vs. Units Sold Dashboard
# --------------------
# Create a scatter plot of UnitsSold vs. ProfitMargin

# library(plotly)  # Load the plotly package for interactive plots

# # Create an interactive scatter plot with filtering capability
# plot_e <- plot_ly(data = generic_df,  # Use the generic dataset
#         x = ~XMetric,       # X-axis variable (e.g., units sold, duration)
#         y = ~YMetric,       # Y-axis variable (e.g., profit, score)
#         type = 'scatter',   # Scatter plot type
#         mode = 'markers',   # Display data points only (no lines)
#         color = ~Category,  # Color points by category
#         text = ~paste("Value:", Value, "<br>Group:", Group),  # Custom tooltip text
#         hoverinfo = 'text',  # Show only the custom text on hover
#         transforms = list(  # Apply a filter transform to enable dropdown selection
#           list(
#             type = 'filter',  # Specify filter transformation
#             target = ~TimePeriod,  # Variable to filter on
#             operation = '=',       # Use equality condition
#             value = unique(generic_df$TimePeriod)[1]  # Set default filter value
#           )
#         )
# ) %>%
#   layout(  # Define layout elements like dropdown menus
#     updatemenus = list(  # Create a dropdown menu for filtering
#       list(
#         buttons = lapply(unique(generic_df$TimePeriod), function(period) {  # Create one button per unique period
#           list(
#             method = "restyle",  # Use restyle method to update data
#             args = list("transforms[0].value", period),  # Change the filter value
#             label = period  # Label for the dropdown
#           )
#         }),
#         direction = "down",     # Dropdown opens downward
#         showactive = TRUE,      # Highlight the selected option
#         type = "dropdown"       # Define it as a dropdown menu
#       )
#     )
#   )
# print(plot_e)

# Try It Out #1: Add color, hover text, and filter
# Color points by ProductCategory
# Show SalesValue and Region in tooltips

# Filter by Month
# Hint: Use color = ~ProductCategory, text = ~paste(...), and layout(updatemenus = ...).

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch

plot_4 <- plot_ly(sales_data,
        x = ~UnitsSold,
        y = ~ProfitMargin,
        color = ~ProductCategory,
        type = 'scatter',
        mode = 'markers',
        text = paste("Sales Value:", sales_data$SalesValue, "<br>Region:", sales_data$Region),
        hoverinfo = 'text',
        transforms = list(
            list(
              type = 'filter',
              target = ~Month,
              operation = '=',
              value = unique(sales_data$Month)[1] 
        )
    )
)  %>%
    layout(
        updatemenus = list(
            list(
                buttons = lapply(unique(sales_data$Month), function(month) {
                    list(
                        method = 'restyle',
                        args = list('transforms[0].value', month),
                        label = month
                    )
                }),
            direction = 'down',
            showactive = TRUE,
            type = 'dropdown'
        )
    )
    )
    
print(plot_4)
