# Create a single sales amount
sale_amount <- 98.99
print(sale_amount)

# Create a single customer id
customer_id <- 100
print(customer_id)

# Create payment method
payment_method <- "Visa Card"
print(payment_method)

# Create sale location
payment_location <- "Colombia"
print(payment_location)

# Calculate value with discount
price <- 50.00
discount_amount <- price * 0.20 #20% discount
price_with_discount <- price - discount_amount
print(price_with_discount)
print(paste("Original price:" , price))

# Convert number to text
item_number <- 1200
item_text <- as.character(item_number)
print(item_text)

#Convert text to number
price_text <- "28.91"
price_num <- as.numeric(price_text)
print(price_num)

# Let's create a list

q2_summary <- list(
 users_onboarded = 16500,                 # total number (e.g., 15000)
 churn_rates = c(0.03, 0.27, 0.25),         # percentages (e.g., 0.03, 0.025, 0.02)
 monthly_revenue = c(125000, 138000, 145000),     # in USD (e.g., 120000, 130000, 140000)
 goal_met = TRUE
)
print(q2_summary)

# Access two key metrics from the list
# Replace the blank brackets below
q2_summary[["churn_rates"]]
q2_summary[["monthly_revenue"]]


