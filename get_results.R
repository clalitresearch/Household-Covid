library(geepack)
source("~/Covid19_houshold_transmission/R/factorize.R")
source("~/Covid19_houshold_transmission/R/summary_robust_geeglm.R")
source("~/Covid19_houshold_transmission/R/get_vars.R")

get_results <- function(unfactorized_data, exposure="hh_n_non_immune", 
                        children=FALSE, children_under_12=FALSE, nominal=FALSE, 
                        booster=FALSE, parents=FALSE, parents_booster=FALSE) {
  
  data <- unfactorized_data %>% 
    factorize()
  
  exposure_var <- exposure
  if (nominal) {
    exposure_var <- paste(exposure, "nominal", sep="_")
    data[exposure_var] <- as.factor(data[[exposure]])
  }
  
  vars <- get_vars(data, exposure_var, children, children_under_12, 
                   booster=booster, parents=parents, parents_booster=parents_booster)
  
  data <- data %>% arrange(household) # geeglm expects the data to be sorted by the id variable
  
  geefit <- geeglm(as.formula(paste("infected ~", paste(vars, collapse="+"))),
                   id=household, data=data,
                   family=poisson, corstr = "independence")
  
  irr <- summary.robust.geeglm(geefit) %>%
    filter(str_detect(rowname, exposure_var)) %>%
    select(contains('row') | contains('exp'))
  person_weeks <- nrow(data)
  model <- geefit
  model_vars <- vars
  
  results <- list("Model"=model, "VarList"=model_vars,"IRR"=irr,"PersonWeeks"=person_weeks)
  
  return(results)
}