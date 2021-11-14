

# impprt 

cost <- read_excel("data/cost.xlsx")
head(cost)
# creating time series 
# cost_ts <- ts(cost$`$ 2020`, start = c(1861), frequency = 1)
cost_ts1 <- ts(cost$`$ money of the day`, start = c(1861), frequency = 1)

# cons_ts <- oil_consumption %>% group_by(year) %>% 
#   summarise(total_cons = sum(oil_comsumption_in_EJ))
# 
# cons_ts <- ts(cons_ts$total_cons, start = 1965)
# class(cons_ts)
# plot(cons_ts)
# plot(cost_ts)
plot(cost_ts1)
# time(cost_ts)
start(cost_ts1)
end(cost_ts1)
cycle(cost_ts1)
aggregate(cost_ts1)

plot(aggregate(cost_ts1))
# boxplot(cost_ts1~cycle(cost_ts1))

decompose(cost_ts1) %>% plot()
# ts.union(cons_ts, cost_ts1) %>% 
ts.intersect(cons_ts, cost_ts1) %>% 
  # acf()
plot()


HoltWinters(cost_ts1)

predict(HoltWinters(cost_ts1), n.ahead = 10*4) %>% plot()

plot(HoltWinters(cost_ts1))
#-------------------------------------------------------------------------------
