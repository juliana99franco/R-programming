# ================================================
# Ungraded Lab: Statistical Modeling and Spatial Analysis
# ================================================

# ================================================
# Load Packages and Dataset
# ================================================

library(tidyverse)     # For data wrangling and visualization
library(plotly)        # For interactive visualizations
library(stats)         # For modeling and statistical tests
library(lubridate)     # For working with date columns
library(broom)
library(zoo)
library(forecast)

# Load dataset
house_data <- read_csv("house_data.csv")
str(house_data)

# ================================================
# Practice Challenge 1: Pattern Exploration and Correlation
# ================================================

# Step 1: Scatter plot of sqft_living vs price
# Be sure to add your plot into the provided variable,print, and "Run Source"
plot1 <- ggplot(house_data, aes(x = sqft_living, y = price)) + 
    geom_point() + 
    geom_smooth(method = "lm", color = "darkred") +
    labs(title = "Square Footage vs Price", x = "Square Footage", y = "Price")
print(plot1)

# Step 2: Correlation coefficient between sqft_living and price
cor(house_data$sqft_living, house_data$price, use = "complete.obs")
# 0.702. 

# Step 3: Contingency table of waterfront and view
water_view_table <- table(house_data$waterfront, house_data$view)
print(water_view_table)

# Step 4: Convert condition to numeric (if needed) and check correlation with grade
house_data <- house_data %>%
    mutate(condition = as.numeric(condition))
cor(house_data$condition, house_data$grade, use = "complete.obs")
# Low cor = -0.1446737

# ================================================
# Practice Challenge 2: Interactive and Spatial Visualizations
# ================================================

# Step 1: Interactive scatter plot (lat vs long, color = price)
# Step 2: Customize tooltips (zipcode, price, sqft_living)
# Step 3: Add title: "Seattle Housing Prices by Location"
# Step 4: Set marker size to 5
# Be sure to add your plot into the provided variable, print, and "Run Source"

p <- ggplot(house_data, aes(x = long, y = lat, color = price,
                            text = paste("Zipcode:", zipcode,
                                         "Price:", price,
                                         "Sqft Living:", sqft_living))) +
    geom_point(size = 5) +
    labs(title = "Seattle Housing Prices by Location")
ggplotly(p, tooltip = "text")

# ================================================
# Practice Challenge 3: Hypothesis Testing and Predictive Modeling
# ================================================

# Step 1: Shapiro-Wilk test on price
shapiro.test(house_data$price[1:5000]) # p-value < 2.2e-16, so we reject the null hypothesis of normality. The price variable is not normally distributed.

#Additonal: Var test: 
var.test(price ~ waterfront, data = house_data) # p-value < 2.2e-16, so we reject the null hypothesis of equal variances. The variances of price between waterfront and non-waterfront groups are significantly different.

# Step 2: Two-sample t-test (waterfront == 1 vs 0)
t.test(price ~waterfront, data = house_data, var.equal = FALSE) # p-value < 2.2e-16, so we reject the null hypothesis. There is a significant difference in mean price between waterfront and non-waterfront properties.

# Step 3: Linear model (price ~ sqft_living)
price_sqft_model <- lm(price ~ sqft_living, data = house_data)
summary(price_sqft_model) # p-value shows significance but r-square is low (0.493). 

# Step 4: Add regression line to scatter plot
# Be sure to add your plot into the provided variable,print, and "Run Source"
plot3 <- ggplot(house_data, aes(x = sqft_living, y = price)) + 
    geom_point() +
    geom_smooth(method = "lm", color = "darkred") +
    labs(title = "Square Footage vs Price", x = "Square Footage", y = "Price")
print(plot3)

# Step 5: Predict price for sample observations
predict(price_sqft_model, newdata = house_data[1:5, ]) # Predicted prices for the first 5 observations based on the linear model.
print(house_data$price[1:5]) # Actual prices for the first 5 observations for comparison.


# ================================================
# Practice Challenge 4: Advanced Modeling and Time Trends
# ================================================

# Step 1: Convert price to binary factor
house_data <- house_data %>%
    mutate(price_binary = as.factor(if_else(price > median(price, na.rm = TRUE), 1, 0)))
print(house_data$price_binary)

# Step 2: Logistic regression model (price > median)
logistic_model_price <- glm(price_binary ~ sqft_living + grade, family = binomial, data = house_data)

# Step 3: Use tidy() to display model output
tidy(logistic_model_price)
#P-values are significant for both predictors, bit the coefficient of only grade is apparently significant in its influence (0.921).


# Step 4: Time series plot using date and price
# Fill missing dates and create a TS object.
house_data$date <- ymd(house_data$date)
house_data <- house_data %>%
    arrange(date)
ts_plot <- house_data %>%
    group_by(date) %>%
    summarise(avg_price = mean(price, na.rm = TRUE)) %>%
    mutate(roll_mean = rollmean(avg_price, k = 7, fill = NA, align = "right"))

# Be sure to add your plot into the provided variable,print, and "Run Source"
plot4 <- ggplot(ts_plot, aes(x = date)) +
    geom_line(aes(y = avg_price), color = "lightblue") +
    geom_line(aes(y = roll_mean), color = "darkred") +
    labs(title = "Daily Average Price with 7-Day Rolling Mean", x = "Date", y = "Price")
print(plot4)

# Step 5: Explore trends with rollmean() or decompose()
ts_data <- ts(house_data$price, frequency = 365)
decomp_classic <- decompose(ts_data)
plot(decomp_classic)
