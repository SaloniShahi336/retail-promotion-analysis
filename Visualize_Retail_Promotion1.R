library(ggplot2)
View(transaction_data_v2python)

my_colors <- colorRampPalette(c("#1f77b4", "#ff7f0e"))(
  length(unique(transaction_data_v2python$store_id))
)



ggplot(transaction_data_v2python, 
       aes(x = store_id, y = tx_revenue, fill = store_id)) +
  geom_boxplot(
    alpha = 0.75,
    outlier.fill  = "#F7F4ED",
    outlier.color = "#3A0F56",
    outlier.size = 2.5,
    outlier.stroke = 0.6,
    color = "black"
  )+
  
  scale_fill_manual(values = c(
    "STORE-0004" = "#8D5A97",  # muted plum
    "STORE-0014" = "#55A892"   # muted deep teal
  )) +
  
  stat_summary(fun = median, geom = "crossbar",
               width = 0.6, color = "black",
               size = 0.6) +
  scale_y_continuous(breaks = seq(0, 100, by = 15)) +
  
  theme_minimal(base_size = 20) +
  theme(legend.position = "none",
        plot.title = element_text(face = "bold", size = 18,hjust = 0.5),
        axis.text.x = element_text(angle = 0,hjust = 0.5)) +
  labs(title = "Transaction Revenue Distribution by Store",
       x = "Store ID", y = "Transaction Revenue")


#*****************************************************************#
ggsave("D:/Kate 6202 R/Analytics Problem Set/Graphs_recentwhite.png",
       width = 14, height = 7, dpi = 300)

#*****************************************************************#
library(ggplot2)
library(scales)   # for alpha()

ggplot(transaction_data_v2python, 
       aes(x = store_id, y = tx_revenue, fill = store_id)) +
  geom_boxplot(
    alpha = 0.75,               # box transparency
    color = "black",            # box borders
    outlier.shape  = 21,        # circle with border + fill
    outlier.fill   = "#F7F4ED", # soft ivory centre (shows overlap)
    outlier.color  = "#3A0F56", # dark purple border
    outlier.size   = 3,
    outlier.stroke = 1
  ) +
  
  # Store colors (Palette B)
  scale_fill_manual(values = c(
    "STORE-0004" = "#8D5A97",   # muted plum
    "STORE-0014" = "#55A892"    # muted deep teal
  )) +
  
  # Strong, clear median line
  stat_summary(fun = median, geom = "crossbar",
               width = 0.55, color = "black", size = 0.8) +
  
  scale_y_continuous(breaks = seq(0, 100, by = 15)) +
  
  theme_minimal(base_size = 14) +
  theme(
    legend.position      = "none",
    plot.title           = element_text(face = "bold", size = 16, hjust = 0.5),
    axis.text.x          = element_text(angle = 0, hjust = 0.5),
    panel.grid.major.x   = element_blank(),   # removes vertical gridlines
    panel.grid.minor     = element_blank()    # cleaner background
  ) +
  labs(
    title = "Transaction Revenue Distribution by Store",
    x     = "Store ID",
    y     = "Transaction Revenue"
  )


ggsave("D:/Kate 6202 R/Analytics Problem Set/Graphs_recent.png",
       width = 14, height = 7, dpi = 300)
#***********************************************************************#


library(ggplot2)
library(dplyr)

# Stats summary
stats_df <- transaction_data_v2python %>%
  group_by(store_id) %>%
  summarise(
    median = median(tx_revenue),
    Q1 = quantile(tx_revenue, 0.25),
    Q3 = quantile(tx_revenue, 0.75),
    mean = mean(tx_revenue),
    n = n()
  )

ggplot(transaction_data_v2python, 
       aes(x = store_id, y = tx_revenue, fill = store_id)) +
  geom_boxplot(
    alpha = 0.75,               # box transparency
    color = "black",            # box borders
    outlier.shape  = 21,        # circle with border + fill
    outlier.fill   = "#F7F4ED", # soft ivory centre (shows overlap)
    outlier.color  = "#3A0F56", # dark purple border
    outlier.size   = 3,
    outlier.stroke = 2
  ) +
  
  # Store colors
  scale_fill_manual(values = c(
    "STORE-0004" = "#8D5A97",
    "STORE-0014" = "#55A892"
  )) +
  
  # Median line
  stat_summary(
    fun = median,
    geom = "crossbar",
    width = 0.6,
    color = "black",
    size = 0.8
  ) +
  
  # Annotation: Median & IQR
  geom_text(
    data = stats_df,
    aes(x = store_id, y = Q3 + 5,
        label = paste0("Median: ", round(median,1),
                       "\nIQR: ", round(Q1,1), "–", round(Q3,1))),
    size = 4
  ) +
  scale_y_continuous(breaks = seq(0, 100, by = 15)) +
  # Annotation: Sample size
  geom_text(
    data = stats_df,
    aes(x = store_id, y = -5,
        label = paste0("n = ", n)),
    size = 4
  ) +
  
  theme_minimal(base_size = 18) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 20, hjust = 0.5)
  ) +
  labs(
    title = "Transaction Revenue Distribution by Store",
    x = "Store ID",
    y = "Transaction Revenue"
  )


