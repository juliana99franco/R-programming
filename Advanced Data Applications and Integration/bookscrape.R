# Ungraded Lab: Basic Web Scraping Practice

# Load necessary packages
library(rvest)       # Web scraping tools
library(tibble)      # Tidy data frames
library(dplyr)       # Data wrangling
library(stringr)     # String cleaning
library(lubridate)   # Date and time formatting

# ================================================
# Activity 1: Explore the Website Structure
# ================================================
# Titles = class -> "product_pod", h_3 -> title = 
# Prices = class -> "product_class", p -> class = "price_color"

# ================================================
# Activity 2: Extract Book Titles and Prices
# ================================================

# Steps

# Example
# url <- "http://example.com/"
# webpage <- read_html(url)

# titles <- webpage %>% 
#  html_nodes(".product_pod h3 a") %>% 
#  html_attr("title")

# prices <- webpage %>% 
#  html_nodes(".price_color") %>% 
#  html_text()

# Try It Out:
# Use http://https://books.toscrape.com/ as url.
# Load the page with read_html().
# Extract book titles using html_attr("title").
# Extract prices using html_text().
# Combine into a tibble with columns: title, price.
# print tibble

# Hint: Prices include the pound symbol; you'll clean that up in the next step.

# Use read_html() to load the web page.
url <- "https://books.toscrape.com/catalogue/category/books_1/index.html"
webpage <- read_html(url)

# Use html_nodes() and html_text() to extract titles and prices.
book_titles <- webpage %>%
    html_nodes(".product_pod h3 a") %>%
    html_attr("title")

book_prices <- webpage %>%
    html_nodes(".price_color") %>%
    html_text()

# Combine the data into a tibble.
data <- tibble(Titles = book_titles, Prices = book_prices)
print(data)
# ================================================
# Activity 3: Clean and Organize the Data
# ================================================

# Steps
# Remove the £ symbol and convert prices to numeric.
# Add a timestamp column.

# Example
# data <- tibble(title = titles, price = prices)
# data <- data %>%
#   mutate(
#     price = str_replace(price, "$", ""),
#     price = as.numeric(price),
#     scraped_at = now()
#   )

# Try It Out:

data <- data %>%
    mutate(
        Prices = str_replace(Prices, "£", ""), # Remove symbols from price.
        Prices = as.numeric(Prices), # Convert price to numeric.
        Scraped_at = now() # Add a column called scraped_at using lubridate::now().
    )
print(data)

# Hint: Use str_replace() and as.numeric() to clean the column.


# ================================================
# Activity 4: Add Basic Error Handling & Ethics
# ================================================

# Steps:
# Wrap your scraping code in tryCatch() to handle errors.
# Use Sys.sleep() to introduce a delay.

# Example
# safe_scrape <- function(url) {
#   tryCatch({
#     Sys.sleep(3)
#     page <- read_html(url)
#     titles <- page %>% html_nodes(".product_pod h3 a") %>% html_attr("title")
#     prices <- page %>% html_nodes(".price_color") %>% html_text()
#     tibble(title = titles, price = prices, scraped_at = now())
#   }, error = function(e) {
#     message("Error occurred: ", e)
#     tibble()
#   })
# }

# Try It Out:
# Use tryCatch() to catch errors.
# Use Sys.sleep(3) before the request.
# Return a tibble with title, price, and scraped_at.
# Use "http://books.toscrape.com/" as a URL and run the function.

# Hint: Return an empty tibble if scraping fails.

scrape_books <- function(url) {
      tryCatch({
        Sys.sleep(3)
        page <- read_html(url)
        titles <- page %>% html_nodes(".product_pod h3 a") %>% html_attr("title")
        prices <- page %>% html_nodes(".price_color") %>% html_text()
        tibble(title = titles, price = prices, scraped_at = now())
      }, error = function(e) {
        message("Error ocurred:", e)
        tibble()
      })
 }

print("Final Book Scraping Data")
print(scrape_books("http://books.toscrape.com/"))
