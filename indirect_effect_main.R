
# Get Data
source("get_data_children.R")
indirect_analysis_data <- get_data_children(table_name = "Covid19Households_child_weeks")

# Get indirect effect for categorical/nominal exposure
source("get_results.R")
start_time <- print(Sys.time())
results_nom <- get_results(indirect_analysis_data, exposure="hh_n_fully_vacc",
                                      children=TRUE, nominal=TRUE)
print(Sys.time() - start_time)