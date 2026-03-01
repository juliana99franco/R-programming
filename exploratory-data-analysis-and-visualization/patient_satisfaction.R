# Ungraded Lab: Patient Satisfaction Analysis

# Load required library
library(ggplot2)

# Load the dataset
patient_data <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/healthcare_6.csv")

# ================================================
# Activity 1: Exploring Relationships Between Variables
# ================================================

# Create a scatter plot to visualize the relationship between Age and MedicalCost.
# Calculate the correlation coefficient between these two variables.
# Interpret the results to determine the strength and direction of the relationship.

# Example
# ggplot(my_data, aes(x = VarX, y = VarY)) +
#   geom_point() +
#   labs(title = "Variable X vs. Variable Y",
#        x = "Variable X",
#        y = "Variable Y")

# cor(my_data$VarX, my_data$VarY)


# Try It Out: Explore whether medical cost relates to satisfaction level.

# Steps
# Create a scatter plot with MedicalCost on the x-axis and SatisfactionLevel on the y-axis.
# Use color to represent different satisfaction levels.

plot_1 <- ggplot(patient_data, aes(x = MedicalCost, y = SatisfactionLevel, color = SatisfactionLevel)) +
    geom_point() +
    labs(title = "Medical Cost associated to Satisfaction Level", x = "Medical Cost", y = "Satisfraction Level")
print(plot_1)

# Interpret any visible patterns.
# Apparently, the higher the cost, the higher the satisfaction. 
# However, the relationship isn't very strong. 

# ================================================
# Activity 2: Analyzing Variables over Categories
# ================================================

# Choose an appropriate plot (box plot or violin plot) to compare MedicalCost across Condition.
# Interpret the central tendencies and variability.

# Example
# ggplot(patient_data, aes(x = TreatmentType, y = SatisfactionLevel, fill = TreatmentType)) +
#   geom_boxplot() +
#   labs(title = "Satisfaction Level by Treatment Type", x = "Treatment Type", y = "Satisfaction Level")

# ggplot(patient_data, aes(x = TreatmentType, y = SatisfactionLevel, fill = TreatmentType)) +
#   geom_violin() +
#   labs(title = "Satisfaction Level Distribution by Treatment Type", x = "Treatment Type", y = "Satisfaction Level")

# Try It Out: Explore how MedicalCost differs by Condition.

# Steps
# Choose an appropriate plot (box plot or violin plot) to compare MedicalCost across Condition.
# Create the plot with clear labels and titles.
plot_2 <- ggplot(patient_data, aes(x = Condition, y = MedicalCost, fill = Condition)) +
    geom_dotplot(binaxis = "y", stackdir = "center", dotsize = 0.5) +
    labs(title = "Medical Cost by Condition", x = "Condition", y = "Medical Cost")
print(plot_2)


# Interpret the differences in medical costs among conditions.
# Diabetes is certainly the most costly condition, followed by Heart Disease. 
# The cheapest conditions are Respiratory Diseases. 

# ================================================
# Activity 3: Exploring Relationships Between Variables
# ================================================

# Create a contingency table to observe the frequency of each Condition and TreatmentType combination.
# Visualize the data using a stacked bar chart to show proportions.
# Interpret any notable associations.

# Example
# contingency_table <- table(patient_data$Condition, patient_data$TreatmentType)
# print(contingency_table)

# ggplot(patient_data, aes(x = Condition, fill = TreatmentType)) +
#   geom_bar(position = "fill") +
#   labs(title = "Treatment Type Distribution by Condition", x = "Condition", y = "Proportion")

# Try It Out: Show satisfaction level distribution across conditions.

# Steps
# Create a stacked bar chart to show the proportion of each SatisfactionLevel within each Condition. 
# Ensure the chart has clear labels and a descriptive title.
plot_3 <- ggplot(patient_data, aes(x = Condition, fill = SatisfactionLevel)) +
    geom_bar(position = "fill") +
    labs(title = "Satisfaction Level across Conditions", x = "Condition", y = "Proportion")
print(plot_3)

# Interpret any patterns or trends observed.
# The more costly the condition, the higher the satisfaction level. 

# ================================================
# Activity 4: Correlation Between Variables
# ================================================

# Convert SatisfactionLevel to a numerical scale (e.g., Low = 1, Medium = 2, High = 3).
# Create a scatter plot with Age on the x-axis and numerical SatisfactionLevel on the y-axis.
# Calculate the correlation coefficient between Age and numerical SatisfactionLevel.
# Interpret the strength and direction of the relationship.

# Example
# patient_data$SatisfactionNumeric <- as.numeric(factor(patient_data$SatisfactionLevel, levels = c("Low", "Medium", "High")))

# ggplot(patient_data, aes(x = Age, y = SatisfactionNumeric)) +
#   geom_point() +
#   labs(title = "Age vs. Satisfaction Level", x = "Age", y = "Satisfaction Level (Numeric)")

# cor(patient_data$Age, patient_data$SatisfactionNumeric)

# Try It Out: Investigate correlation between MedicalCost and Satisfaction.

# Steps
# Use the numerical SatisfactionLevel created earlier.
str(patient_data)
patient_data$SatisfactionLevelNumeric <- as.numeric(factor(patient_data$SatisfactionLevel, levels = c("Low", "Medium", "High")))

# Create a scatter plot with MedicalCost on the x-axis and numerical SatisfactionLevel on the y-axis.
plot_4 <- ggplot(patient_data, aes(x = MedicalCost, y = SatisfactionLevelNumeric)) +
    geom_point(color = "steelblue") +
    geom_smooth(method = "lm", se = FALSE, color = "darkred") +
    labs(title = "Medical Cost vs. Satisfaction Level", x = "Medical Cost", y = "Satisfaction Level Numeric")
print(plot_4)

# Calculate the correlation coefficient between MedicalCost and numerical SatisfactionLevel.
cor(patient_data$MedicalCost, patient_data$SatisfactionLevelNumeric)
#result is 0,606
# Interpret the results.
# There is a moderate positive correlation, suggesting that higher medical costs are associated with higher satisfaction. 