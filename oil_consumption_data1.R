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
oil_consumption1 <- read_excel("data/coal-consumption-per-TBD.xlsx")
head(oil_consumption1)
summary(oil_consumption1)

# change the class of the columns to numeric 
vec<- seq(2,57,1)
oil_consumption1[ , vec] <- apply(oil_consumption1[ , vec,drop=F], 2,           
                                   function(x) as.numeric(as.character(x)))
head(oil_consumption1)
summary(oil_consumption1)

# Tidy my data 
oil_consumption1 <- oil_consumption1 %>% 
  pivot_longer(-c(country, per_region), names_to = "year", values_to = "oil_comsumption_in_EJ")

summary(oil_consumption1)
sum(is.na(oil_consumption1))


# therefore we will do a back fill 
oil_consumption1 <- oil_consumption1 %>% fill(oil_comsumption_in_EJ, .direction = "up")
sum(is.na(oil_consumption1))
