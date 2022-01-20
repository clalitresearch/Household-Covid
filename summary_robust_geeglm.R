summary.robust.geeglm <- function(object, level = 0.95, ...) {
  as.data.frame(coef(summary(object)), optional = TRUE) %>%
    rownames_to_column() %>%
    mutate(ci.lower=Estimate-qnorm((1+level)/2)*Std.err,
           ci.upper=Estimate+qnorm((1+level)/2)*Std.err,
           exp.estimate = exp(Estimate),
           exp.ci.lower = exp(ci.lower),
           exp.ci.upper = exp(ci.upper)) %>%
    select(-"Wald", -"Pr(>|W|)")
}
