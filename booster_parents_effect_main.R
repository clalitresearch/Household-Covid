
# Get Data
source("get_booster_data_parents.R")
indirect_analysis_data <- get_data_parents(table_name = "Covid19Households_booster_parent_weeks")

# Get indirect effect for categorical/nominal exposure
source("get_results.R")
start_time <- print(Sys.time())
results_nom <- get_results(indirect_analysis_data, exposure="booster_fully_vacc",
                                      children=FALSE, nominal=TRUE, parents_booster=TRUE)
print(Sys.time() - start_time)