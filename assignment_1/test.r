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

weekdays <- c("Monday", "Tuesday", "Wednesday",
              "Thursday", "Friday", "Saturday", "Sunday")

numeric_card_grade <- as.numeric(ebay_data$card_grade)
numeric_roll_supply_estimate <- as.numeric(ebay_data$rolling_supply_estimate)
numeric_weekday <- as.numeric(factor(ebay_data$weekday, levels = weekdays))

ebay_data$card_grade <- numeric_card_grade
ebay_data$rolling_supply_estimate <- numeric_roll_supply_estimate
ebay_data$weekday <- numeric_weekday


ebay_data <- na.omit(ebay_data)


stargazer(ebay_data, type = "html",
          title = "Statistical Description of the eBay Dataset", out="assignment_1/html_tables/ex1_table_nona.html")