ggsave("D:/Kate 6202 R/Analytics Problem Set/transaction_revenue_boxplot.png",
       width = 7, height = 7, dpi = 300)

#*****************************************************************************#
#*#*****************************************************************************#
#*****************************************************************************#
# Stats summary for items_purchased
stats_items <- transaction_data_v2python %>%
  group_by(store_id) %>%
  summarise(
    median = median(items_purchased),
    Q1 = quantile(items_purchased, 0.25),
    Q3 = quantile(items_purchased, 0.75),
    mean = mean(items_purchased),
    n = n()
  )

ggplot(transaction_data_v2python, 
       aes(x = store_id, y = items_purchased, fill = store_id)) +
  
  # ----- BOX PLOT -----
geom_boxplot(
  alpha = 0.75,
  color = "black",
  outlier.shape  = 21,
  outlier.fill   = "#F0F4FF",   # soft pearl (visible but not noisy)
  outlier.color  = "#002B5B",   # navy border for corporate look
  outlier.size   = 3,
  outlier.stroke = 2
) +
  
  # ----- STORE COLORS (NEW BUSINESS PALETTE) -----
scale_fill_manual(values = c(
  "STORE-0004" = "#4C72B0",   # steel blue (clean, corporate)
  "STORE-0014" = "#E69F00"    # business amber/orange (contrast)
)) +
  
  # ----- MEDIAN LINE -----
stat_summary(
  fun = median,
  geom = "crossbar",
  width = 0.6,
  color = "black",
  linewidth = 0.8
) +
  
  # ----- ANNOTATION: Median & IQR -----
geom_text(
  data = stats_items,
  aes(x = store_id, 
      y = Q3 + 1,                                       # adjust upward
      label = paste0("Median: ", round(median,1),
                     "\nIQR: ", round(Q1,1), "–", round(Q3,1))),
  size = 4,
  color = "black"
) +
  
  # ----- Y-AXIS SCALE -----
scale_y_continuous(breaks = seq(0, max(transaction_data_v2python$items_purchased), by = 2)) +
  
  # ----- SAMPLE SIZE -----
geom_text(
  data = stats_items,
  aes(x = store_id, y = -1,
      label = paste0("n = ", n)),
  size = 4,
  color = "grey20"
) +
  
  # ----- THEME -----
theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5)
  ) +
  
  # ----- LABELS -----
labs(
  title = "Items Purchased Distribution by Store",
  x = "Store ID",
  y = "Items Purchased"
)
ggsave("D:/Kate 6202 R/Analytics Problem Set/item_purchased_boxplot.png",
       width = 7, height = 7, dpi = 300)


#**************************************************************************
#**************************************************************************
#KDE
ggplot(transactions_data_analysis25nov,
       aes(x = tx_revenue, color = store_id, fill = store_id)) +
  
  geom_density(alpha = 0.35, linewidth = 1.1) +   # darker/thicker borders
  
  scale_color_manual(values = c(
    "STORE-0004" = "#8D5A97",  # muted plum
    "STORE-0014" = "#55A892"
    )) +
  
  scale_fill_manual(values = c(
    "STORE-0004" = "#D9C2DD",   # light steel blue fill
    "STORE-0014" = "#BFE6D8"    # soft amber fill
  )) +
  
  xlim(0, 20) +
  labs(
    title = "KDE Plot of Transaction Revenue by Store",
    x = "Transaction Revenue",
    y = "Density",
    color = "Store",
    fill = "Store",
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text   = element_text(face = "bold") 
  )

ggsave("D:/Kate 6202 R/Analytics Problem Set/Revenue_KDE.png",
       width = 7, height = 7, dpi = 300)
#####################################################

max(transactions_data_analysis25nov$items_purchased[transactions_data_analysis25nov$store_id == "STORE-0014"])


ggplot(transactions_data_analysis25nov,
       aes(x = items_purchased, color = store_id, fill = store_id)) +
  geom_density(alpha = 0.35, linewidth = 1.1, adjust = 1.5) +  # smoother
  coord_cartesian(xlim = c(0, 6)) +                             # zoom to data
  scale_color_manual(values = c(
    "STORE-0004" = "#4C72B0",
    "STORE-0014" = "#E69F00"
  )) +
  scale_fill_manual(values = c(
    "STORE-0004" = "#A3C1DA",
    "STORE-0014" = "#F9D8A6"
  )) +
  labs(
    title = "KDE Plot of Items Purchased by Store",
    x = "Items Purchased",
    y = "Density",
    color = "Store",
    fill = "Store"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold",hjust=0.5),
    axis.title = element_text(size = 12)
  )
ggsave("D:/Kate 6202 R/Analytics Problem Set/Items_purchased_KDE.png",
       width = 7, height = 7, dpi = 300)

#######BAR CHART*********************************************************

