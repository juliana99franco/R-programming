# Ungraded Lab: Healthcare Data Preprocessing Practice

# Install necessary packages (these are pre-installed in your lab)
# install.packages("tidyverse")
# install.packages("lubridate")
# install.packages("stringr")
# install.packages("readr")

# Load the required libraries
library(tidyverse)
library(lubridate)
library(stringr)
library(readr)

# Load your data into R using read_csv() from the readr package within tidyverse
patient_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 3/healthcare_2.csv")

# Review the dataset using functions like head(), str(), and summary()
head(patient_data)
str(patient_data)
summary(patient_data)

# ================================================
# Activity 1: Resolve Missing and Invalid Values
# ================================================

# Identify invalid BMI entries and impute using the median.

# Example
# Replace "Invalid BMI" with NA and convert to numeric
# patient_data$BMI_Value <- replace(patient_data$BMI_Value, patient_data$BMI_Value == "Invalid BMI", NA)
# patient_data$BMI_Value <- as.numeric(patient_data$BMI_Value)

# Impute missing BMI with median explicitly
# median_bmi <- median(patient_data$BMI_Value, na.rm = TRUE)
# patient_data$BMI_Value[is.na(patient_data$BMI_Value)] <- median_bmi

# Try it Out #1: Handle invalid Zip_Code entries and impute these values.

# Steps:
# Replace "ABCDE" Zip_Codes entries with NA.
patient_data$Zip_Code <- replace(patient_data$Zip_Code, patient_data$Zip_Code == "ABCDE", NA) patient_data$Zip_Code <- replace(patient_data$Zip_Code, patient_data$Zip_Code == "ABCDE", NA) 

# Count how many entries are missing.
sum(is.na(patient_data$Zip_Code))

# Impute missing values (e.g., using city/state combos or setting to "Unknown").

patient_data$Zip_Code[is.na(patient_data$Zip_Code)] <- "Unknown"

#Verify there are no more NA values in the column. 

sum(is.na(patient_data$Zip_Code))


# ================================================
# Activity 2: Correcting Data Type Mismatches
# ================================================

# Ensure all number-based fields are formatted as numeric.

# Example
# Extract numeric digits from Zip_Code and convert to numeric
# patient_data$Zip_Code <- as.numeric(str_extract(patient_data$Zip_Code, "\\d+"))  # Extract digits and convert

# Count number of zip codes in the standard 5-digit range
# valid_zips <- patient_data %>%
# filter(Zip_Code >= 10000 & Zip_Code <= 99999) %>%
# nrow()

# valid_zips  # Output count

# Try it Out #1: Correct "Cholesterol_Level" values to numeric.

# Steps: 
# Extract numeric values from Cholesterol_Level.
# Replace the existing column as numeric values.
patient_data$Cholesterol_Level <- as.numeric(str_extract(patient_data$Cholesterol_Level, "\\d+"))
str(patient_data$Cholesterol_Level)

# Quantify how many patient cholesterol readings fall into the borderline-high range (200-240 mg/dL inclusive).

borderline_high_count <- patient_data %>%
  filter(Cholesterol_Level >= 200 & Cholesterol_Level <= 240) %>%
  nrow()
print(borderline_high_count)


# ================================================
# Activity 3: Fill Missing Prices with Median Values
# ================================================

# Standardize categorical fields through recoding methods.

# Example:
# patient_data <- patient_data %>%
# mutate(
# Gender = tolower(Gender),
# Gender = recode(Gender, "malee" = "male"),
# Gender = factor(Gender, levels = c("male", "female")),
# Smoker_Status = recode(Smoker_Status, "YES" = "Yes", "Y" = "Yes", "Smoker" = "Yes",
# "NO" = "No", "N" = "No", "Non-Smoker" = "No"),
# Smoker_Status = factor(Smoker_Status, levels = c("Yes", "No", "Unknown", "Refused to answer")),
# Patient_Consent = tolower(Patient_Consent),
# Patient_Consent = recode(Patient_Consent, "given" = "yes", "declined" = "no", "refused" = "no"),
# Patient_Consent = factor(Patient_Consent, levels = c("yes", "no")),
# Insurance_Type = tolower(Insurance_Type))

# Try it Out #1: Standardize State abbreviations.

# Steps:
# Standardize state abbreviations to two-letter uppercase.

patient_data$State <- toupper(patient_data$State)
str(patient_data$State)

# Recode any states denoted as “XXX” to “CA”.
patient_data$State <- recode(patient_data$State, "XXX" = "CA")

# Determine and report the most frequently occurring state.
state_counts <- patient_data %>%
  group_by(State) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

print(state_counts)

# ================================================
# Activity 4: Removing Duplicate Patient IDs
# ================================================

# Remove duplicates using distinct(), ensuring only the latest record remains (by Record_Date).

# Example:
# Identify duplicate Patient_ID
# duplicates <- patient_data %>% group_by(Patient_ID) %>% filter(n() > 1)

# Remove duplicates, keeping latest Record_Date.
# patient_data <- patient_data %>%
# arrange(desc(Record_Date)) %>%
# distinct(Patient_ID, .keep_all = TRUE)

