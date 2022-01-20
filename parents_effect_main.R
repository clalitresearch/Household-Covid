
# Get Data
source("get_parents_data.R")
indirect_analysis_data <- get_data_parents(table_name = "Covid19Households_parent_weeks")

# Get indirect effect for categorical/nominal exposure
source("get_results.R")
start_time <- print(Sys.time())
results_nom <- get_results(indirect_analysis_data, exposure="fully_vacc",
                                      children=FALSE, nominal=TRUE, parents=TRUE)
print(Sys.time() - start_time)