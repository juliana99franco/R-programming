#Activity 1

#Practice 1.1: Create validate_order function

validate_order <- function(price) {
    if (price < 0 ) {
        return("Invalid quantity")
    }
    if (price > 1000) {
        return("Quantity exceeds 1000")
    }
    return("Order accepted")
}

print(validate_order(100))
print(validate_order(-8))

#Activity 2
#Practice 2.1: Create calculate_total function

calculate_total <- function(orders) {
    total <- 0
    for (order in orders) {
        #Apply discounts
        if(order > 200) {
            after_discount <- order * 0.8
        } else if (order > 100) {
            after_discount <- order * 0.9
        } else {
            after_discount <- order
        }
        total <- total + after_discount
    }
    return(total)
}

orders1 <- c(50, 150, 250)
calculate_total(orders1)

#Practice 2.2: Process orders until limit

limit <- function(order_amounts) {
    total_orders <- 0
    for (order in order_amounts) {
        #Check limit
        if (total_orders + order >= 1000) {
            break
        }
        total_orders <- total_orders + order
    }

    return(total_orders)
}

limited <- c(100, 500, 800, 200)
print(limit(limited))

#Activity 3
#Practice 3.1: Create order_summary function
order_summary <- function(distance, weight) {
    base_rate <- 20
    if (distance > 100) {
        base_rate <- base_rate + 5 
    }
    if (weight > 10) {
        base_rate <- base_rate + (weight - 10) * 0.5
    }
    summary <- list(
        shipping_cost = base_rate,
        distance = distance,
        weight = weight,
        Message = "Shipping calculated successfully"
    )
    return(summary)
}

print(order_summary(50, 4))
print(order_summary(120, 30))

#Activity 4

# Review thoroughly each part of the function to identify where the bug is located. 
#Go section by section.

# Original buggy function
# process_order <- function(items, prices) {
#     total <- 0
#     for (i in 1:length(item)) {  # Bug: wrong variable name
#         if (prices[i] <= 0) {
#             continue  # Bug: 'continue' doesn't exist in R
#         }
#         total <- total + price[i]  # Bug: wrong variable name
#     }
#     return(total)
# }

#Debugging:

process_order <- function(items, prices) {
     total <- 0
     for (i in 1:length(items)) {  # Bug: wrong variable name
         if (prices[i] <= 0) {
            next   # Bug: 'continue' doesn't exist in R
         }
         total <- total + prices[i] # Bug: wrong variable name
     }
     return(total)
}

# Test the fixed function
test_items <- c("Book", "Pen", "Notebook")
test_prices <- c(20, -5, 10)
print("Testing fixed process_order function:")
print(paste("Total order amount:", process_order(test_items, test_prices)))