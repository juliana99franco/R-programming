# ================================================
# Sample Project 2: Customer Behavior Prediction
# ================================================

# Load required packages
library(tidyverse)     # Data manipulation and visualization
library(broom)         # Tidying model outputs
library(car)           # Diagnostic tools for linear models
library(ggfortify)

# Load dataset
customer_df <- read_csv("customer_behavior_s2.csv")

# ================================================
# Activity 1: Explore and Visualize the Data
# ================================================

# Step 1: Check structure and summary
str(customer_df)
summary(customer_df)

# Step 2: Remove missing values
sum(is.na(customer_df))
customer_df <- drop_na(customer_df)

# Step 3: Compute mean and standard deviation
customer_summary <- customer_df %>%
    summarise(
        mean_income = mean(Income, na.rm = TRUE), 
        sd_income = sd(Income, na.rm = TRUE),
        mean_age = mean(Age, na.rm = TRUE), 
        sd_age = sd(Age, na.rm = TRUE), 
        mean_purchase = mean(PurchaseAmount, na.rm = TRUE), 
        sd_purchase = sd(PurchaseAmount, na.rm = TRUE)
    )
print(customer_summary)

# Step 4: Histogram of PurchaseAmount
plot_1 <- ggplot(customer_df, aes(x = PurchaseAmount)) +
    geom_histogram(fill = "skyblue", color = "black", bins = 30) +
    labs( title = "Distribution of Purchase Amount", x =  "Purchase Amount", y = "Frequency")
print(plot_1)

# Step 5: Scatterplot of Income vs. PurchaseAmount
plot_2 <- ggplot(customer_df, aes(x = Income, y = PurchaseAmount, color = Subscribed)) +
    geom_point() +
    geom_smooth(method = "lm") + 
    labs(title = "Income vs. Purchase Amount by Subscription Status")
print(plot_2)

# Step 6: Boxplot of PurchaseAmount by AdClicks
plot_3 <- ggplot(customer_df, aes(x = AdClicks, y = PurchaseAmount)) +
    geom_boxplot(fill = "salmon") +
    labs(title = "Purchase Amount by Ad Clicks", x = "Ad Clicks", y = "Purchase Amount")
print(plot_3)

# ================================================
# Activity 2: Validate and Predict with a Regression Model
# ================================================

# Step 1: Build linear regression model
model <- lm(PurchaseAmount ~ Age + Income + VisitsPerMonth, data = customer_df)

# Step 2: Check assumptions: residuals, normality, multicollinearity
plot(model)
autoplot(model, which = c(1,3))
# - Residuals curve, challenges linearity. No apparent heteroscedascity.

qqnorm(resid(model))
qqline(resid(model))
shapiro.test(resid(model))
# - But data appears to be normal, since points follow a straight line. 
# - Additionally, the p-value = 0.2629, indicating that data is normally distributed.
cooksd <- cooks.distance(model)
plot(cooksd, type = "h", main = "Cook's Distance")
which(cooksd > 4/length(cooksd))
# - 4 58 68 72 93

vif(model)
# - No apparent multicollinearity. 

# Step 3: Generate predictions with prediction intervals
new_customers <- tibble(
  Age = c(30, 45, 55),
  Income = c(60000, 70000, 80000),
  VisitsPerMonth = c(2, 3, 4)
)
predict(model, newdata = new_customers, type = "response")
# -  1        2        3 
# 199.7876  205.5573  211.4631 


# ================================================
# Activity 3: Build a Logistic Regression Model
# ================================================

# Step 1: Fit logistic regression model
# Ensure Subscribed is a binary factor
print(customer_df$Subscribed)
customer_df <- customer_df %>%
    mutate(Subscribed = as.factor(Subscribed))
str(customer_df)    
model_logistic <- glm(Subscribed ~ Age + Income + VisitsPerMonth, data = customer_df, family = "binomial")
tidy(model_logistic)
# - All coefficients suggest negative relationship, the strongest one is Visits per Month.
# - However, the p-value for all is not statistically significant. 
new_customer2 <- tibble(Age = 40, Income = 50000, VisitsPerMonth= 3)

# Step 2: Predict subscription probability for new profile
predict(model_logistic, newdata = new_customer2, type = "response")
# 0.531473, around 53.14% chance of subscribing. 