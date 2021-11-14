library(tidyverse)
library(readxl)
library(tidyquant)
library(mice)
library(visdat)
library(naniar)
library(plotly)
library(ggplot2)
library(tidymodels)
# importing my data 
oil_consumption11 <- read_excel("data/oil-consumption.xlsx")
head(oil_consumption11)
summary(oil_consumption11)

# change the class of the columns to numeric 
vec<- seq(2,57,1)
oil_consumption11[ , vec] <- apply(oil_consumption11[ , vec,drop=F], 2,           
                                 function(x) as.numeric(as.character(x)))
head(oil_consumption)
summary(oil_consumption)

# Tidy my data 
oil_consumption <- oil_consumption %>% 
  pivot_longer(-c(country, OPEC_members, `paris-agr-members`,per_region), names_to = "year", values_to = "oil_comsumption_in_EJ")

oil_consumption$OPEC_members <- as.factor(oil_consumption$OPEC_members)
oil_consumption$`paris-agr-members` <- as.factor(oil_consumption$`paris-agr-members`)
# oil_consumption$year <- as.numeric(oil_consumption$year)
# class(oil_consumption$year)
summary(oil_consumption)
sum(is.na(oil_consumption))


head(oil_consumption)
oil_consumption %>% vis_miss()
# # plot the column to see the behavior 
# oil_consumption %>% group_by(country) %>% 
#   ggplot(aes(x= year, y= oil_comsumption_in_EJ))+
#   geom_point() +
#   facet_wrap(paris_agr_members) +
#   NULL
# 
# oil_consumption %>% 
#   plot_ly(x=~ year, y=~ oil_comsumption_in_EJ,
#           type = "scatter",
#           mode = "markers", 
#           color =~ country,
#           facet_wrap(~`paris-agr-members` , scales = "free")
#           )

oil_consumption %>% 
  plot_ly(x =~ oil_comsumption_in_EJ,
          type = "histogram",
          mode = "markers", 
          color =~ country
  )
# # from here we can see that the values are more concentrated in the lower half 
# oil_consumption %>% 
#   ggplot(aes(x= oil_comsumption_in_EJ))+
#   geom_density()

# therefore we will do a back fill 
oil_consumption <- oil_consumption %>% fill(oil_comsumption_in_EJ, .direction = "up")
sum(is.na(oil_consumption))

#-------------------------------------------------------------------------------

