# Assignment 1, Exercise 1

# Imports
library(stargazer)
library(ggplot2)
library(reticulate)

# Python Library Imports
use_python("C:\\Python312\\python.exe")
sns <- import("seaborn")
plt <- import("matplotlib.pyplot")
pd <- import("pandas")
np <- import("numpy")

# Load the dataset
file_path <- "assignment_1/data/ebay.csv"
ebay_data <- read.csv(file_path, header = TRUE, sep = ";")

# Cast all columns to numeric values
weekdays <- c("Monday", "Tuesday", "Wednesday",
              "Thursday", "Friday", "Saturday", "Sunday")

numeric_card_grade <- as.numeric(ebay_data$card_grade)
numeric_roll_supply_estimate <- as.numeric(ebay_data$rolling_supply_estimate)
numeric_weekday <- as.numeric(factor(ebay_data$weekday, levels = weekdays))

ebay_data$card_grade <- numeric_card_grade
ebay_data$rolling_supply_estimate <- numeric_roll_supply_estimate
ebay_data$weekday <- numeric_weekday

# Exercise 1, part A

# Print the statistical description of the dataset
stargazer(ebay_data, type = "latex",
          title = "Statistical Description of the eBay Dataset (with NAs)", out="assignment_1/html_tables/table_1_final.html")

ebay_data <- na.omit(ebay_data)

stargazer(ebay_data, type = "latex",
          title = "Statistical Description of the eBay Dataset (with NAs removed)", out="assignment_1/html_tables/table_2_final.html")

# Exercise 1, part B

# remove all rows that have at least one column value NA
ebay_data <- na.omit(ebay_data)

filtered_data <- ebay_data[ebay_data$sold_price <= 50000, ]

#plot 1: Identifying outliers in the sold_price variable.
sns$boxplot(x = "sold_price", data = filtered_data)
plt$show()
plt$set_title("Figure 1: Boxplot of card prices per Day of the Week.")

sns$scatterplot(x = "weekday", y = "sold_price", data = ebay_data, hue = "basketball")$set_title("Figure 1: Scatter plot of card prices per Day of the Week.")
plt$xticks(np$arange(7), weekdays, fontsize = 8)
plt$ylabel("Card Price (sold_price)", fontsize = 10)
plt$xlabel("Day of the Week (weekday)", fontsize = 10)
new_labels <- c("Baseball", "Basketball")
plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
legend_info <- plt$gca()$get_legend_handles_labels()
handles <- legend_info[[1]]
labels <- legend_info[[2]]
plt$savefig("plots/figure_1_final.png")

# Clear figure between runs
plt$figure()$clear()
plt$close()
plt$cla()
plt$clf()

# plot 2: price vs weekday with hue per basketball vs baseball
sns$barplot(x = "weekday", y = "sold_price", data = filtered_data, hue = "basketball")$set_title("Figure 2: Price of sold basketball/baseball cards per Day of Week.")
plt$xticks(np$arange(7), weekdays, fontsize = 8)
plt$ylabel("Card Price (sold_price)", fontsize = 10)
plt$xlabel("Day of the Week (weekday)", fontsize = 10)
new_labels <- c("Baseball", "Basketball")

# Set the legend with the modified labels and original handles and upscale it
plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
legend_info <- plt$gca()$get_legend_handles_labels()
handles <- legend_info[[1]]
labels <- legend_info[[2]]
plt$show()
plt$savefig("plots/figure_2_final.png")

# Clear figure between runs
plt$figure()$clear()
plt$close()
plt$cla()
plt$clf()

# plot 3: price vs sale medium with hue per basketball vs baseball
sns$barplot(x = "card_listing_format_buy_it_now", y = "sold_price", data = filtered_data, hue = "basketball")$set_title("Figure 3: Card prices per medium of sale (auction vs direct).")
plt$ylabel("Card Price (sold_price)", fontsize = 10)
plt$xlabel("Medium of sale (card_listing_format_buy_it_now)", fontsize = 10)
plt$xticks(np$arange(2), c("Auction", "Direct Sale"), fontsize = 8)
new_labels <- c("Baseball", "Basketball")

# Set the legend with the modified labels and original handles and upscale it
plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
legend_info <- plt$gca()$get_legend_handles_labels()
handles <- legend_info[[1]]
labels <- legend_info[[2]]
plt$show()
plt$savefig("plots/figure_3_final.png")

# plot 4: price vs active_player
sns$barplot(x = "active_player", y = "sold_price", data = filtered_data, hue = "basketball")$set_title("Figure 4: Card prices per Active Player (active vs retired).")
plt$ylabel("Card Price (sold_price)", fontsize = 10)
plt$xlabel("Active/Retired Player (active_player)", fontsize = 10)
plt$xticks(np$arange(2), c("Retired", "Active"), fontsize = 8)
new_labels <- c("Baseball", "Basketball")

# Set the legend with the modified labels and original handles and upscale it
plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
legend_info <- plt$gca()$get_legend_handles_labels()
handles <- legend_info[[1]]
labels <- legend_info[[2]]
plt$show()
plt$savefig("plots/figure_4_final.png")

# # Exercise 1, part C
# change sold_price to ln(sold_price)
ebay_data$ln_price <- log(ebay_data$sold_price)

# # perform linear regression 1 on the dataset
model <- lm(ln_price ~ card_grade, data = ebay_data)
stargazer(model, type="text")

# perform linear regression 2 on the dataset
model2 <- lm(ln_price ~ card_grade + basketball, data = ebay_data)
stargazer(model2, type="text")

# perform linear regression 3 on the dataset
model3 <- lm(ln_price ~ card_grade + basketball + active_player , data = ebay_data)
stargazer(model3, type="text")

# perform linear regression 4 on the dataset
model4 <- lm(ln_price ~ card_grade + basketball + active_player + card_listing_format_buy_it_now , data = ebay_data)
stargazer(model4, type="html")

stargazer(model, model2, model3, model4, title="last", out= "assignment_1/html_tables/table_3_final.html")

# Exercise 1, part E

model_e1 <- lm(card_grade ~ seller_feedback_score, data = ebay_data)
model_e2 <- lm(card_grade ~ active_player, data = ebay_data)

stargazer(model_e1, model_e2, type="html", title="Linear Regression", out="assignment_1/html_tables/table_4_final.html")