print("Hello R world!")

#Practicing asigning variables and using paste()
temperture <- 35
unit <- "Celsius"
current_temperature <- paste(temperture,unit)
print(current_temperature)
is.numeric(temperture)

#paste usage 2
glucose_level <- 5.8
glucose_unit <- "mmol/L"
glucose_result <- paste(glucose_level,glucose_unit)
print(glucose_result)

#Testing other stuff - error control
#Create a function

check_patient_data <- function(patient_data) { 
    if (any(is.na(patient_data))) {
        return("Missing data found")}
        #con el if estoy diciendo que si hay datos NA, me saque true y con eso sacar el mensaje.
     return("All patient readings present.")

    }

#Test 1
recordings1 <- c(37, 38, NA, 40)
check_patient_data(recordings)

#Test 2

recordings2 <- c(37, 38, 36, 40)
check_patient_data(recordings2)

# Error not numeric 
#Create function 2

validate_payment <- function(amount_paid) {
    if (!is.numeric(amount_paid)) {
    # If it's not numeric, show a clear error message
        return("Input must be numeric")}
    return("Input looks good")
}

#Test 1
payment_amount <- "1O0"
validate_payment(payment_amount)

#Test 2
payment2 <- 100
validate_payment(payment2)



#MODULE 3 

#Calculate Mean, Median, and SD for Satisfaction Scores

# Dataset: Customer satisfaction scores (1–5)
scores <- c(4, 5, 5, 3, 4, 2, 1, 5, 4)

# Your task: Calculate the mean, median, and standard deviation

# Mean:
mean(scores)

# Median:
median(scores)

# Standard deviation:
sd(scores)

# Calculating grpouped data
library(dplyr)


# Sample data: Recovery days for different treatments
recovery_data <- data.frame(
  treatment = c("A", "A", "B", "B", "B", "C"),
  days = c(10, 12, 9, 15, 14, 8)
)

# Group by treatment type, then summarize
recovery_data %>%
  group_by(treatment) %>%
  summarize(avg_days = mean(days))


# Create a vector of even numbers.
even_numbers <- c(2, 4, 6, 8, 10)
print(even_numbers)
