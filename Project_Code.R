##Base Data Cleaning
install.packages("tidyverse")
library(readxl)
d <- read_excel("Underlying Cause of Death, 2005-2020.xlsx")
View(d)
str(d)

d2 <- read_excel("Dataset-1.xlsx")

d2$Year <- ifelse(d2$Year< "2005", NA, d2$Year)

na.omit(d2)

d3 <- d2[complete.cases(d2), ]

table(d3$Year)
table(d2$Year)
table(d$Year)


table(d$State)
table(d$Year)
table(d$`Ten-Year Age Groups`)
table(d$`Ten-Year Age Groups Code`)
d$`Ten-Year Age Groups Code` <- ifelse(d$`Ten-Year Age Groups Code`=="44695","5-14",d$`Ten-Year Age Groups Code`)
table(d$`Ten-Year Age Groups Code`)

##Merging datasets
d <- read_excel("Suicide Data.xlsx", sheet=1)
d2 <- read_excel("Suicide Data.xlsx", sheet=2)
d3 <- read_excel("Suicide Data.xlsx", sheet=3)
d4 <- read_excel("Suicide Data.xlsx", sheet=4)
d5 <- read_excel("Suicide Data.xlsx", sheet=5)
d6 <- read_excel("Suicide Data.xlsx", sheet=6)
d7 <- read_excel("Suicide Data.xlsx", sheet=7)
d8 <- read_excel("Suicide Data.xlsx", sheet=8)
d9 <- read_excel("Suicide Data.xlsx", sheet=9)

colnames(d2) <- c("Year", "MortgageRate")
colnames(d3) <- c("State","Year","UnempRate")
colnames(d4) <- c("State","Year","IncomeTax")
colnames(d5) <- c("Year","State","MinWage")
colnames(d6) <- c("InflationRate","Year","CPI")
colnames(d9) <- c("State","MentalHealth")




table(d6$Year)
table(d5$Year)
table(d4$Year)
table(d$State)

table(d5$State)
d5 <- d5[d5$State!="U.S. Virgin Islands",]
d5 <- d5[d5$State!="Guam",]
d5 <- d5[d5$State!="Puerto Rico",]
d6 <- d6[d6$Year>2004,]
d6 <- d6[d6$Year!=2021,]

d8 <- d8[d8$Year>2004,]
d8 <- d8[d8$Year!=2021,]

library("dplyr")

df <- merge(d3,d4,by=c("Year","State"))
df2 <- merge(df,d5,by=c("Year","State"))
df3 <- merge(df2,d6,by=c("Year"))
df4 <- merge(df3,d8,by=c("Year"))
df5 <- merge(df4,d2,by=c("Year"))
df6 <- merge(d7,d9,by=c("State"))
df7 <- merge(df5,df6,by=c("State"))
df7 <- df7[order(df7$Year),]

dfinal <- merge(d,df7,by=c("Year","State"))

dfinal$`2013 Urbanization` <- ifelse(dfinal$`2013 Urbanization`=="Large Central Metro" | dfinal$`2013 Urbanization`=="Large Fringe Metro"
                                     | dfinal$`2013 Urbanization`=="Medium Metro" | dfinal$`2013 Urbanization`=="Small Metro", "Urban", "Rural")


dfinal_new <- dfinal[,-c(4,5,6,8,9,13,17)]

names(dfinal_new) <- tolower(names(dfinal_new))
str(dfinal_new)

names(dfinal_new)[names(dfinal_new) == '2013 urbanization'] <- 'urbanization'
names(dfinal_new)[names(dfinal_new) == 'ten-year age groups code'] <- 'agegroups'
names(dfinal_new)[names(dfinal_new) == 'gfi'] <- 'gunscore'

dfinal_new$`agegroups` <- ifelse(dfinal_new$`agegroups`=="44695","5-14",dfinal_new$`agegroups`)
table(dfinal_new$agegroups)

library("writexl")
write_xlsx(dfinal_new,"/Users/varmasagi/Downloads/Suicide FinalNew3.xlsx")

library(readxl)
dfinal_new <- read_excel("Suicide FinalNew3.xlsx")
dfinal_new$suiciderate = dfinal_new$deaths/dfinal_new$population


##Visualizations
install.packages("usmap")
library(usmap)
##Grouped for getting total sum between years 2005-2020.

