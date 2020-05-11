covid <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-06-2020.csv", header = TRUE)
popDensity_byState <- read.csv('data.csv', header = TRUE)
library(dplyr)
library(magrittr)
# Filter to only include US, couldn't find good population densities for everywhere else so doing this was easier

covid <- covid %>% 
  filter(Country_Region == 'US') %>% 
  rename(State = Province_State, County = Admin2) %>% 
  left_join(popDensity_byState, by = "State") %>% 
  rename(State_popDensity = Density) %>% 
  select(-Recovered, -Pop, -LandArea, -FIPS, -Country_Region, -Last_Update)

write.csv(na.omit(covid), "usCovid_byCounty.csv")

covid <- na.omit(covid)
