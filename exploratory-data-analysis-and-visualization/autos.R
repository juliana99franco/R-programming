# Ungraded Lab: Advanced PCA Applications

# Load packages
library(ggplot2)    # For component and loading plots
library(dplyr)      # For data manipulation

# Load dataset
autos_df <- read.csv("/Users/juliana/Desktop/R Programming/Course 3/autos_11.csv")

# =============================
# Activity 1: Preparing the Car Dataset
# =============================

# Normalize all numeric variables using min-max scaling.
# Remove highly correlated variables based on a 0.8 correlation threshold.

# Example:
# Normalize numeric variables
# data <- df[sapply(df, is.numeric)]
# df_normalized <- as.data.frame(lapply(data_numeric, function(x) (x - min(x)) / (max(x) - # min(x))))

# Try it Out #1: Normalize numeric columns
# Identify numeric columns
data <- autos_df[, sapply(autos_df, is.numeric)]

# Apply min-max normalization
# Store in a new dataframe (cars_normalized)
# Hint: Use sapply() to quickly detect which columns are numeric

cars_normalized <- as.data.frame(lapply(data, function(x)(x-min(x, na.rm =TRUE))/(max(x, na.rm = TRUE) - min(x, na.rm = TRUE))))


# =============================
# Activity 2: Performing PCA
# =============================

# Use prcomp() on the selected variables
# Center and scale the data
# Interpret the summary output

# Example:
# data_pca <- select(data_normalized,A,B,C,D)
# data_pca_result <- prcomp(data_pca, center = TRUE, scale. = TRUE)
# summary(data_pca_result)

# pca_components <- data_pca_result$rotation
# print(pca_components[, 1:2])


# Try it Out #1: Select relevant columns for PCA

# Use select() or indexing
# Store as new dataframe
# Hint: Use select() from dplyr or bracket notation to isolate relevant columns
cars_pca <- cars_normalized %>%
    select(length, width, height, wheel_base, horsepower, city_mpg, highway_mpg)
cars_pca_result <- prcomp(cars_pca, center = TRUE, scale = TRUE)
summary(cars_pca_result)
pca_values <- as.data.frame(cars_pca_result$x)

# Try it Out #2: Extract loadings

# Access $rotation from PCA result
# Store in pca_components
# Print the first two components
# Hint: Focus on variables with the largest absolute values in PC1 and PC2—they're the key drivers
pca_components <- cars_pca_result$rotation
print(pca_components[, 1:2])



# =============================
# Activity 3: Visualizing PCA Results
# =============================
# Plot PC1 vs PC2 using a scatterplot
# Add color by price or another variable

# Example
# values <- as.data.frame(data_pca_result$x)
# values$column <- df$column

# Try it Out #1: Color PCA scatter plot by price

pca_values$price <- autos_df$price

# Add Category buckets based on quantile
pca_values <- pca_values %>%
    mutate(price_group = case_when(
        price < quantile(price, 0.33, na.rm = TRUE) ~"Low", 
        price < quantile(price, 0.66, na.rm = TRUE) ~"Medium", 
        TRUE ~"High"
    ))

# Component scatter plot
plot_3 <- ggplot(as.data.frame(pca_values), aes(x = PC1, y = PC2, color = price_group)) +
   geom_point() +
   labs(title = "Component Plot", x = "PC1", y = "PC2")
print(plot_3)


# Bind price to PC values dataframe
# Add color = price_group in aes()
# Hint: Use mutate() to create price group like 'Low', 'Mid', 'High'