dummy <- aggregate(dfinal_new$suiciderate, by=list(state=dfinal_new$state), FUN=sum)
str(dummy)
names(dummy)[names(dummy) == 'x'] <- 'suiciderate'
library(ggplot2)
plot_usmap(data = dummy, values = "suiciderate", color = "Red", labels = TRUE) +
  scale_fill_continuous(low = "White", high = "Red", name = "SuicideRate Scale", label = scales::comma) +
  labs(title = "SuicideRate in USA year 2005-2020") +
  theme(legend.position = "right")



dummy_year_deaths <- aggregate(dfinal_new$deaths, by=list(year=dfinal_new$year), FUN=sum)
str(dummy_year_deaths)
names(dummy_year_deaths)[names(dummy_year_deaths) == 'x'] <- 'totaldeaths'

dummy_year_deathrate <- aggregate(dfinal_new$suiciderate, by=list(year=dfinal_new$year), FUN=sum)
str(dummy_year_deathrate)
names(dummy_year_deathrate)[names(dummy_year_deathrate) == 'x'] <- 'deathrate'
dummy_year_deathrate$deathrate <- dummy_year_deathrate$deathrate/51

ggplot(dummy_year_deathrate) + 
  geom_bar(aes(x=year, y=deathrate),stat="identity", fill="cyan",colour="#006000") + 
  geom_line(aes(x=year, y=deathrate),stat="identity",color="red") +
  labs(title= "Suicide rate for years 2005-2020",
       x="Year",y="Suicide rate")


##Factorizing Variables
dfinal_new$state <- as.factor(dfinal_new$state)
dfinal_new$year <- as.factor(dfinal_new$year)
dfinal_new$urbanization<- as.factor(dfinal_new$urbanization)
dfinal_new$race <- as.factor(dfinal_new$race)
dfinal_new$agegroups <- as.factor(dfinal_new$agegroups)

dfinal_new$agegroups <- relevel(dfinal_new$agegroups,"5-14")
str(dfinal_new)

library(PerformanceAnalytics)
temp <- dfinal_new[, -c(1,2,3,4,5)]                 # Numeric variables only
chart.Correlation(temp)

##Created Dummy Variables for Visualization
dummy_gun_score <- aggregate(dfinal_new$gunscore, by=list(state=dfinal_new$state), FUN=mean)
names(dummy_gun_score)[names(dummy_gun_score) == 'x'] <- 'gunscore'
##gunscores for different states
ggplot(dummy_gun_score)+
  geom_bar(aes(x=reorder(state,+gunscore), y=gunscore),stat="identity", fill="cyan",colour="#006000")+
  theme(axis.text.x = element_text(angle = 90)) + labs(title= "Gun Score for States", x="State", y="Gun Score")

dummy_unemp_year <- aggregate(dfinal_new$unemprate, by=list(year=dfinal_new$year), FUN=mean)
names(dummy_unemp_year)[names(dummy_unemp_year) == 'x'] <- 'unemprate'

dummy_unemp_deaths <- merge(dummy_unemp_year,dummy_year_deathrate,by = c("year"))
str(dummy_unemp_deaths)
dummy_unemp_deaths$year <- as.factor(dummy_unemp_deaths$year)

ggplot(dummy_unemp_deaths, aes(x=year))+
  geom_bar(aes(y=unemprate, group=1),stat= "identity", fill="cyan",colour="#006000")+
  geom_line(aes(y=deathrate*1000, group=1),stat="identity",color="red")+scale_y_continuous(
    "Unemp Rate", sec.axis = sec_axis(~./1000,name = "Suicide Rate")) +
  labs(title= "Unemployment Rate vs Suicide Rate for years 2005-2020",
       x="Year") 


dummy_mortgage_year <- aggregate(dfinal_new$mortgagerate, by=list(year=dfinal_new$year), FUN=mean)
names(dummy_mortgage_year)[names(dummy_mortgage_year) == 'x'] <- 'mortgagerate'

dummy_mortgage_deaths <- merge(dummy_mortgage_year,dummy_year_deathrate,by = c("year"))
str(dummy_mortgage_deaths)

ggplot(dummy_mortgage_deaths)+ scale_y_continuous(
  "Mortgage Rate", 
  sec.axis = sec_axis(~./1000,name = "Suicide Rate")
) +
  geom_bar(aes(x=year, y=mortgagerate,group=1),stat="identity", fill="cyan",colour="#006000")+
  geom_line(aes(x=year, y=deathrate*1000,group=1),stat="identity",color="red")+
  labs(title= "Mortgage Rate vs Suicide Rate for years 2005-2020",
       x="Year") 

