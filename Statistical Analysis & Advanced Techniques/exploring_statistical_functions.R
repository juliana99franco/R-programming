# Ungraded Lab: Exploring Statistical Functions

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Load the required libraries
library(tidyverse)
library(ggplot2)

# Load your data into R
clinical <- read_csv("/Users/juliana/Desktop/R Programming/Course 4/exploring_statistical_functions.csv")

# Review the dataset
head(clinical)

# ================================================
# Activity 1: Identifying Variable Types
# ================================================

# Use str() and summary() to inspect your variables
# Identify whether each variable is categorical or numerical
# Create a named list categorizing each variable

# Example:
# str(data)
# summary(data)

# numerical_vars <- names(data)[sapply(data, is.numeric)]  # Identify numeric variables
# categorical_vars <- names(data)[sapply(data, is.character)]  # Identify character variables

# Try it Out #1: Classify variables into numerical and categorical types
# Steps:
# Use str() and summary() to inspect your variables
str(clinical)
summary(clinical)

# Use sapply() to identify numeric columns
numerical_vars <- names(clinical)[sapply(clinical, is.numeric)]

# Use sapply() to identify character-based columns
categorical_vars <- names(clinical)[sapply(clinical, is.character)]

# Create a list with two vectors: `numerical_vars` and `categorical_vars`
variable_types <- list(
    numerical_vars = numerical_vars, 
    categorical_vars = categorical_vars
)
print(variable_types)

# ================================================
# Activity 2: Measures of Central Tendency
# ================================================

# Calculate mean and median of RecoveryTime
# Group by TreatmentGroup and summarize
# Use na.rm = TRUE for robustness

# Example:
# mean(data$Time, na.rm = TRUE)
# median(data$Time, na.rm = TRUE)

# data %>%
    # group_by(TreatmentGroup) %>%
    # summarise(
        # mean_recovery = mean(Time, na.rm = TRUE),  # Calculate mean per group
        # median_recovery = median(Time, na.rm = TRUE)  # Calculate median per group
    # )

# Try it Out #1: Compare recovery times by TreatmentGroup
# Steps:
# Use group_by() + summarize() to compute mean and median per group
recovery_summary <- clinical %>%
    group_by(TreatmentGroup) %>%
    summarise(
        mean_recovery = mean(RecoveryTime, na.rm = TRUE), # Calculate mean 
        median_recovery = median(RecoveryTime, na.rm = TRUE)
    )
print(recovery_summary)

# ================================================
# Activity 3: Measures of Spread
# ================================================

# Compute standard deviation and variance of RecoveryTime
# Compare spread across TreatmentGroup using group_by() + summarize()

# Example:
# sd(clinical$RecoveryTime, na.rm = TRUE)
# var(clinical$RecoveryTime, na.rm = TRUE)

# clinical %>%
    # group_by(SideEffects) %>%
    # summarise(
        # sd_recovery = sd(Time, na.rm = TRUE),  # Standard deviation by group
        # var_recovery = var(Time, na.rm = TRUE)  # Variance by group
    # )

# Try it Out #1: Compare variability by SideEffects
# Steps:
# Group by SideEffects and calculate sd() and var()
effects_summary <- clinical %>%
    group_by(SideEffects) %>%
    summarise(
        sd_recovery = sd(RecoveryTime, na.rm = TRUE),
        var_recovery = var(RecoveryTime, na.rm = TRUE)
    )
print(effects_summary)

# ================================================
# Activity 4: Visualizing Distributions
# ================================================

# Use ggplot() to create histograms and boxplots
# Customize with labs() and theme() for readability
# Create bar charts for categorical frequencies

# Example:
# plot_a <- ggplot(clinical, aes(x = RecoveryTime)) +
#   geom_histogram(binwidth = 2, fill = "skyblue") +
#   labs(title = "Recovery Time Distribution", x = "Days", y = "Count")
# print(plot_a)

# Try it Out #1: Boxplot of RecoveryTime by TreatmentGroup
# Steps:
# Use ggplot() + geom_boxplot()

plot_4.1 <- ggplot(clinical, aes(x = TreatmentGroup, y = RecoveryTime, fill = TreatmentGroup)) +
    geom_boxplot(fill = "lightgreen") + 
    labs(title = "Recovery Time by Treatment Group", x = "Treatment Group", y = "Recovery Time (Days)")


print(plot_4.1)

# Try it Out #2: Bar chart for SideEffects
# Steps:
# Use ggplot() + geom_bar()
plot_4.2 <- ggplot(clinical, aes(x = SideEffects)) +
    geom_bar() +
    labs(title = "Frequency of Side Effects", x = "Side Effects", y = "Count") + 
    theme_minimal()
print(plot_4.2)

# ================================================
# Activity 5: Bringing It All Together
# ================================================

# You’ve calculated recovery statistics, compared treatment effects, and visualized key variables.
# Now it’s time to summarize your findings and share insights with your research team.

# Scenario:
# The team is preparing a final report and has asked for your interpretation of the data —
# and any suggestions you’d make based on your analysis.

# You won’t write new code in this section.
# Instead, scroll to the bottom of your R file and add your responses using # comments below.


# Task 1:

# Summary of Findings:
# - Drug A had the shortest average recovery time, followed by Drug B.
# - The placebo group had the longest recovery times with greater variability.
# - Recovery time was more inconsistent for patients who reported side effects.
# - Visualizations (boxplots and histograms) showed this pattern, with Drug A having
# the tightest distribution and fewest extreme outliers.

# Task 2: 

# Plain Language Interpretation:
# - Both Drug A and Drug B helped patients recover faster than the placebo.
# - Drug A was slightly better overall, with less variation in recovery times.
# - The differences between groups weren’t huge, but they were clear and consistent.
# - Key takeaway: Drug A is likely the most effective option based on the current data.

# Task 3: 

# Recommendations:
# - Emphasize the average recovery advantage of Drug A in the report.
# - Flag the variability observed in patients with side effects — consider subgroup analysis.
# - Suggest future use of statistical tests like ANOVA to confirm differences are significant.
# - Include a note that while trends are promising, the data should be
# interpreted with care due to sample variability.