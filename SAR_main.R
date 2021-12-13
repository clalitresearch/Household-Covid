library(tidyverse)
library(broom)

# Get Data
source("get_data_sar.R")
indirect_analysis_data <- get_data_sar(table_name = "Covid19Households_sar_households")

# Factorize
data <- data %>%
  mutate(across(c(hh_first_covid_city_type_6, hh_first_covid_district_code, 
                  hh_first_covid_sector), 
                factor))

# Fit model
model <- glm(sw_child_secondary_infection_in_hh ~.,
             family=binomial(link='logit'),
             data=data)

# Get results
res <- tidy(model, exponentiate = TRUE, conf.int= TRUE)
res[,c('term', 'estimate', 'conf.low', 'conf.high')] %>% 
  filter(term == 'index_fully_vacc1') %>% 
  as.data.frame()
