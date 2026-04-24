library(readxl)
transactions_data_analysis25nov <- read_excel("D:/Kate 6202 R/Analytics Problem Set/transactions_data_analysis25nov.xlsx")
View(transactions_data_analysis25nov)

library(ggplot2)

####BOX plot 1 for Revenue
ggplot(transactions_data_analysis25nov, aes(x = store_id, y = tx_revenue, fill = store_id)) +
  geom_boxplot() +
  scale_fill_manual(values = c("STORE-0004" = "#D5A6D3",  
                               "STORE-0014" = "#A5D1C1")) + 
  labs(
    title = "Boxplot of Transaction Revenue by Store",
    x = "Store",
    y = "Transaction Revenue"
  ) +
  ylim(0, 90)+
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "none"
  )

ggsave("boxplot_tx_revenue.png", width = 10, height = 7, dpi = 300)

#************#

####BOX plot 2 for Items_purchased

ggplot(transactions_data_analysis25nov, aes(x = store_id, y = items_purchased, fill = store_id)) +
  geom_boxplot() +
  scale_fill_manual(values = c("STORE-0004" = "#F0D9EF",  
                               "STORE-0014" = "#CDE9DC")) + 
  labs(title = "Boxplot of items purchased by store",
    x = "Store",
    y = "Items Purchased")+
  ylim(0, 7)+
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "none"
  )


#**********************#

#kDE plot for Transaction Revenue

ggplot(transactions_data_analysis25nov,
       aes(x = tx_revenue, color = store_id, fill = store_id)) +
  geom_density(alpha = 0.4) +
  xlim(0, 20) +
  labs(
    title = "KDE Plot of Transaction Revenue by Store",
    x = "Transaction Revenue",
    y = "Density",
    color = "Store",
    fill = "Store"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12)
  )

max(transactions_data_analysis25nov$tx_revenue[transactions_data_analysis25nov$store_id == "STORE-0014"])
#*******Interpretation*********
#Store 14 shows a higher density of transactions in the $7–$10 range compared 
#to Store 4, suggesting that customers at the treatment store are more likely
#to make mid-priced purchases—possibly due to the meal deal encouraging them to
#buy a combined food-and-beverage option.  



#*************************************************************#

## For food_count

ggplot(transactions_data_analysis25nov, aes(x = store_id, y = total_food_count, fill = store_id)) +
  geom_boxplot() +
  scale_fill_manual(values = c("STORE-0004" = "#0D47A1",  
                               "STORE-0014" = "#FFC300")) + 
  labs(
    title = "Boxplot of Food Count by Store",
    x = "Store",
    y = "Food Count"
  ) +
  ylim(0, 4)+
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "none"
  )
#------------------------------------------------------------------#
#For avg_item_price
ggplot(transactions_data_analysis25nov, aes(x = store_id, y = avg_item_price, fill = store_id)) +
  geom_boxplot() +
  scale_fill_manual(values = c("STORE-0004" = "#90CAF9",  
                               "STORE-0014" = "#FFC300")) + 
  labs(
    title = "Boxplot of Average Item Price by Store",
    x = "Store",
    y = "Average Item Price"
  ) +

  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "none"
  )

#***********************************************************************#

#kDE plot for Transaction Revenue

ggplot(transactions_data_analysis25nov,
       aes(x = tx_revenue, color = store_id, fill = store_id)) +
  geom_density(alpha = 0.4) +
  xlim(0, 20) +
  labs(
    title = "KDE Plot of Transaction Revenue by Store",
    x = "Transaction Revenue",
    y = "Density",
    color = "Store",
    fill = "Store"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12)
  )

#****************************#


#stats for avg_item_price
install.packages("e1071")
library(e1071)

#---By stores
library(dplyr)

summary_stats <- transactions_data_analysis25nov %>%
  group_by(store_id) %>%
  summarise(
    mean = mean(avg_item_price, na.rm = TRUE),
    median = median(avg_item_price, na.rm = TRUE),
    sd = sd(avg_item_price, na.rm = TRUE),
    skewness = skewness(avg_item_price, na.rm = TRUE)
  )

summary_stats

#-----Combine
combined_stats <- transactions_data_analysis25nov %>%
  summarise(
    mean = mean(avg_item_price, na.rm = TRUE),
    median = median(avg_item_price, na.rm = TRUE),
    sd = sd(avg_item_price, na.rm = TRUE),
    skewness = skewness(avg_item_price, na.rm = TRUE)
  )

combined_stats

#to remove object created
rm(ombined_stats)

#****************************************************************************#

#3.1 P(purchases 3+ items)
prob_3plus <- transactions_data_analysis25nov%>%
  group_by(store_id) %>%
  summarise(
    probability_3plus = mean(items_purchased >= 3)
  )

prob_3plus

#3.2 P(purchases food | purchases beverage)

prob_food_given_bev <- transactions_data_analysis25nov %>%
  group_by(store_id) %>%
  summarise(
    P_food_given_beverage =
      mean(total_food_count > 0 & total_Beverage_count > 0) /
      mean(total_Beverage_count > 0)
  )

prob_food_given_bev

#3.3 P(purchases pastry box | weekend) and P(purchases pastry box | weekday)


#creating new column for weekday and weekend
transactions_data_analysis25nov <- transactions_data_analysis25nov %>%
  mutate(
    is_weekend = tx_day_of_week %in% c("Saturday", "Sunday")
  )


prob_pastry_weekday_weekend <- transactions_data_analysis25nov %>%
  group_by(store_id) %>%
  summarise(
    P_pastry_weekend =
      mean(pastry_box_count > 0 & is_weekend) / mean(is_weekend),
    
    P_pastry_weekday =
      mean(pastry_box_count > 0 & !is_weekend) / mean(!is_weekend)
  )

prob_pastry_weekday_weekend

#******************************************************************************#
#******************************************************************************#

#Inferential Statistics
View(store_performance_data)
store_data<- store_performance_data
summary(store_data)

# 0 = control, 1 = Treatment- reference control
store_data$group <- factor(
  store_data$group,
  levels = c("Control", "Treatment"),
  ordered = FALSE
)

#Location
store_data$location_type<- factor(
  store_data$location_type,
  levels=c("Urban","Suburban","Highway"),
  ordered=FALSE
)

#drive_thru
store_data$has_drive_thru<- factor(
  store_data$has_drive_thru,
  levels=c("Yes","No"),
  ordered=FALSE
  )

#create column for avy_daily_revenue
store_data$avg_daily_revenue <- store_data$total_revenue / 28
colnames(store_data)

#Simple regression model
Model1<-lm(avg_daily_revenue~group,data = store_data)
summary(Model1)
##Treatment stores make $260.56 more per day than Control stores.
#The p-value = 0.01997 < 0.05, so the difference is statistically significant.

#******************************************************************************#
Model_all<-lm(avg_daily_revenue ~ group + location_type + has_drive_thru +
  store_size_sqft + years_operating + local_population_k +parking_spaces,
  data=store_data)
summary(Model_all)

#******************************************************************************#

Model_noparking<-lm(avg_daily_revenue ~ group + location_type + has_drive_thru +
                store_size_sqft +years_operating+local_population_k,
              data=store_data)
summary(Model_noparking)

round(summary(Model_noparking)$coefficients, 8)




#checking multicollinearity
install.packages("car")
library(car)
vif(Model_all)
vif(Model_noparking)

##
rm(Model_noparking)
library(tidyverse)
library(broom)

