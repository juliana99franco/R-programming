# Ungraded Lab: Your First Logistic Model

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("broom")

# Load required libraries
library(tidyverse)      # Data manipulation and visualization
library(broom)          # Tidy model outputs

# Load dataset
customers <- read_csv("your_first_logistic_model.csv")

# Review dataset
head(customers)
str(customers)
summary(customers)

# ================================================
# Activity 1: Fitting Your First Logistic Regression Model
# ================================================

# Fit a logistic regression model using glm()
# Use summary() to interpret coefficients
# Use tidy() to extract model details

# Example:
# model1 <- glm(Purchased ~ Age, data = customers, family = "binomial")
# summary(model1)
# tidy(model1)

# Try it Out #1: You’re asked to test whether Income is a significant predictor of purchase.
# Steps:
# - Build a model with Purchased as the outcome and Income as the predictor
model1 <- glm(Purchased ~ Income, data = customers, family = "binomial")
# - Use summary() to review results
summary(model1)
# - Use tidy() to interpret coefficients
tidy(model1)
# - P- value states that the outcome is significant, but the estimate is very low, althought positive. 

# ================================================
# Activity 2: Adding More Predictors
# ================================================

# Add PriorPurchases to the model
# Check both coefficients and model summary

# Example:
# model2 <- glm(Purchased ~ Age + PriorPurchases, data = customers, family = "binomial")
# summary(model2)

# Try it Out #1: Now test a model that includes both Income and PriorPurchases.

# Steps:
# - Update the model formula to include both variables
model2 <- glm(Purchased ~ Income + PriorPurchases, data = customers, family = "binomial")

# - Use summary() to review model output
summary(model2)

# - Interpret how each factor contributes
tidy(model2)
# - The p-value for Prior purchases also states that there is a significant relationship. 
# - Additionally, the coefficient is positive and higher than for Income. 


# ================================================
# Activity 3: Working with Categorical Variables
# ================================================

# Convert Region to a factor
# Add it to your model
# Interpret the output

# Example:
# customers$Region <- as.factor(customers$Region)
# model3 <- glm(Purchased ~ Region, data = customers, family = "binomial")
# summary(model3)

# Try it Out #1: Now build a model using only Gender as the predictor.

# Steps:
# - Convert Gender to a factor
customers$Gender <- as.factor(customers$Gender)

# - Build a model: Purchased ~ Gender
model_gender <- glm(Purchased ~ Gender, data = customers, family = "binomial")

# - Interpret coefficient and direction
summary(model_gender)
tidy(model_gender)

# - What’s the baseline group?
# - The baseline group is female, as the coefficient appears for Male. 
# - The coefficient is negative for Male, which suggests that being male negatively impacts the purchase probability. 
# - However, the p-value is not significant (above 0.05), which means we cannot confidently state this. 

# ================================================
# Activity 4: Predicting Probabilities
# ================================================

# Create a new tibble with hypothetical inputs
# Use predict() with type = "response"
# Interpret output as probabilities

# Example:
# new_data <- tibble(Age = 45, PriorPurchases = 5 , Gender = "Male")
# model_4 <- glm(Purchased ~ Age + PriorPurchases + Gender, data = customers, family =  "binomial")
# predict(model4, newdata = new_data, type = "response")

# Try it Out #1: Use your best model to predict the probability of purchase for a new customer:

# Steps:
# - Create a new tibble
new_values <- tibble(Age = 40, Income = 50000, PriorPurchases = 3, Gender = "Female")
lastModel <- glm(Purchased ~ Age + Income + PriorPurchases + Gender, data = customers, family = "binomial")
summary(lastModel)
tidy(lastModel)

# - Predict the probability of purchase with this last model and interpret. 
predict(lastModel, newdata = new_values, type = "response")

# - Prediction was 0.6566453, so we could say that this customer has a 65.55% chance of making a purchase. 