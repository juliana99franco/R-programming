# Ungraded Lab: Building Publication-Quality Reports

# Load required packages
# install.packages(c("ggplot2", "dplyr", "plotly"))

library(ggplot2)   # For high-quality visualizations
library(dplyr)     # For data manipulation
library(plotly)    # For interactive charts

# Load the dataset
stock_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/stocks_14.csv")
str(stock_data)

# Convert Date to Date class
stock_data$Date <- as.Date(stock_data$Date)

# ----------------------------------------
# Activity 1: Visual Enhancements
# ----------------------------------------

# Start with a basic line chart of daily close prices by stock
# Add labels, title, and custom theme
# Modify line thickness or add smoothing to enhance clarity

# Example:
# Basic line plot with styling
# p <- ggplot(my_data, aes(x = TimeVar, y = ValueVar, color = CategoryVar)) +
#  geom_line(size = 1.5) +  # Increased line thickness for emphasis
#  labs(
#    title = "Trend Over Time",
#    x = "Time",
#    y = "Value",
#    caption = "Source: my_data.csv"
#  ) +
#  theme_minimal() +
#  theme(
#    plot.caption = element_text(size = 10, face = "italic"),
#    axis.title = element_text(size = 12),
#    legend.position = "bottom"
#  )

# print(p)


# Try It Out #1: You’re prepping a draft for your team’s presentation slide deck.
# Steps:
# - Add caption using labs(caption = "...")
# - Change line thickness using size
# - Customize theme or font sizes

# Hint: Use theme() with plot.caption, axis.title, legend.position, etc.
plot <- ggplot(stock_data, aes(x = Date, y = Close, color = Stock)) +
    geom_line(linewidth = 1.5) +  # Increased line thickness for emphasis
    labs(
        title = "Daily Closing Prices of Stocks", 
        x = "Date", 
        y = "Closing Price (USD)", 
        caption = "Source: stocks_14.csv"
    ) +
    theme_bw() +
    theme(
        plot.caption = element_text(size = 10, face = "italic", color = "darkred"), 
        plot.title = element_text(size = 16, face = "bold", color = "darkred"),
        axis.title = element_text(size = 12, face = "bold", color = "darkred"), 
        legend.position = "bottom"
    )
print(plot)


# ----------------------------------------
# Activity 2: Interactive Visualization
# ----------------------------------------

# Reuse your ggplot object from Activity 1
# Wrap it with ggplotly() for interactivity
# Test tooltip behavior

# Example:
# interactive_chart <- ggplotly(plot_variable_name)
# interactive_chart

# Try It Out #1: Convert your chart to an interactive version.
# Steps:
# - Use ggplotly()
# - Hover to test values
# - Use aes(text = paste(...)) for custom tooltips
# Hint: Interactivity works best when tooltips are informative and not cluttered.
interactive_plot <- ggplotly(plot, tooltip = "text") %>%
    layout(title = "Interactive Daily Closing Prices of Stocks")
print(interactive_plot)
# Eaily show the HTML outside of VS Code in a full web-browser view
htmlwidgets::saveWidget(interactive_plot, "interactive_plot.html")
browseURL("interactive_plot.html") # auto launch the HTML file in a browser


# ----------------------------------------
# Activity 3: Narrative and Reporting Structure
# ----------------------------------------

# Create a new .Rmd file
# Use a YAML header
# Add sections: Executive Summary, Introduction, Data Summary, Visualization, Conclusion
# Include narrative and code chunks

# Example .RmdL:
# ---
# title: "Stock Performance Report"
# author: "Your Name"
# date: "2024-07-01"
# output: html_document
# ---

# Try It Out #1: Draft a structured report.
# Steps:
# - Use # headers
# - Add narrative text
# - Use rmarkdown::render() to generate the HTML

# Hint: Keep executive summary tight—2–3 insights max.
# <YOUR CODE HERE>