dummy_divorce_year <- aggregate(dfinal_new$divorcerate, by=list(year=dfinal_new$year), FUN=mean)
names(dummy_divorce_year)[names(dummy_divorce_year) == 'x'] <- 'divorcerate'

dummy_divorce_deathrate <- merge(dummy_divorce_year,dummy_year_deathrate,by = c("year"))
str(dummy_mortgage_deaths)

ggplot(dummy_divorce_deathrate)+ scale_y_continuous(
  "Divorce Rate", 
  sec.axis = sec_axis(~./1000,name = "Suicide Rate")
) +
  geom_bar(aes(x=year, y=divorcerate,group=1),stat="identity", fill="cyan",colour="#006000")+
  geom_line(aes(x=year, y=deathrate*1000,group=1),stat="identity",color="red")+
  labs(title= "Divorce Rate vs Suicide Rate for years 2005-2020",
       x="Year") 

dummy_tax_year <- aggregate(dfinal_new$incometax, by=list(year=dfinal_new$year), FUN=mean)
names(dummy_tax_year)[names(dummy_tax_year) == 'x'] <- 'incometax'

dummy_tax_deathrate <- merge(dummy_tax_year,dummy_year_deathrate,by = c("year"))
str(dummy_tax_deathrate)

ggplot(dummy_tax_deathrate)+ scale_y_continuous(
  "Income Tax Rate", 
  sec.axis = sec_axis(~./1000,name = "Suicide Rate")
) +
  geom_bar(aes(x=year, y=incometax,group=1),stat="identity", fill="green",colour="#006000")+
  geom_line(aes(x=year, y=deathrate*1000,group=1),stat="identity",color="red")+
  labs(title= "Income Tax vs Suicide Rate for years 2005-2020",
       x="Year") 

dummy_cpi_year <- aggregate(dfinal_new$cpi, by=list(year=dfinal_new$year), FUN=mean)
names(dummy_cpi_year)[names(dummy_cpi_year) == 'x'] <- 'cpi'

dummy_cpi_deathrate <- merge(dummy_cpi_year,dummy_year_deathrate,by = c("year"))
str(dummy_cpi_deathrate)

ggplot(dummy_cpi_deathrate)+ scale_y_continuous(
  "CPI", 
  sec.axis = sec_axis(~./100000,name = "Suicide Rate")
) +
  geom_bar(aes(x=year, y=cpi,group=1),stat="identity", fill="green",colour="#006000")+
  geom_line(aes(x=year, y=deathrate*100000,group=1),stat="identity",color="red")+
  labs(title= "CPI vs Suicide Rate for years 2005-2020",
       x="Year") 

#Models
attach(dfinal_new)
hist(deaths)
hist(suiciderate)
hist(log(suiciderate))
hist(unemprate)
hist(log(unemprate))
hist(incometax)
hist(log(incometax))
hist(minwage)
hist(log(minwage))
hist(cpi)
hist(log(cpi))
hist(mortgagerate)
hist(log(mortgagerate))
hist(divorcerate)
hist(log(divorcerate))


colSums(is.na(dfinal_new))

str(dfinal_new)

dfinal_new2 <- subset(dfinal_new,dfinal_new$year!=2020)
table(dfinal_new2$year)

attach(dfinal_new2)
library(lme4)
basemodel<- lmer(suiciderate ~ log(unemprate) + minwage 
                 + incometax + mortgagerate+ agegroups + urbanization + divorcerate +
                   race + mentalhealth + (1 | year/state), data=dfinal_new2, REML=FALSE)
summary(basemodel)
ranef(basemodel)
vcov(basemodel)

mixed <- lmer(suiciderate ~ population +log(unemprate)+ minwage + gunscore
              + incometax + mortgagerate+ agegroups + urbanization + divorcerate +
                race + mentalhealth + (1 | year/state), data=dfinal_new2, REML=FALSE)
summary(mixed)
ranef(mixed)

interaction <- lmer(suiciderate ~ population +log(unemprate)+ minwage
                    + incometax + mortgagerate+ agegroups + urbanization + divorcerate +
                      race + mentalhealth + gunscore +population * divorcerate +
                      population*mentalhealth+ population*log(unemprate) + (1 | year/state), 
                    data=dfinal_new2, REML=FALSE)
summary(interaction)
ranef(interaction)

library(stargazer)
stargazer(basemodel, mixed, interaction, single.row = TRUE,type = "text")