# generate a barplot with x axis active_player and y axis mean sold_price
sns$barplot(x = "active_player", y = "sold_price", data = ebay_data, hue="basketball")

