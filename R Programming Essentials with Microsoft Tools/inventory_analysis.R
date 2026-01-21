#Activity 1
# Practice 1.1: Create product price vector
prices <- c(899.99, 24.99, 79.99, 299.99, 149.99)
print(prices)

# Practice 1.2: Create product category vector
category <- c("Electronics", "Accesories", "Accesories", "Electronics", "Accesories")
print(category)

#View length of both
length(prices)
length(category)

#Activity 2
# Practice 2.1: Create a product list

mouse_product <- list(
    product_id = 201,
    name = "Premium Mouse",
    price = 24.99,
    in_stock = TRUE 
)

# Practice 2.2: Access and modify list elements
print(mouse_product$price)
mouse_product$in_stock <- FALSE
print(mouse_product$in_stock)


#Activity 3
# Practice 3.1: Create inventory matrix
inventory <- matrix(
    c(10, 15, 5, 
      5, 8, 7,
      3, 5, 20),
    nrow = 3, 
    byrow = TRUE
)
rownames(inventory) <- c("Keyboard", "Mouse", "Monitor")
colnames(inventory) <- c("Downtown", "Mall", "Airport")

#Practice 3.2: Print inventory matrix
print(inventory)

#Activity 4
#Practice 4.1: Create product database

product_df <- data.frame(
    ID = c(101:105),
    Names = c("Gaming Laptop", "Premium Mouse", "Wireless Keyboard",
    "Gaming Monitor", "Mechanical Keyboard"),
    Price = prices, 
    Category = category, 
    In_Stock = c(TRUE, TRUE, FALSE, TRUE, TRUE)
)

print(product_df)

#Practice 4.2: Changing variable values

product_df$In_Stock[3] <- TRUE

print(product_df)
