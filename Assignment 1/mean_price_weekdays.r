# ebay_data[is.na(ebay_data)] <- 0

plt$figure()$clear()
plt$close()
plt$cla()
plt$clf()

# generate a barplot with x weekday and y mean price. fr every day, split between basketball and baseball using basketball column
# make the font size larger for the axis labels
sns$barplot(x = "weekday", y = "sold_price", hue = "basketball", data = ebay_data)

# format the x axys to show the days of the week
plt$xticks(np$arange(7), weekdays)

# # make the width of the bars smaller
# plt$rcParams["figure.figsize"] <- c(10, 5)
# change the label of the y axis to be Mean of sold_price
plt$ylabel("Mean of sold_price")

# change the legend to have values 0=baseball and 1=basketball, while retaining the colors in the barplot
legend_info <- plt$gca()$get_legend_handles_labels()
handles <- legend_info[[1]]
labels <- legend_info[[2]]

# Modify the labels
new_labels <- c("Baseball", "Basketball")

# Set the legend with the modified labels and original handles and upscale it
plt$legend(handles, new_labels, loc = "upper left", fontsize = 20)


# sns$barplot(x = "weekday", y = "sold_price", data = ebay_data)
plt$savefig("plots/weekday_sold_price.png")