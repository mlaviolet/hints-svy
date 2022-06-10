## ----setup, include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
options(digits = 4)


## ----load-pkgs, echo=FALSE, message=FALSE--------------------------------------------
library(broom)
library(broom.helpers)
library(dplyr)
library(haven)
library(purrr)
library(srvyr)
library(survey)
library(tidyr)
library(kableExtra)
library(here)
library(flextable)



## ----show-pkgs, eval=FALSE-----------------------------------------------------------
## library(tidyverse)
## library(broom)
## library(haven)
## library(srvyr)
## library(survey)
## library(here)
## library(kableExtra)


## ----recodes-------------------------------------------------------------------------
# pp. 8-10
# education levels
edu_lbl <- c("Less than high school",
             "12 years or completed high school",
             "Some college",
             "College graduate or higher")
# general health status
health_lbl <- c("Excellent", "Very good", "Good", "Fair", "Poor")
# convenience function to show percentages to four places like SAS
percent <- function(x, decimals = 4) round(100 * x, decimals)
# import SAS data set directly from .zip file
hints5_4 <- read_sas(
  unz(
    here("data", "raw", "HINTS5_Cycle4_SAS_20210309.zip"),
                         "hints5_cycle4_public.sas7bdat")
  ) %>% 
  mutate(# code BirthGender as binary male-female
    gender = factor(BirthGender, 1:2, c("Male", "Female")),
         # recode negative GeneralHealth values to missing
         GeneralHealth = if_else(GeneralHealth < 0, NA_real_, GeneralHealth),
         # collapse education to four levels
         edu = case_when(Education %in% 1:2 ~ 1,
                         Education == 3     ~ 2,
                         Education %in% 4:5 ~ 3,
                         Education %in% 6:7 ~ 4,
                         TRUE ~ NA_real_)) %>% 
  # change edu from numeric to factor
  mutate(edu = factor(edu, levels = 1:4, labels = edu_lbl),
         # "No" must be the referent level of SeekCancerInfo to model the 
         #   probability of "Yes". By default the first level of a factor is 
         #   the referent level; reversing the order of levels so that
         #   "No" is the referent.
         SeekCancerInfo = factor(SeekCancerInfo, levels = 2:1, 
                                 labels = c("No", "Yes")))


## ----survey_rep, warning = FALSE-----------------------------------------------------
# construct replicate weights survey object
hints5_4_rep <- as_survey_rep(hints5_4, weights = "PERSON_FINWT0",
                              repweights = paste0("PERSON_FINWT", 1:50),
                              type = "JK1", scale = 49/50, mse = TRUE)



## ----table_1, warning=FALSE----------------------------------------------------------
# na.rm argument being ignored; NA comes up as separate level
# bug?
# need to add line to filter out missings to get correct results
# pp. 10-11

tbl_1 <- hints5_4_rep %>% 
  # remove missings in either table variable to get correct unweighted 
  #   sample sizes
  filter(!is.na(edu), !is.na(gender)) %>% 
  # compute unweighted sample sizes by education level and gender
  group_by(edu, gender) %>% 
  # compute unweighted sample sizes and weighted percentage with standard
  #   errors and confidence intervals
  summarize(n = unweighted(n()),
            pct = survey_mean(na.rm = TRUE, vartype = c("se", "ci"))) %>% 
  drop_na() %>% 
  mutate_at(vars(starts_with("pct")), percent)

tbl_1_ft <- flextable(tbl_1)
tbl_1_ft
# tbl_1 %>% 
#   kable() %>% 
#   kable_styling()


## ----chi_sq_rep----------------------------------------------------------------------
svychisq(~ edu + gender, hints5_4_rep, statistic = "Wald") %>% 
  tidy() %>% 
  kable() %>% 
  kable_styling()

svychisq(~ edu + gender, hints5_4_rep, statistic = "adjWald") %>%
  tidy() %>% 
  kable() %>% 
  kable_styling()




## ----logistic------------------------------------------------------------------------
model03 <- svyglm(SeekCancerInfo ~ gender + edu, hints5_4_rep, 
                  family = quasibinomial) %>% 
  tidy_and_attach(exp = TRUE) %>% 
  tidy_remove_intercept() %>% 
  tidy_add_reference_rows() %>% 
  tidy_add_term_labels() %>% 
  # tidy_add_variable_labels() %>% 
  select(label, or = estimate, p.value, or_low = conf.low, 
                        or_upp = conf.high) %>% 
  mutate(p.value = round(p.value, digits = 3))


## ----test_terms----------------------------------------------------------------------
regTermTest(model03, ~ gender, df = 49)
regTermTest(model03, ~ edu, df = 49)

svyglm(SeekCancerInfo ~ gender + edu, hints5_4_rep, 
       family = quasibinomial(log), start = c(-0.5, 0, 0, 0, 0)) %>% 
  tidy_and_attach(exp = TRUE) %>% 
  tidy_remove_intercept() %>% 
  # tidy_add_reference_rows() %>% 
  tidy_add_term_labels() %>% 
  select(label, rr = estimate, p.value, rr_low = conf.low, 
         rr_upp = conf.high) %>% 
  mutate(p.value = round(p.value, digits = 3))




## ----odds_ratios---------------------------------------------------------------------
# odds ratios
tidy(model03, conf.int = TRUE, exponentiate = TRUE, ddf = 49) %>% 
  kable() %>% 
  kable_styling()


## ----lin_model-----------------------------------------------------------------------
# pp. 13-14
model04 <- svyglm(GeneralHealth ~ gender + edu, hints5_4_rep)
tidy(model04) %>% 
  kable() %>% 
  kable_styling()


## ----chi_sq_lin----------------------------------------------------------------------
regTermTest(model04, ~ gender + edu)
regTermTest(model04, ~ gender)
regTermTest(model04, ~ edu)



## ----taylor, warning=FALSE-----------------------------------------------------------
# pp. 14-15
hints5_4_lin <- 
  as_survey_design(hints5_4, ids = VAR_CLUSTER, strata = VAR_STRATUM, 
                   weight = PERSON_FINWT0, nest = TRUE)
hints5_4_lin %>% 
  filter(!is.na(edu), !is.na(gender)) %>% 
  group_by(edu, gender) %>% 
  summarize(n = unweighted(n()),
            pct = survey_mean(na.rm = TRUE, vartype = c("se", "ci"))) %>% 
  drop_na() %>% 
  mutate_at(vars(starts_with("pct")), percent) %>% 
  kable() %>% 
  kable_styling()



## ----chi_sq_taylor-------------------------------------------------------------------
svychisq(~ edu + gender, hints5_4_lin, statistic = "Wald") %>% 
  tidy() %>% 
  kable() %>% 
  kable_styling()

svychisq(~ edu + gender, hints5_4_lin, statistic = "adjWald") %>% 
  tidy() %>% 
  kable() %>% 
  kable_styling()

   
# RESUME HERE

