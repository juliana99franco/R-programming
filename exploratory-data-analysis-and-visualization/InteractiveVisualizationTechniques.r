# Interactive Visualization Techniques using Plotly in R
install.packages("plotly")
# Load necessary libraries
library(plotly)      # Loads the plotly package for interactive charts
library(dplyr)       # For data manipulation
library(readr)       # For reading CSV files


# Load the dataset 
website_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/insight_website_analytics.csv")


# Basic scatter plot: TimeOnSite vs. PageViews
plot_ly(
  data = website_data,              # The dataset you're using
  x = ~TimeOnSite,                 # x-axis: how long each user stayed on site
  y = ~PageViews,                 # y-axis: how many pages the user visited
  type = 'scatter',               # Specifies the chart type: a scatter plot
  mode = 'markers'                # Mode 'markers' means use dots, not lines
)


# Add color and custom tooltips
plot_ly(website_data, x = ~TimeOnSite, y = ~PageViews,
        type = 'scatter', mode = 'markers',
        color = ~Region,
        text = ~paste("User ID:", UserID,
                      "<br>Region:", Region,
                      "<br>Device:", Device),
        hoverinfo = 'text')



# Load new dataset

insight_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/iwebsite_data2.csv")


# Add dropdown filtering
plot_ly(insight_data, x = ~TimeOnSite, y = ~PageViews,
        type = 'scatter', mode = 'markers',
        color = ~Device,                               # Color points by device type
        text = ~paste("Region:", Region, "<br>Page:", Page), # Tooltip text
        hoverinfo = 'text',                            # Use only custom hover text
        transforms = list(                             # Add interactive filter logic
          list(
            type = 'filter',                           # Set the transform type to 'filter'
            target = "Region",                          # Target variable to filter
            operation = '=',                           # Operation used in the filter
            value = 'North America'                    # Default region selected
          )
        )
) %>%
  layout(
    updatemenus = list(                                # Add a dropdown menu
      list(
        buttons = lapply(unique(insight_data$Region), function(region) {
          list(
            method = "restyle",                        # Restyle the plot on selection
            args = list("transforms[0].value", region), # Update the filter value
            label = region                             # Label shown in dropdown
          )
        }),
        direction = "down",                            # Direction of dropdown
        showactive = TRUE,                              # Highlight active selection
        type = "dropdown"                               # Define menu type
      )
    )
  )


# Static plot: Build a line chart to show how sessions vary over time across different regions
p <- ggplot(insight_data, aes(x = Date, y = Sessions, color = Region)) +
  geom_line() +                                # Adds lines to represent session trends
  labs(title = "Sessions Over Time")           # Adds a chart title
print(p)
# Convert to interactive: This makes the static ggplot interactive
# You can now hover over lines, zoom in, and filter if needed
interactive_plot <- ggplotly(p)                # Converts ggplot object to an interactive plot
interactive_plot