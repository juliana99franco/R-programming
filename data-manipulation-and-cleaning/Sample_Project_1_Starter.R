# Ungraded Lab: Sample Project 1

# Install necessary packages (if not already installed)
# install.packages("tidyverse")  # This line installs the tidyverse package, which includes dplyr and readr.

# Load the tidyverse library
library(tidyverse)  # This loads the tidyverse package, making its functions available.

# Load the  dataset (Practice_set12_P1.csv) into healthcare_data
healthcare_data <- read_csv("/Users/juliana/Desktop/R Programming/Course 2/Practice_set12_P1.csv")  # read_csv() from the readr package reads the CSV file into a data frame.

# Examine the data structure
str(healthcare_data)  # str() shows the structure of the data frame, including column names and data types. This helps understand the data's organization.

# ================================================
# Activity 1: Standardize Date and Time Fields (using tidyr, stringr, and dplyr)
# ================================================
# First, use tidyr::separate() to split AdmissionDate and DischargeDate columns into parts (day, month, year).
# Next, use tidyr::unite() to recombine these parts into a standard YYYY-Month-DD format.
# You might also need to use stringr::str_extract() if certain formats require additional extraction.

print(healthcare_data$AdmissionDate)
print(healthcare_data$DischargeDate)

formatted_dates <- healthcare_data %>%
    separate(AdmissionDate, into = c("Admission_Day", "Admission_Month", "Admission_Year"), sep = "-") %>%
    separate(DischargeDate, into = c("Discharge_Day", "Discharge_Month", "Discharge_Year"), sep = "-") %>%
    unite("Formatted_AdmissionDate", Admission_Year, Admission_Month, Admission_Day, sep = "-") %>%
    unite("Formatted_DischargeDate", Discharge_Year, Discharge_Month, Discharge_Day, sep = "-")
print(formatted_dates)

# ================================================
# Activity 2: Transform Combined Address Fields into Structured Components
# ================================================
# Use tidyr::separate() to split PatientAddress into structured columns clearly: Street, City, State, ZIP.

print(healthcare_data$PatientAddress)
separate_address <- healthcare_data %>%
    separate(PatientAddress, into = c("Street", "City", "State_ZIP"), sep = ", ") %>%
    separate(State_ZIP, into = c("State", "ZIP"), sep = " ")
print(separate_address)


# ================================================
# Activity 3: Clearly Extract Procedure Details from Text Descriptions
# ================================================
# Extract ProcedureCode, ProcedureType, and ProcedureDetail fields clearly from ProcedureDescription using tidyverse and clearly formulated regex expressions (stringr::str_extract() or tidyr::extract() with regex)..

print(healthcare_data$ProcedureDescription)
healthcare_data <- healthcare_data %>%
  separate(ProcedureDescription, into=c("ProcedureCode", "ProcedureType", "ProcedureDetail"), sep = " - ")
print(healthcare_data$ProcedureCode)
print(healthcare_data$ProcedureType)
print(healthcare_data$ProcedureDetail)

# ================================================
# Activity 4: Creating Calculated Fields to Support Analysis
# ================================================
# Compute TotalCharge clearly by multiplying UnitCharge × Quantity of each Procedure.


healthcare_data <- healthcare_data %>%
    mutate(TotalCharge = UnitCharge * Quantity)
print(healthcare_data$TotalCharge)
