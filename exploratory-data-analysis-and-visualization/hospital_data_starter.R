# Ungraded Lab: First Steps in EDA: Hospital Patient Data Analysis

# Install necessary packages (if not already installed)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Load the required libraries
library(tidyverse)
library(ggplot2)
library(lubridate)
library(stringr)
library(readr)

health_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/healthcare_1.csv")
str(health_data)
summary(health_data)

# ================================================
# Activity 1: Summary Statistics of Key Health Metrics
# ================================================

# Compute summary statistics for the entire dataset. 
# Calculate the mean and standard deviation for 'Age' and 'BMI'.

# Example
# summary(patient_data)

# mean_age <- mean(patient_data$Age, na.rm = TRUE)
# sd_age <- sd(patient_data$Age, na.rm = TRUE)

# mean_bmi <- mean(patient_data$BMI, na.rm = TRUE)
# sd_bmi <- sd(patient_data$BMI, na.rm = TRUE)


# Try it Out #1: Calculate the mean and standard deviation for both BloodPressure_Systolic and BloodPressure_Diastolic.

# Steps:
# - Use mean() and sd() functions.
# - Handle missing values with na.rm = TRUE.

#Systolic mean and sd
mean_systolic <- mean(health_data$BloodPressure_Systolic, na.rm = TRUE)
print(mean_systolic)
sd_systolic <- sd(health_data$BloodPressure_Systolic, na.rm = TRUE)
print(sd_systolic)

#Diastolic mean and sd
mean_diastolic <- mean(health_data$BloodPressure_Diastolic, na.rm = TRUE)
print(mean_diastolic)
sd_diastolic <- sd(health_data$BloodPressure_Diastolic, na.rm = TRUE)
print(sd_diastolic)


# ================================================
# Activity 2: Visualizing Demographic Trends
# ================================================

# Generate a histogram for the age distribution.
# Example:
# plot_a <- ggplot(patient_data, aes(x = Age)) +
#   geom_histogram(binwidth = 5, fill = "blue", color = "white") +
#   labs(title = "Age Distribution of Hospital Patients", x = "Patient Age", y = "Count")

# print(plot_a)

# Try it Out #1: Create a boxplot comparing BMI distributions across different gender categories.

# Steps:
# - Define x-axis as Gender and y-axis as BMI.
# - Use geom_boxplot() to display BMI distribution by gender.
# - Ensure clarity and readability with proper labeling.


# Store your boxplot in a variable plot_2 and print to send to the VSCode Viewer
head(health_data)
summary(health_data$Gender)
summary(health_data$BMI)

plot_2 <- ggplot(health_data, aes(x = Gender, y = BMI)) +
    geom_boxplot(fill = "lightblue", alpha = 0.7, na.rm = TRUE) +
    labs(title = "BMI according to gender", x = "Gender", y = "BMI")

print(plot_2)


# ================================================
# Activity 3: Exploring Health Indicator Relationships
# ================================================

# Visualize the BMI and Blood Pressure relationship
# plot_b <- ggplot(patient_data, aes(x = BMI, y = BloodPressure_Systolic)) +
#   geom_point(alpha = 0.5) +
#   labs(title = "Correlation between BMI and Systolic Blood Pressure",
#        x = "BMI", y = "Systolic Blood Pressure")
# print(plot_b)

# Try it Out #1: To help the healthcare team address issues related to cholesterol management, visualize the relationship between BMI and Cholesterol.

# Steps:
# Create a scatter plot using geom_point to visualize the relationship between BMI and Cholesterol.
# Document and interpret any interesting findings from the plot.

plot_3 <- ggplot(health_data, aes(x = BMI, y = Cholesterol)) +
    geom_point(alpha = 0.5, color = "darkblue", size = 2) +
    labs(title = "Correlation between BMI and Cholesterol", x = "BMI", y = "Cholesterol")
print(plot_3)

# ================================================
# Activity 4: Analyzing Hospitalization Patterns
# ================================================

# Generate grouped boxplots to compare Insurance types in their hospital visit frequencies.
# plot_c <- ggplot(patient_data, aes(x = Insurance, y = HospitalVisits)) +
#   geom_boxplot(fill = "lightgreen", alpha = 0.7) +
#   labs(title = "Hospital Visits by Insurance Type", x = "Insurance Type", y = "Number of Visits")

# print(plot_c)

# Try it Out #1: Create a boxplot comparing HospitalVisits for patients with and without diabetes.

# Steps:
# - Create a boxplot comparing HospitalVisits for patients with and without diabetes.
# - Use the as.factor() function to distinguish the Diabetes status.


plot_4 <- ggplot(health_data, aes(x = as.factor(Diabetes), y = HospitalVisits)) +
    geom_boxplot() +
    labs(title = "Hospital Visits by Diabetes Status", x = "Diabetes Status", y = "Number of Hospital Visits")

print(plot_4)
