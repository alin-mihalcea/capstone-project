#=========================
# STEP : DATA VISUALIZATION
#=========================

#Create a doughnut chart for the number of rides for each customer type
totals_customer_type$customer_type <- case_when(totals_customer_type$customer_type=="Casual Rider" ~ "Casual\nrider", 
                                                totals_customer_type$customer_type=="Annual Member" ~ "Annual\nmember")
totals_customer_type$ymax <- cumsum(totals_customer_type$total_rides_share)
totals_customer_type$ymin <- c(0, head(totals_customer_type$ymax, n=-1))
totals_customer_type$labelPosition <- (totals_customer_type$ymax + totals_customer_type$ymin) / 2
totals_customer_type$label <- paste0(totals_customer_type$customer_type,
                                     "\n", totals_customer_type$total_rides_mil, " mil")


ggplot(totals_customer_type, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=2, fill=customer_type)) +
  geom_rect() +
  geom_text( x=6, aes(y=labelPosition, label=label, color=customer_type), size=5) +
  geom_text( x=2.9, aes(y=labelPosition, label=total_rides_percent), size=5) +
  coord_polar(theta="y") +
  xlim(c(-1, 6)) +
  theme_void() +
  theme(legend.position = "none") +
  annotate("text", x = 1.1, y = 1,
           label = paste("\n\n\n","Total rides\n", totals$total_rides_mil, " mil"),
           size = 7)

#Create a bar chart for the average duration of the ride for each customer type
ggplot(totals_customer_type, aes(x = customer_type, y = avg_time, fill=customer_type)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label = avg_time), position = position_stack(vjust = 0.5)) +
  geom_segment(size=1,linetype=2,aes(x = 0.55, xend = 2.45, y = totals$avg_time, yend = totals$avg_time))+
  annotate("text", x = 1, y = (totals$avg_time), label = paste("Total average time\n", totals$avg_time))+
  labs(title="Average ride time") +
  scale_x_discrete(labels=totals_customer_type$customer_type)+
  theme(axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.y=element_blank(),
        legend.position = "none",
        panel.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"))

#Create a bar chart for the number of rides per each day of the week
ggplot(weekdays_customer_type_df, aes(x=factor(week_day_name, levels=c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')), y=total_rides_10k, fill=customer_type)) + 
  geom_bar(stat="identity", position=position_dodge())+
  theme(axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"))+
  labs(y="Number of rides (10.000)")+
  geom_text(aes(label = total_rides_10k, group=customer_type), position=position_dodge(width=0.9), vjust=-0.8)+
  scale_fill_discrete(name=NULL)


#Group the week_segment data frame by the weekend and workweek day
weekdays_customer_type_df$week_segment <- case_when(weekdays_customer_type_df$week_day_name=="Mon" ~ "Workweek",
                                                    weekdays_customer_type_df$week_day_name=="Tue" ~ "Workweek",
                                                    weekdays_customer_type_df$week_day_name=="Wed" ~ "Workweek",
                                                    weekdays_customer_type_df$week_day_name=="Thu" ~ "Workweek",
                                                    weekdays_customer_type_df$week_day_name=="Fri" ~ "Workweek",
                                                    weekdays_customer_type_df$week_day_name=="Sat" ~ "Weekend",
                                                    weekdays_customer_type_df$week_day_name=="Sun" ~ "Weekend")
week_segment_df <- weekdays_customer_type_df %>%
  group_by(week_segment, customer_type) %>%
  summarise(total_rides = sum(total_rides))
week_segment_df$avg_day <- case_when(week_segment_df$week_segment=="Weekend" ~ week_segment_df$total_rides/2,
                                     week_segment_df$week_segment=="Workweek" ~ week_segment_df$total_rides/5)
week_segment_df$avg_day_10k <- as.numeric(format(round(week_segment_df$avg_day/10000, 0), nsmall = 0))
View(week_segment_df)

#Create a bar chart for the average number of rides for each week segment for each customer type
ggplot(week_segment_df, aes(x=week_segment, y=avg_day_10k, fill=customer_type)) + 
  geom_bar(stat="identity", position=position_dodge())+
  theme(axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"))+
  labs(y="Average daily rides (10.000)")+
  geom_text(aes(label = avg_day_10k, group=customer_type),
            position=position_dodge(width=0.9), vjust=-0.8)+
  scale_fill_discrete(name=NULL)

#Create a bar chart for the number of rides per each month
ggplot(months_customer_type_df , aes(x=factor(month,
                                              levels=c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                                       'Jul', 'Aug' , 'Sep', 'Oct', 'Nov', 'Dec')),
                                     y=total_rides_10k, fill=customer_type)) + 
  geom_bar(stat="identity", position=position_dodge())+
  theme(axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"))+
  labs(y="Number of rides (10.000)")+
  geom_text(aes(label = total_rides_10k, group=customer_type),
            position=position_dodge(width=0.9), vjust=-0.8)+
  scale_fill_discrete(name=NULL)


#Create a bar chart for the number of rides per bike type and customer type

bike_type_df_labels <- bike_type_df %>%
  arrange(rideable_type, rev(customer_type))

bike_type_df_labels <- bike_type_df_labels %>%
  group_by(rideable_type) %>%
  mutate(label_y = cumsum(total_rides_10k) - 0.5 * total_rides_10k)

ggplot(bike_type_df_labels, aes(x=rideable_type, y=total_rides_10k, fill=customer_type)) + 
  geom_bar(stat="identity")+
  theme(axis.title.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        panel.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"))+
  labs(y="Number of rides (10.000)")+
  geom_text(aes(y = label_y, label = total_rides_10k, group=customer_type))+
  scale_fill_discrete(name=NULL)+
  geom_text(data=bike_type_total_df,
            aes(x=rideable_type, label=total_rides_10k, y=total_rides_10k, fill=NULL), nudge_y=10)

#Create a heat map for the number of rides structures as a calendar for the entire year
tripdata_2022$week <- week(tripdata_2022$started_at)
tripdata_2022$month_week <- ceiling(as.numeric(format(tripdata_2022$started_at, "%d")) / 7)

heat_map_df <- tripdata_2022 %>%
  group_by(month, week, month_week, week_day_name) %>%
  summarise(total_rides = n())

ggplot(heat_map_df, aes(month_week, factor(week_day_name,
                                           levels=c("Sun", "Sat", "Fri", "Thu", "Wed", "Tue", "Mon")),
                        fill = total_rides)) + 
  geom_tile(colour = "white") + 
  facet_grid(~factor(month, levels=c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                     'Jul', 'Aug' , 'Sep', 'Oct', 'Nov', 'Dec'))) + 
  scale_fill_gradient(low="red", high="green")+
  labs(x="Week of the month", fill="Total rides")+
  theme(panel.background = element_rect(fill = "#FFFFFF", colour = "#FFFFFF"),
        axis.title.y=element_blank())