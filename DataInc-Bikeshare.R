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



ggplot(bikeshare, aes(x=factor(season), y=cnt)) + ggtitle("Capital User Count by Season in 2011 and 2012") + geom_boxplot() + stat_summary(fun.y = "mean",  geom = "point", shape=22, size=3, fill="dodgerblue") + facet_wrap(~ yr) + theme(strip.text = element_text(face = "bold", size = rel(1.25), color = "white"), strip.background= element_rect(fill = "tomato", color = "red", size = 1))
hist(sqrt(bikeshare$cnt)) # Chosen as transformation for linear regression modeling
bikeshare$cnt.trans<- sqrt(bikeshare$cnt)
library (leaps)
preds<- with(bikeshare, cbind(season, yr, mnth, hr, holiday, weekday, workingday, weathersit, temp, atemp, hum, windspeed, casual, registered))
x1<- regsubsets(preds, y=bikeshare$cnt.trans)
rs<- summary(x1)
rs$which[which.max(rs$adjr2),]
rs$which[which.min(rs$cp),]
plot(rs$adjr2 ~ I(1:8), ylab = "Adjusted R Squared", xlab = "# of Predictors, not incl intercept")
lines(spline(rs$adjr2 ~ I(1:8)))
plot(rs$cp ~ I(1:8), ylab = "Mallow's Cp Stat", xlab = "# of fitted coefficients", main="Best subsets Comparison of Mallow's Cp")
lines(spline(rs$cp ~ I(1:8)))
library(car)
subsets(x1, statistic=c("adjr2"), legend="topright", cex = 0.5) # Sanity check
subsets(x1, statistic=c("cp"), legend="topright", cex = 0.55)

anova(M1.lm)
