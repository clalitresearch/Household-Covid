get_vars <- function(data, exposure_var, children, children_under_12=FALSE, 
                     no_age_group=FALSE, booster=FALSE, parents=FALSE, parents_booster=FALSE) {
  vars <- c(exposure_var,
            "hh_size", "week_start", "male", "age_group", "district_code", "city_type_6",
            "sector", "ses", "pregnant", "adult_smoker", "obese", "active_malignancy", 
            "diabetes", "cvd_history", "htn_history", "cpd_history",
            "hh_n_males", "hh_n_adult_smokers", "hh_n_obese", "hh_pregnant",
            "hh_n_cvd", "hh_n_cpd", "hh_n_dm", "hh_n_HTN", "hh_n_malig",
            "hh_n_age_02", "hh_n_age_36", "hh_n_age_712", "hh_n_age_1315",
            "hh_n_age_1618", "hh_n_age_1940", "hh_n_age_4160", "hh_n_age_6180", 
            "prevalence_02", "prevalence_36", "prevalence_712",
            "prevalence_1315", "prevalence_2564", "prevalence_6580")
  
  if (! "hh_n_age_81" %in% colnames(data) || nrow(data %>% filter(hh_n_age_81 > 0)) == 0) { # No one over 80 in the house
    vars <- vars[! vars %in% c("hh_n_age_6180")]}
  if (! "hh_n_age_6180" %in% colnames(data) || nrow(data %>% filter(hh_n_age_6180 > 0)) == 0) { # No one 61-80 in the house
    vars <- vars[! vars %in% c("hh_n_age_4160")]}
  if (nrow(data %>% filter(pregnant == 1)) == 0) { # No one is pregnant
    vars <- vars[! vars %in% c("pregnant")]}
  if (children) { # children data
    vars <- vars[! vars %in% c("adult_smoker", "pregnant", "hh_n_age_1618", "hh_n_age_1315")]} # so that sum of hh_n_age_... (children) is not equal to hh_size -2 
  if (children_under_12) {
    vars <- vars[! vars %in% c("hh_n_age_712")]} # so that sum of hh_n_age_... (children) is not equal to hh_size -2 
  if (no_age_group) {
    vars <- vars[! vars %in% c("age_group")]}
  if (booster) {
    vars <- vars[! vars %in% c("hh_n_age_712", "hh_n_age_1315")] # Shouldn't add 7-11 (as above)
    vars <- c(vars, "hh_min_months_from_dose2", "hh_max_months_from_dose2")}
  if (parents) {
    vars <- vars[! vars %in% c("hh_n_age_1618", "hh_n_age_1315")]
    vars <- c(vars, "hh_n_fully_vacc")}
  if (parents_booster) {
    vars <- vars[! vars %in% c("hh_n_age_1618", "hh_n_age_1315", "hh_n_age_712")]
    vars <- c(vars, "hh_min_months_from_dose2", "hh_max_months_from_dose2")
    vars <- c(vars, "hh_n_booster_fully_vacc")}
  
  return(vars)
}