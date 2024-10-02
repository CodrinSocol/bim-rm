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
file_path <- "data/ebay.csv"
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
# stargazer(ebay_data, type = "latex",
#           title = "Statistical Description of the eBay Dataset")


# Exercise 1, part B

# remove all rows that have at least one column value NA
# ebay_data <- na.omit(ebay_data)

# calculate the first and third quartiles of the sold_price column and remove all observations not in that range
# q1 <- quantile(ebay_data$sold_price, 0.25)
# q3 <- quantile(ebay_data$sold_price, 0.75)
# # print(q3)
filtered_data <- ebay_data[ebay_data$sold_price <= 50000, ]

# Clear figure between runs
plt$figure()$clear()
plt$close()
plt$cla()
plt$clf()

# sns$boxplot(x = "sold_price", data = filtered_data)
# plt$show()
# $set_title("Figure 1: Boxplot of card prices per Day of the Week.")
# plot 1: Identifying outliers in the sold_price variable.
# sns$scatterplot(x = "weekday", y = "sold_price", data = ebay_data, hue = "basketball")$set_title("Figure 1: Scatter plot of card prices per Day of the Week.")
# plt$xticks(np$arange(7), weekdays, fontsize = 8)
# plt$ylabel("Card Price (sold_price)", fontsize = 10)
# plt$xlabel("Day of the Week (weekday)", fontsize = 10)
# new_labels <- c("Baseball", "Basketball")
# plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
# legend_info <- plt$gca()$get_legend_handles_labels()
# handles <- legend_info[[1]]
# labels <- legend_info[[2]]

# Clear figure between runs
plt$figure()$clear()
plt$close()
plt$cla()
plt$clf()

# plot 1: price vs weekday with hue per basketball vs baseball
# sns$barplot(x = "weekday", y = "sold_price", data = filtered_data, hue = "basketball")$set_title("Figure 2: Price of sold basketball/baseball cards per Day of Week.")
# plt$xticks(np$arange(7), weekdays, fontsize = 8)
# plt$ylabel("Card Price (sold_price)", fontsize = 10)
# plt$xlabel("Day of the Week (weekday)", fontsize = 10)
# new_labels <- c("Baseball", "Basketball")

# Set the legend with the modified labels and original handles and upscale it
# plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
# legend_info <- plt$gca()$get_legend_handles_labels()
# handles <- legend_info[[1]]
# labels <- legend_info[[2]]
# plt$show()

# Clear figure between runs
plt$figure()$clear()
plt$close()
plt$cla()
plt$clf()

# plot 2: price vs card_grade with hue per basketball vs baseball
# sns$barplot(x = "card_grade", y = "sold_price", data = filtered_data, hue = "basketball")$set_title("Figure 3: Price of sold basketball/baseball cards per card quality.")
# # plt$xticks(np$arange(7), weekdays, fontsize = 8)
# plt$ylabel("Card Price (sold_price)", fontsize = 10)
# plt$xlabel("Card Quality (card_grade)", fontsize = 10)
# new_labels <- c("Baseball", "Basketball")

# # Set the legend with the modified labels and original handles and upscale it
# plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
# legend_info <- plt$gca()$get_legend_handles_labels()
# handles <- legend_info[[1]]
# labels <- legend_info[[2]]
# plt$show()


# # plot 2: price vs card_grade with hue per basketball vs baseball
# sns$barplot(x = "card_listing_format_buy_it_now", y = "sold_price", data = filtered_data, hue = "basketball")$set_title("Figure 3: Card prices per medium of sale (auction vs direct).")
# plt$ylabel("Card Price (sold_price)", fontsize = 10)
# plt$xlabel("Medium of sale (card_listing_format_buy_it_now)", fontsize = 10)
# plt$xticks(np$arange(2), c("Auction", "Direct Sale"), fontsize = 8)
# new_labels <- c("Baseball", "Basketball")

# # # Set the legend with the modified labels and original handles and upscale it
# plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
# legend_info <- plt$gca()$get_legend_handles_labels()
# handles <- legend_info[[1]]
# labels <- legend_info[[2]]
# plt$show()

# plot 3: price vs active_player
sns$barplot(x = "active_player", y = "sold_price", data = filtered_data, hue = "basketball")$set_title("Figure 4: Card prices per Active Player (active vs retired).")
plt$ylabel("Card Price (sold_price)", fontsize = 10)
plt$xlabel("Active/Retired Player (active_player)", fontsize = 10)
plt$xticks(np$arange(2), c("Retired", "Active"), fontsize = 8)
new_labels <- c("Baseball", "Basketball")

# # Set the legend with the modified labels and original handles and upscale it
plt$legend(handles, new_labels, loc = "upper left", fontsize = 10)
legend_info <- plt$gca()$get_legend_handles_labels()
handles <- legend_info[[1]]
labels <- legend_info[[2]]
plt$show()

# Exercise 1, part C
# change sold_price to ln(sold_price)
# ebay_data$ln_price <- log(ebay_data$sold_price)

# print(head(ebay_data))

# # perform linear regression on the dataset
# model <- lm(ln_price ~ card_grade, data = ebay_data)

# # print the model summary
# print(summary(model, type="latex"))

# # plot ln_price vs card_grade and the fitted line from the regression
# plt$figure()$clear()
# plt$close()
# plt$cla()
# plt$clf()

# sns$regplot(x = "card_grade", y = "ln_price", data = ebay_data)
# # add the line of the regression fit
# plt$plot(ebay_data$card_grade, predict(model), color = "red")
# plt$savefig("plots/grade_sold_price_regression.png")
