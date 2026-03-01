# Ungraded Lab: Interactive Website Traffic Dashboard

# Load required packages
library(plotly)     # For interactive visualizations
library(ggplot2)    # For advanced plotting
library(dplyr)      # For data manipulation

# Load your data
website_traffic <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/website_12.csv")

# Review your data
head(website_traffic)
str(website_traffic)
summary(website_traffic)

# ================================
# Activity 1: Basic Interactive Plots
# ================================

# Build a scatter plot
# Build a bar chart
# Build a time series plot

# Example
# Scatter Plot
# plot_a <- plot_ly(data, x = ~ X_Column, y = ~ Y_Column,
#   type = 'scatter', mode = 'markers',color = ~ Column_Z)
# print(plot_a)

# Bar Chart
# data_totals <- data %>%
#   group_by(X_Column) %>%
#   summarise(Y_Column = sum(Y_Column))

# plot_b <- plot_ly(data_totals, x =  ~ X_Column, y = ~ Y_Column, type = 'bar')
# print(plot_b)

# Time-Series
# plot_c <- plot_ly(data, x = ~Date, y =  ~ Y_Column,
#   type = 'scatter', mode = 'lines')
# print(plot_c)


# Try It Out 1: Create a scatter plot and add color by Region

# Steps
# Use plot_ly() and add color = ~Region
# Include hoverinfo with Page, Region, and Device
# Adjust markers for clarity
# Hint: Use mode = 'markers' for best readability.

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch

plot_1 <- plot_ly(website_traffic, x = ~ PageViews, y = ~ AvgSessionDuration,
    type = 'scatter', mode = 'markers', color = ~ Region,
    hoverinfo = 'text',
    text = ~paste("Page:", Page, "<br>Region:", Region, "<br>Device:", Device))
print(plot_1)

# Try It Out 2: Create a Bar chart of total PageViews by Page

# Steps
# Use group_by() and summarise() to total PageViews
# Create a bar chart with plot_ly(type = 'bar')
# Hint: Use layout() to adjust bar spacing or orientation.

page_totals <- website_traffic %>%
    group_by(Page) %>%
    summarise(TotalPageViews = sum(PageViews))
print(page_totals)

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch

plot_2 <- plot_ly(page_totals, x = ~ Page, y = ~TotalPageViews, type = 'bar') %>%
    layout(xaxis = list(title = "Page"),
           yaxis = list(title = "Total PageViews"),
           title = "Total PageViews by Page")
print(plot_2)

# Try It Out 3: Time series of PageViews over time

# Use plot_ly() with type = 'scatter' and mode = 'lines'
# Set x = ~Date, y = ~PageViews
# Hint: Try zooming in by clicking and dragging.

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch

plot_3 <- plot_ly(website_traffic, x = ~Date, y = ~ PageViews, 
    type = 'scatter', mode = 'lines') 
print(plot_3)

# ================================
# Activity 2: Customize Plot Elements
# ================================

# Customize tooltips and legends to make your plots clearer and more presentation-ready.

# Example: Custom tooltip in scatter plot
# plot_d <- plot_ly(website_traffic, x = ~Column_A, y = ~Column_B,
#   type = 'scatter', mode = 'markers',
#   hoverinfo = 'text',
#   text = ~paste("Page:", Page, "<br>Column_C:", Column_C, "<br>Column_D:", Column_D))
# print(plot_d)


# Try It Out 1: Customize scatter tooltip
# Steps
# Use hoverinfo = 'text'
# Format the text with paste() for Page, Region, Device

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch

plot_4 <- plot_ly(website_traffic, x = ~AvgSessionDuration, y = ~PageViews,
    type = 'scatter', mode = 'markers', hoverinfo = 'text',
    text = ~paste("Page:", Page, "<br>Region:", Region, "<br>Device:", Device))
print(plot_4)

# ================================
# Activity 3: Advanced Interactivity
# ================================

# Build plots with multiple traces 
# Explore dropdown filtering to give viewers more control.

# Example: Region-based time series
# plot_e <- plot_ly(data, x = ~Date, y =  ~ Y_Column, color = ~ Column_Z,
#   type = 'scatter', mode = 'lines',
#   text = ~paste("Page:", Page, "<br>Device:", Device),
#   hoverinfo = 'text')
#   Page, "<br>Device:", Device),
#   hoverinfo = 'text')
# print(plot_e)

# Try It Out 1: Add multiple Region traces
# Steps
# Use color = ~Region in plot_ly()
# Ensure mode = 'lines'
# Add hover text as before

# Be sure to use the "Run Source" (vs. "Run Code") option in this VS Code lab
# and ensure you print your plot for the VS Code Plot Viewer to auto-launch
plot_5 <- plot_ly(website_traffic, x = ~Date, y = ~ PageViews, color = ~Region, 
    type = 'scatter', mode = 'lines',
    hoverinfo = 'text',
    text = ~paste("Page:", Page, "<br>Region:", Region, "<br>Device:", Device)) 

print(plot_5)
