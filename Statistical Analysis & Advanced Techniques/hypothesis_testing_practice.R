# Ungraded Lab: Hypothesis Testing Practice

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Load the required libraries
library(tidyverse)  # Data manipulation and visualization
library(ggplot2)    # Plotting functions

# Load the dataset
customers <- read_csv("/Users/juliana/Desktop/R Programming/Course 4/hypothesis_testing_practice.csv")

# Review the dataset
head(customers)
str(customers)
summary(customers)

# ================================================
# Activity 1: Test Selection and Setup
# ================================================

# Inspect InvestmentReturn and AccountType variables using hist() and boxplot()
# Check assumptions (normality, sample sizes)
# Formulate null and alternative hypotheses
# Choose the appropriate test (ANOVA, t-test, etc.)

# Example
# Visualize MonthlyIncome distribution
# hist(transactions$InvestmentReturn)  # See overall income distribution

# Visualize income spread across AccountType groups
# boxplot(InvestmentReturn ~ AccountType, data = transactions)

# Compare average InvestmentReturn across AccountTypes
# transactions %>%
#   group_by(AccountType) %>%
#   summarize(avg_income = mean(InvestmentReturn, na.rm = TRUE))

# Test normality within each group
# shapiro.test(transactions$InvestmentReturn[transactions$AccountType == "Basic"])
# shapiro.test(transactions$InvestmentReturn[transactions$AccountType == "Premium"])
# shapiro.test(transactions$InvestmentReturn[transactions$AccountType == "Gold"])

# Run a one-way ANOVA (if normality holds)
# anova_result <- aov(InvestmentReturn ~ AccountType, data = transactions)
# summary(anova_result)

# OR, use Kruskal-Wallis test if data is not normally distributed
# kruskal.test(InvestmentReturn ~ AccountType, data = transactions)

# Try it Out #1: Is there a difference in income across account types?
# You're checking if income varies significantly by account type.

# Steps:
# Inspect MonthlyIncome and AccountType variables using hist() and boxplot()
hist(customers$MonthlyIncome, main = "Distribution of Monthly Income", xlab = "Monthly Income")
boxplot(MonthlyIncome ~AccountType, data = customers, main = "Monthly Income by Account Type", xlab = "Account Type", ylab = "Monthly Income")

# Use group_by() and summarize() to compare means
month_account_summary <- customers %>%
    group_by(AccountType) %>%
    summarize(avg_income = mean(MonthlyIncome, na.rm = TRUE))
print(month_account_summary)

# Check normality with shapiro.test() on subgroups

shapiro.test(customers$MonthlyIncome[customers$AccountType == "Savings"])
# p-value = 0.22, normal distribution. 
 
shapiro.test(customers$MonthlyIncome[customers$AccountType == "Checking"])
# p-value = 0.97, normal distribution. 

shapiro.test(customers$MonthlyIncome[customers$AccountType == "Investment"])
# p-value = 0.37, normal distribution. 


# Choose a one-way ANOVA or Kruskal-Wallis depending on assumptions
# Anova de to normal distribution of all groups. 

anova_result <- aov(MonthlyIncome ~ AccountType, data = customers)
summary(anova_result)

# p- value = 0.9, no significant difference in monthly income across account types. 

# ================================================
# Activity 2: Conducting T-Tests
# ================================================

# Create two groups based on Defaulted
# Compare CreditScore distributions
# Run a two-sample t-test
# Example
# t.test(Score ~ GroupStatus, data = sample_data, var.equal = FALSE)

# Try it Out #1: Do defaulted customers have different credit scores?
# You're testing for a significant difference in credit score means.

# Steps:
# - Use t.test() with grouping by Defaulted
# - Interpret p-value and confidence interval
boxplot(CreditScore ~ Defaulted, data = customers)

var.test(customers$CreditScore ~customers$Defaulted)
# p -value = 0.89, equal variances assumed. 

t.test(CreditScore ~ Defaulted, data = customers, var.equal = TRUE)
# p-value = 0.413, no significant difference in credit scores between defaulted and non-defaulted customers. 


# ================================================
# Activity 3: Chi-Square Tests
# ================================================

# Build a contingency table for Region and Defaulted
# Run a chi-square test using chisq.test()
# Examine expected vs. observed counts

# Example
# category_status_table <- table(data$CategoryGroup, data$OutcomeStatus)
# chisq.test(category_status_table)

# Try it Out #1: Is default status dependent on Region?
# You're looking for a relationship between geographic location and likelihood of default.

# Steps:
# - Create a 2-way table using table()
region_default <- table(customers$Region, customers$Defaulted)
print(region_default)

# - Run chisq.test() on the table
chisq.test(region_default)

# - Interpret the p-value in plain language
# p-value = 0.225, meaning there is no relationship between region and default status. 


# Note: If you see a chisq.test warning message when running the code
# in this activity, don’t worry, this is expected and won’t affect your results.
# The code still runs correctly and generates the output as intended.


# ================================================
# Activity 4: Confidence Intervals
# ================================================

# Run a one-sample t-test
# Use t.test() with conf.level = 0.95

# Example
# t.test(data$PerformanceMetric, conf.level = 0.95)

# Try it Out #1: Estimate average investment return with 99% confidence.

# Steps:
# - Run a one-sample t-test on InvestmentReturn
# - Set conf.level = 0.99
# - Interpret the lower and upper bounds of the interval

t.test(customers$InvestmentReturn, conf.level = 0.99)
# p-value = < 2.2e-16, meaning the average investment return is significantly different from zero.
# The 99% confidence interval is :  0.0554214 0.0660246, meaning we are 99% confident that the true average investment return lies between these two values.