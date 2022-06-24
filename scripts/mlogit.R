# Michael Laviolette, PhD MPH
# statman54@gmail.com
# Concord, NH

# Kiviniemi et al. (2021), Limitations in American adults' awareness of and 
#   beliefs about alcohol as a risk factor for cancer
# https://doi.org/10.1016/j.pmedr.2021.101433
# Replicating results in Table 2, multinomial logistic regression

library(tidyverse)
library(haven)
library(srvyr)
library(svyVGAM)
library(here)

# data from HINTS survey conducted by US National Cancer Institute
# https://hints.cancer.gov
# download.file("https://hints.cancer.gov/dataset/HINTS5_Cycle3_Stata_20210305.zip", 
#               "hints5_3_stata.zip")

hints5_3 <- read_stata(unz(here("data-raw", "HINTS5_Cycle3_Stata_20210305.zip"),
                           "hints5_cycle3_public.dta")) %>% 
  # three-level response variable alcoholconditions_cancer
  mutate(across(starts_with("alcoholconditions"), 
                ~ factor(.x, 1:3, c("Yes", "No", "Don't know")))) %>%
  # gender with female as referent,
  #   four-level race-Hispanic with White Non-Hispanic as referent
  mutate(genderc = factor(genderc, 1:2, c("Male", "Female")),
         raceethn5 = factor(raceethn5, 1:4, 
                            c("White", "Black", "Hispanic", "Asian"))) %>% 
  # Yes-No categorical variables; make "No" the referent
  mutate(across(c(familyeverhadcancer, seekcancerinfo),
                ~ factor(.x, 2:1, c("No", "Yes")))) %>% 
  # in continuous variables, make negative values NA
  mutate(across(c(age, education, incomeranges, avgdrinksperweek,
                  chancegetcancernodx, freqworrycancernodx,
                  everythingcausecancer, preventnotpossible,
                  toomanyrecommendations, ownabilitytakecarehealth,
                  considerfuture),
                ~ ifelse(.x < 0, NA, .x))) %>%
  # replicate weights survey object
  as_survey_rep(weights = "tg_all_finwt0",
                repweights = paste0("tg_all_finwt", 1:50),
                type = "JK1", scale = 49/50, mse = TRUE)

# simple model
# svy_vglm(alcoholconditions_cancer ~ genderc + age,
#          multinomial(refLevel = "Yes"), 
#          hints5_3)

select(hints5_3$variables, alcoholconditions_cancer, 
       genderc, age, education, incomeranges, raceethn5, 
       familyeverhadcancer, seekcancerinfo, avgdrinksperweek, 
       chancegetcancernodx, freqworrycancernodx, 
       everythingcausecancer, preventnotpossible, 
       toomanyrecommendations, ownabilitytakecarehealth, considerfuture) %>% 
  str()

# full model
mult_log <- 
  svy_vglm(alcoholconditions_cancer ~ 
             genderc + age + education + incomeranges + raceethn5 + 
             familyeverhadcancer + seekcancerinfo + avgdrinksperweek + 
             chancegetcancernodx + freqworrycancernodx + 
             everythingcausecancer + preventnotpossible + 
             toomanyrecommendations + ownabilitytakecarehealth + considerfuture,
           multinomial(refLevel = "Yes"), 
         hints5_3)

# from https://tech.popdata.org/pma-data-hub/posts/2021-08-15-covid-analysis
tidy.svyVGAM <- function(
    x, 
    conf.int = FALSE, 
    conf.level = 0.95,
    exponentiate = FALSE, 
    ...
    ) {
  # Replace `summary(x)$coefficients` with `summary(x)$coeftable`
  ret <- as_tibble(summary(x)$coeftable, rownames = "term")
  
  # All of this stays the same:
  colnames(ret) <- c("term", "estimate", "std.error", "statistic", "p.value")
  coefs <- tibble::enframe(stats::coef(x), name = "term", value = "estimate")
  ret <- left_join(coefs, ret, by = c("term", "estimate"))
  if (conf.int) {
    ci <- broom:::broom_confint_terms(x, level = conf.level, ...)
    ret <- dplyr::left_join(ret, ci, by = "term")
    }
  if (exponentiate){ret <- broom:::exponentiate(ret)
  }
  
  # This part only works for the multinomial case, and only if your covariates
  # have no ":" in their names - NOT FOR GENERAL USE
  ret %>% 
    separate(term, into = c("term", "y.level"), sep = ":") %>% 
    arrange(y.level) %>% 
    relocate(y.level, .before = term)
  }

mult_log_tidy <- tidy.svyVGAM(mult_log, conf.int = TRUE, 
                              exponentiate = TRUE) %>% 
  as_tibble() %>% 
  relocate(term, estimate, conf.low, conf.high) %>% 
  filter(term != "(Intercept)")

save(mult_log, mult_log_tidy, file = here("output", "mult_log.Rdata"))
openxlsx::write.xlsx(mult_log_tidy, here("output", "mult_log.xlsx"))

