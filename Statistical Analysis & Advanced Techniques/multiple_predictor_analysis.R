# Ungraded Lab: Multiple Predictor Analysis

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("broom")

# Load required libraries
library(tidyverse)      # Data wrangling and visualization
library(broom)

# Load dataset
housing <- read_csv("multiple_predictor_analysis.csv")

# Review structure
head(housing)
str(housing)
summary(housing)

# ================================================
# Activity 1: Simple Linear Regression
# ================================================

# Build a simple linear regression model with Price as the outcome and SquareFeet as the predictor.
# Summarize and interpret the output.

# Example:
# model1 <- lm(Price ~ SquareFeet, data = housing)
# summary(model1)
# tidy(model1)

# Try it Out #1: You're now asked to test whether the number of bedrooms is a strong predictor of house price.

# Steps:
# - Build a linear model: Price ~ Bedrooms
price_bed_model <- lm(Price ~ Bedrooms, data = housing)

# - Use summary() to review the results
summary(price_bed_model)

# - Use tidy() to present model coefficients
tidy(price_bed_model)


# ================================================
# Activity 2: Multiple Regression
# ================================================

# Build a model using SquareFeet, Bedrooms, and Bathrooms
# Summarize and interpret the coefficients
# Check the adjusted R-squared to assess improvement

# Example:
# model2 <- lm(Price ~ SquareFeet + Bedrooms + Bathrooms, data = housing)
# summary(model2)
# tidy(model2)

# Try it Out #1: Now, include Age to test whether older homes sell for more or less.

# Steps:
# - Update your model: add Age,SquareFeet, Bedrooms, and Bathrooms
model_without_age <- lm(Price ~SquareFeet + Bedrooms + Bathrooms, data = housing)
model_with_age <- lm(Price ~ SquareFeet + Bedrooms + Bathrooms + Age, data = housing)

# - Use summary() to examine significance
summary(model_without_age)
summary(model_with_age)

# - Compare the adjusted R-squared before and after adding Age
# - The adjusted R-squared improves when adding age, rising from 0.7 to 0.8, suggesting that Age explains additional variance on the model. 

# ================================================
# Activity 3: Handling Categorical Predictors
# ================================================

# Convert data into a factor if it's not already (as needed)
# Add it to the model and observe how it impacts the outcome
# Interpret the baseline and comparison levels

# Example:
# housing$Region <- as.factor(housing$Region)
# model3 <- lm(Price ~ Region, data = housing)
# summary(model3)
# tidy(model3)


# Try it Out #1: How much of the price variation is explained by LocationQuality alone?

# Steps:
# - Run a model with just LocationQuality as the predictor.
housing$LocationQuality <- as.factor(housing$LocationQuality)
model_location <- lm(Price ~ LocationQuality, data = housing)

# - Interpret coefficients and R-squared
summary(model_location)
tidy(model_location)

# ================================================
# Activity 4: Interaction Effects
# ================================================

# Use * in your formula to include an interaction
# Summarize and interpret the interaction term

# Example:
# model4 <- lm(Price ~ SquareFeet * LocationQuality, data = housing)
# summary(model4)
# tidy(model4)

# Try it Out #1: Now you're ready to build a full model that includes:

# Steps:
# - Add an interaction term between Bathrooms and LocationQuality on top of SquareFeet, Bedrooms, Bathrooms , Age, and LocationQuality as predictors
# - Interpret how the effect changes across groups
full_model <- lm(
    Price ~ SquareFeet + Bedrooms + Bathrooms + Age + LocationQuality + Bathrooms * LocationQuality,
    data = housing
)
summary(full_model)
# - This full model augments the R-squared to 0.94, meaning that all these factors explain a huge proportion of price variability. 