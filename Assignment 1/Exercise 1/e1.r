# Import stargazer
library(stargazer)
library(ggplot2)
library(reticulate)

# Python Imports
use_python("C:\\Python312\\python.exe")
sns <- import("seaborn")
plt <- import("matplotlib.pyplot")
pd <- import("pandas")
np <- import("numpy")

# Set the path to the CSV file
file_path <- "data/ebay.csv"

# Import the data
ebay_data <- read.csv(file_path, header = TRUE, sep = ";")

# cast the columns card_grade, card_id, rolling_supply_estimate to a integer
ebay_data$card_grade <- as.numeric(ebay_data$card_grade)
ebay_data$rolling_supply_estimate <- as.numeric(ebay_data$rolling_supply_estimate)

weekdays <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
ebay_data$weekday <- as.numeric(factor(ebay_data$weekday, levels = weekdays))

# print data types of all columns
print(sapply(ebay_data, class))

# remove id and card id columns, explicitly
# ebay_data <- ebay_data[, !(names(ebay_data) %in% c("id", "card_id", "seller"))]

# remove all rows that have at least one column value NA
ebay_data <- na.omit(ebay_data)

# noramlize the dataset using standard deviation normalization
# ebay_data <- as.data.frame(scale(ebay_data))

stargazer(ebay_data, type = "latex")


# plt$figure()$clear()
# plt$close()
# plt$cla()
# plt$clf()


# sns$barplot(data=ebay_data, x="card_listing_format_buy_it_now", y="sold_price", hue="basketball")
# plt$savefig("plots/grade_sold_price_scatter.png")



# # sns$pairplot(ebay_data, hue="active_player")
# plt$savefig("plots/grade_sold_price.png")

# # group dataset by card grade and count number of values in each group
# if (!requireNamespace("dplyr", quietly = TRUE)) {
#   install.packages("dplyr")
# }

# # Load the dplyr package
# library(dplyr)

# # Group by card_grade and summarize the count
# ebay_data <- ebay_data %>% group_by(card_grade) %>% summarise(count = n())y

# print the results


# change sold_price to ln(sold_price)
ebay_data$ln_price <- log(ebay_data$sold_price)

print(head(ebay_data))

# perform linear regression on the dataset
model <- lm(ln_price ~ card_grade, data = ebay_data)

# print the model summary
print(summary(model, type="latex"))

# plot ln_price vs card_grade and the fitted line from the regression
plt$figure()$clear()
plt$close()
plt$cla()
plt$clf()

sns$regplot(x = "card_grade", y = "ln_price", data = ebay_data)
# add the line of the regression fit
plt$plot(ebay_data$card_grade, predict(model), color = "red")
plt$savefig("plots/grade_sold_price_regression.png")