ggplot(transactions_data_analysis25nov,
       aes(x = factor(items_purchased), fill = store_id)) +
  geom_bar(
    position = "dodge",      # side-by-side bars for each store
    color    = "black",      # bar borders
    alpha    = 0.85
  ) +
  scale_fill_manual(values = c(
    "STORE-0004" = "#4C72B0",  # steel blue  (same as boxplot)
    "STORE-0014" = "#E69F00"   # business amber (same as boxplot)
  )) +
  labs(
    title = "Distribution of Items Purchased by Store",
    x     = "Items Purchased",
    y     = "Count of Transactions",
    fill  = "Store"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title   = element_text(face = "bold", size = 16,hjust=0.5),
    axis.title   = element_text(size = 12)
  )
ggsave("D:/Kate 6202 R/Analytics Problem Set/Itemspurchased_barchart.png",
       width = 7, height = 7, dpi = 300)


#*****************************************************************************#
#*****************************************************************************
#*FOR AVG ITEM PRICE
transaction_data_v2python <- transaction_data_v2python %>%
  mutate(avg_item_price = ifelse(items_purchased == 0, NA, tx_revenue / items_purchased))

stats_avg <- transaction_data_v2python %>%
  group_by(store_id) %>%
  summarise(
    median = median(avg_item_price, na.rm = TRUE),
    Q1     = quantile(avg_item_price, 0.25, na.rm = TRUE),
    Q3     = quantile(avg_item_price, 0.75, na.rm = TRUE),
    mean   = mean(avg_item_price, na.rm = TRUE),
    n      = n()
  )

# STEP 2: Plot
ggplot(transaction_data_v2python, 
       aes(x = store_id, y = avg_item_price, fill = store_id)) +
  
  # ----- BOX PLOT -----
geom_boxplot(
  alpha         = 0.75,
  color         = "black",
  outlier.shape = 21,
  outlier.fill  = "#F5F5F5",   # soft neutral fill for outliers
  outlier.color = "#2C2C54",   # deep indigo border
  outlier.size  = 3,
  outlier.stroke= 2
) +
  
  # ----- STORE COLORS (THIRD THEME) -----
scale_fill_manual(values = c(
  "STORE-0004" = "#3D52A0",   # deep steel blue
  "STORE-0014" = "#B6465F"    # rich maroon
)) +
  
  # ----- MEDIAN LINE -----
stat_summary(
  fun       = median,
  geom      = "crossbar",
  width     = 0.6,
  color     = "black",
  linewidth = 0.8
) +
  
  # ----- ANNOTATION: Median & IQR -----
geom_text(
  data = stats_avg,
  aes(x = store_id, 
      y = Q3 + 1,   # adjust upward if needed
      label = paste0("Median: ", round(median, 1),
                     "\nIQR: ", round(Q1, 1), "–", round(Q3, 1))),
  size  = 4,
  color = "black"
) +
  
  # ----- SAMPLE SIZE -----
geom_text(
  data = stats_avg,
  aes(x = store_id, y = 0,
      label = paste0("n = ", n)),
  size  = 4,
  color = "grey20",
  vjust = 1.5
) +
  
  # ----- Y-AXIS (optional: adjust breaks if needed) -----
scale_y_continuous() +
  
  # ----- THEME -----
theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    plot.title      = element_text(face = "bold", size = 16, hjust = 0.5)
  ) +
  
  # ----- LABELS -----
labs(
  title = "Average Item Price Distribution by Store",
  x     = "Store ID",
  y     = "Average Item Price"
)

ggsave("D:/Kate 6202 R/Analytics Problem Set/avg_item_price_boxplot.png",
       width = 7, height = 7, dpi = 300)


##########--------------KDE------------
ggplot(transaction_data_v2python,
       aes(x = avg_item_price, color = store_id, fill = store_id)) +
  
  geom_density(alpha = 0.35, linewidth = 1.1, adjust = 1.5) +   # smoother KDE + dark borders
  
  # ----- COLOR THEME (same as boxplot) -----
scale_color_manual(values = c(
  "STORE-0004" = "#3D52A0",   # deep steel blue
  "STORE-0014" = "#B6465F"    # rich maroon
)) +
  
  scale_fill_manual(values = c(
    "STORE-0004" = "#C9D4F2",   # light steel blue
    "STORE-0014" = "#EEC4CD"    # light rose-mauve
  )) +
  
  # Auto-zoom the x-axis to relevant range
  coord_cartesian(xlim = c(0, max(transaction_data_v2python$avg_item_price, na.rm = TRUE))) +
  
  labs(
    title = "KDE Plot of Average Item Price by Store",
    x     = "Average Item Price",
    y     = "Density",
    color = "Store",
    fill  = "Store"
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    plot.title  = element_text(size = 14, face = "bold",hjust=0.5),
    axis.title  = element_text(size = 12)
  )

ggsave("D:/Kate 6202 R/Analytics Problem Set/avg_item_price_KDE.png",
       width = 7, height = 7, dpi = 300)
