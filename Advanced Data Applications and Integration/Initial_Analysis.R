# ================================================
# Ungraded Lab: Initial Analysis of NYC Taxi Trips
# Module 6
# ================================================

# ================================================
# Load Packages and Dataset
# ================================================

library(tidyverse)  # For data wrangling and visualization
library(stringr)    # For text manipulation

# Load dataset
zone_data <- read_csv("taxi_data.csv")
str(zone_data) # Check data structure and columns. 

# ================================================
# Practice Challenge 1: Organizing and Checking for Issues
# ================================================

# Step 1: Use arrange() to sort the data by trip_distance
zone_data <- zone_data %>%
    arrange(trip_distance)
print(head(zone_data)) # Checking arrangement.

# Step 2: Use group_by() to count rate_code frequencies
rate_code_counts <- zone_data %>%
    group_by(rate_code) %>%
    summarise(count = n())
print(rate_code_counts) # Checking rate_code frequencies worked. 

# Step 3: Use filter() to find rows where fare_amount is 0 but trip_distance is greater than 0
suspicious_fares <- zone_data %>%
    filter(fare_amount == 0 & trip_distance > 0)
print(suspicious_fares) # Checking for suspicious fares. Apparently none. 

# ================================================
# Practice Challenge 2: Data Preparation 
# ================================================

# Step 1: Remove rows with missing values using drop_na()
zone_data_clean <- zone_data %>%
    drop_na()
print((nrow(zone_data)-nrow(zone_data_clean))) # No difference between cleaned and original dataset. No NA values. 

# Step 2: Ensure pickup_location_id and dropoff_location_id are numeric
zone_data_clean <- zone_data_clean %>%
    mutate(pickup_location_id = as.numeric(pickup_location_id,
           dropoff_location_id = as.numeric(dropoff_location_id)))
str(zone_data_clean) # Checking data is numeric. 

# Step 3: Clean store_and_fwd_flag values using str_replace_all()
# Replace "N" with "No", "Y" with "Yes"
zone_data_clean <- zone_data_clean %>%
    mutate(store_and_fwd_flag = str_replace_all(store_and_fwd_flag, c("N" = "No", "Y" = "Yes")))

print(unique(zone_data_clean$store_and_fwd_flag)) # Checking replacement. 

# Step 4: Remove duplicate rows using distinct()
zone_data_clean <- zone_data_clean %>%
    distinct()


#================================================
# Practice Challenge 3: Summarizing and Visualizing Data
# ================================================

# Step 1: Count unique pickup and dropoff location IDs
unique_pickup <- zone_data_clean %>%
    summarise(unique_pickup = n_distinct(pickup_location_id))
print(unique_pickup) # Checking unique pich up count. 

unique_dropoff <- zone_data_clean %>%
    summarise(unique_dropoff = n_distinct(dropoff_location_id))
print(unique_dropoff)

# Step 2: Summary statistics for trip_duration
# mean, median, min, max
summary <- summary(zone_data_clean$trip_duration)
mean <- mean(zone_data_clean$trip_duration)
median <- median(zone_data_clean$trip_duration)
min <- min(zone_data_clean$trip_duration)
max <- max(zone_data_clean$trip_duration)

# Step 3: Use table() to count payment_type values
payment_type_count <- table(zone_data_clean$payment_type)
print(payment_type_count) # Checking payment type count. 

# Step 4: Create a boxplot of fare_amount by payment_type
# Title: "Fare Amount by Payment Type"
plot_1 <- ggplot(zone_data_clean, aes(x = payment_type, y = fare_amount)) +
  geom_boxplot() +
  labs(title = "Fare Amount by Payment Type", x = "Payment Type", y = "Fare Amount")
print(plot_1)

# Step 5: Create a histogram of trip_distance
# 30 bins, light blue fill, black border
# Title: "Distribution of Trip Distances"
plot2<- ggplot(zone_data_clean, aes(x = trip_distance)) +
    geom_histogram(bins = 30, fill = "lightblue", color = "black") +
    labs(title = "Distribtution of Trip Distances", x = "Trip Distance", y = "Count")
print(plot2)

# ================================================
# Practice Challenge 4: Exploring Relationships 
# ================================================

# Step 1: Calculate average tip_amount by payment_type
avg_tip <- zone_data_clean %>%
    group_by(payment_type) %>%
    summarise(avg_tip = mean(tip_amount, na.rm = TRUE))
print(avg_tip)

# Step 2: Compare average trip_duration across rate_code values
avg_trip_dur <- zone_data_clean %>%
    group_by(rate_code) %>%
    summarise(avg_trip_duration = mean(trip_duration, na.rm = TRUE))
print(avg_trip_dur)

# Step 3: Compute correlation between trip_distance and string length of store_and_fwd_flag
# Create a helper column using str_length()
# Use cor() to compute the correlation
correlation_data <- zone_data_clean %>%
    mutate(count_char = str_length(store_and_fwd_flag))
correlation<- cor(correlation_data$trip_distance, correlation_data$count_char, use = "complete.obs")
print(correlation)