# Try it Out #1: Verify no remaining duplicate patient records exist.

# Steps: 
# Count duplicates again in Patient_ID.
duplicates <- patient_data %>%
group_by(Patient_ID) %>%
filter(n() >1)
print(duplicates)

# Verify that count = 0.

patient_data <- patient_data %>%
  distinct(Patient_ID, .keep_all = TRUE)

duplicates_after_cleaning <- patient_data %>%
group_by(Patient_ID) %>%
filter(n() >1)
print(duplicates_after_cleaning)


# ================================================
# Activity 5: Data Transformation–Feature Creation, Normalization, and Binning
# ================================================

# Example: Create derived features to support patient risk scoring

# Step 1: Calculate insurance duration in years from a mock start date
# For demonstration, assume coverage started on Jan 1, 2015
# patient_data$Insurance_Duration <- time_length(interval(ymd("2015-01-01"), patient_data$Record_Date), "years")

# Check the calculated durations
# summary(patient_data$Insurance_Duration)

# Step 2: Normalize BMI_Value
# bmi_min <- min(patient_data$BMI_Value, na.rm = TRUE)
# bmi_max <- max(patient_data$BMI_Value, na.rm = TRUE)

# patient_data <- patient_data %>%
#   mutate(Normalized_BMI_Value = (BMI_Value - bmi_min) / (bmi_max - bmi_min))

# Check the normalized BMI
# summary(patient_data$Normalized_BMI_Value)

# Step 3: Create medication count category bins
# patient_data$Medication_Category <- cut(patient_data$Medication_Count,
# breaks = c(-Inf, 1, 2, 3, Inf),
# labels = c("Low", "Moderate", "High", "Very High"))

# Verify the medication count bins
# table(patient_data$Medication_Category)

# Try it Out #1: Create derived features for patient segmentation.

# Steps:
# Calculate patient age from Birth_Date and Record_Date.

patient_data$Age <- time_length(interval(patient_data$Birth_Date, patient_data$Record_Date), "years")
 
summary(patient_data$Age)

# Normalize Average_Glucose to the range 0-1.

glucose_min <- min(patient_data$Average_Glucose, na.rm = TRUE)
glucose_max <- max(patient_data$Average_Glucose, na.rm = TRUE)
patient_data <- patient_data %>%
  mutate(Normalized_Glucose = (Average_Glucose - glucose_min) / (glucose_max - glucose_min))
print(summary(patient_data$Normalized_Glucose))

# Create medically relevant Systolic_BP category bins.

patient_data <- patient_data %>%
  mutate(Systolic_BP_Category = cut(Systolic_BP,
                                  breaks = c(-Inf, 120, 129, 139, Inf),
                                  labels = c("Normal", "Elevated", "Hypertension Stage 1", "Hypertension Stage 2")))
table(patient_data$Systolic_BP_Category)


# ================================================
# Activity 6: Bringing it all together
# ================================================

# Problem 1: Detect and treat extreme outliers in "Systolic_BP".

# Solution:
# Visualize Systolic_BP to identify potential outliers
plot_6 <- ggplot(patient_data, aes(x = Systolic_BP)) +  # Hint: Which column are you analyzing for outliers?
  geom_histogram(bins = 30, fill = "30", color = "black") +  # Hint: What kind of plot shows distributions?
  labs(title = "Distribution of Systolic Blood Pressure", x = "Systolic BP (mmHg)", y = "Count")  
# Hint: Titles help communicate what’s being shown
print(plot_6)

# Detect outliers using IQR
bp_iqr <- IQR(patient_data$Systolic_BP, na.rm = TRUE)  # Hint: Use a spread measure that’s robust to outliers
bp_median <- median(patient_data$Systolic_BP, na.rm = TRUE)  # Hint: Center value that's less affected by skewed data
outlier_thresh_high <- bp_median + 1.5 * bp_iqr  # Hint: Typical multiplier for identifying extreme values
outlier_thresh_low <- bp_median - 1.5 * bp_iqr  # Hint: Same multiplier, but subtract
print(outlier_thresh_high)
print(outlier_thresh_low)

# Filter out outliers
patient_data <- patient_data %>%
  filter(Systolic_BP <= outlier_thresh_high & Systolic_BP >= outlier_thresh_low)  # Hint: Keep rows where values fall inside the range

summary(patient_data$Systolic_BP)

# Problem 2: Perform final validation of preprocessing steps.

# Solution:
# Check for consistency in categorical variables
summary(patient_data$Gender)  # Hint: Use a summary tool to scan each category
summary(patient_data$City)  # Hint: Repeat for all key categorical columns
summary(patient_data$Patient_Consent)  # Hint: Don’t forget patient consent status

# Verify absence of duplicates
remaining_duplicates <- sum(duplicated(patient_data$Patient_ID))  # Hint: What function checks for repeated rows?
remaining_duplicates  # Should be 0

# Verify correct data types
str(patient_data)  # Hint: Use this to inspect the structure and types of each column
