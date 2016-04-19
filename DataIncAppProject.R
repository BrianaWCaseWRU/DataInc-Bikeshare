library(ggplot2)
library(dplyr)
library(rms)
library(Hmisc)
library(leaps)
library(car)
library(MASS)
library(lars)
bikeshare<- read.csv("C://hoursDataInc.csv")
attach(bikeshare)
glimpse(bikeshare)
summary(bikeshare)

bikeshare$season<- as.factor(bikeshare$season)
bikeshare$season<- factor(bikeshare$season, labels = c("Spring", "Summer", "Fall", "Winter"))
bikeshare$yr<- as.factor(bikeshare$yr)
bikeshare$yr<- factor(bikeshare$yr, labels = c("2011", "2012"))
bikeshare$mnth<- as.numeric(bikeshare$mnth)
bikeshare$hr<- as.factor(bikeshare$hr)
bikeshare$hr<- factor(bikeshare$hr, labels = c("12a", "1a", "2a", "3a", "4a", "5a", "6a", "7a", "8a", "9a", "10a", "11a", "12p",  "1p", "2p", "3p", "4p", "5p", "6p", "7p", "8p", "9p", "10p", "11p"))
bikeshare$holiday<- as.factor(bikeshare$holiday)
bikeshare$holiday<- factor(bikeshare$holiday, levels = c("No", "Yes"))
bikeshare$weekday<- as.factor(bikeshare$weekday)
bikeshare$weekday<- factor(bikeshare$weekday, levels = c("Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"))
bikeshare$weathersit<- as.factor(bikeshare$weathersit)
bikeshare$workingday<- as.factor(bikeshare$workingday)
glimpse(bikeshare) #Sanity check




anova(M1.lm)
