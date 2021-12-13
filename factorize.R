factorize <- function(.data) {
  (.data %>%
     mutate(across(c(week_start, household, age_group, 
                     city, city_type_28, city_type_7, city_type_6, district_code, 
                     sector), 
                   factor))
  )
}
