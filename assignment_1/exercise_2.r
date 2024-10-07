# Exercise 2 Assignment 1
setwd("C:/Users/peta_/OneDrive/Desktop/BIM/BIM Research Methods/Assignment 1")
getwd()

# 2a
whr_data <- read.csv("data/whr.csv", header = TRUE, sep = ";")
library(stargazer)
stargazer(whr_data, type = "html", title = "Table 4: The descriptive statistics of the whr dataset (including NA values)", summary = TRUE, out = "whr_data.html")
cleaned_data <- na.omit(whr_data)
stargazer(cleaned_data, type = "html", title = "Table 5: The descriptive statistics of the whr dataset (after the removal of NA values)", summary = TRUE, out = "html_tables/table_5_final.html")

# 2b
library(dplyr)
avg_happiness <- cleaned_data %>%
  group_by(Country.name) %>%
  summarise(Average_Happiness = mean(Life.Ladder, na.rm = TRUE))
top_5_happiest_countries <- avg_happiness %>%
  arrange(desc(Average_Happiness)) %>%
  head(5)
print(top_5_happiest_countries)

install.packages("xtable")
library(xtable)
top_5_happiest_countries_table <- xtable(top_5_happiest_countries)
stargazer(top_5_happiest_countries, type = "html", title = "The 5 countries with the highest average happiness score from the dataset", file = "html_tables/table_6_final.html")
shapiro_test <- shapiro.test(avg_happiness$`Average_Happiness`)
print(shapiro_test)
shapiro_test_full <- shapiro.test(whr_data$`Life.Ladder`)
print(shapiro_test_full)

library(ggplot2)  # For visualization
library(dplyr)    # For data manipulation

# Histogram with normal curve
ggplot(avg_happiness, aes(x = `Average_Happiness`)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "blue", alpha = 0.5) +
  stat_function(fun = dnorm, args = list(mean = mean(avg_happiness$`Average_Happiness`), 
                                         sd = sd(avg_happiness$`Average_Happiness`)), 
                color = "red", size = 1) +
  ggtitle("Figure 5: Histogram of Life Ladder with Normal Curve") +
  xlab("Life Ladder (Happiness Score)") +
  ylab("Density")

# 2c
# Regression
mdla <- cleaned_data$Life.Ladder ~  cleaned_data$Log.GDP.per.capita + cleaned_data$Social.support + cleaned_data$Healthy.life.expectancy.at.birth + cleaned_data$Freedom.to.make.life.choices + cleaned_data$Generosity
install.packages("plm")
library(plm)
rsltPool <- plm(mdla, data = cleaned_data, model = "pooling")
summary(rsltPool)

stargazer(rsltPool, align = TRUE, no.space = TRUE, intercept.bottom = FALSE, type = "text")
stargazer(rsltPool, align = TRUE, no.space = TRUE, intercept.bottom = FALSE, type = "text", 
          columns.labels = c("Pooled"), out = "pooled.html", model.names = FALSE)
rsltWithin <- plm(mdla, data = cleaned_data, model = "within")
summary(rsltWithin)
stargazer(rsltWithin, align = TRUE, no.space = TRUE, intercept.bottom = FALSE, type = "text")
stargazer(rsltWithin, align = TRUE, no.space = TRUE, intercept.bottom = FALSE, type = "text", 
          columns.labels = c("Within"), out = "within.html", model.names = FALSE)
rsltRandom <- plm(mdla, data = cleaned_data, model = "random")
summary(rsltRandom)
stargazer(rsltRandom, align = TRUE, no.space = TRUE, intercept.bottom = FALSE, type = "text")
stargazer(rsltRandom, align = TRUE, no.space = TRUE, intercept.bottom = FALSE, type = "text", 
          columns.labels = c("Random"), out = "random.html", model.names = FALSE)
stargazer(rsltWithin, rsltRandom, 
          align = TRUE, no.space = TRUE, intercept.bottom = FALSE, type = "text", title = "Table 7: Regression on Life.Ladder on GDP per capita, Social support, Healthy life expectancy at birth, Freedom to make life choice and Generosity", 
          column.labels = c("Fixed", "Random"), 
          out = "html_tables/table_7_final.html", model.names = FALSE)

# 2d
phtest(rsltWithin, rsltRandom)
