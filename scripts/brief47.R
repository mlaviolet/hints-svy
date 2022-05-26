# Reproducing results from HINTS brief 47
# https://hints.cancer.gov/docs/Briefs/HINTS_Brief_47.pdf

library(dplyr)
library(haven)
library(srvyr)
library(survey)
library(here)
library(forcats)

# Alcohol consumption by American adults (2020) 
hints5_4 <- read_sas(unz(here("data", "raw", "HINTS5_Cycle4_SAS_20210309.zip"),
                         "hints5_cycle4_public.sas7bdat")) %>% 
  mutate(AvgDrinksPerWeek = 
           cut(AvgDrinksPerWeek, c(0, 1, 11, 21, 31, Inf), right = FALSE,
               labels = c("0", "1-10", "11-20", "21-30", "31+"))) %>% 
  # construct replicate weights survey object
  as_survey_rep(weights = "PERSON_FINWT0",
                repweights = paste0("PERSON_FINWT", 1:50),
                type = "JK1", scale = 49/50, mse = TRUE)

hints5_4 %>% 
  group_by(AvgDrinksPerWeek) %>% 
  summarize(pct = survey_mean(vartype = "ci")) %>% 
  mutate(across(starts_with("pct"), ~ 100 * .x))
# matches brief

# Percentage of Americans who think cancer can result from drinking too much
#   alcohol (2019)

factorAlcohol <- function(x) factor(x, 1:3, c("Yes", "No", "Don't know"))

# make all alcohol questions about relations to other conditions into factors
hints5_3 <- read_sas(unz(here("data", "raw", "HINTS5_Cycle3_SAS_03112020.zip"),
                         "hints5_cycle3_public.sas7bdat")) %>% 
  mutate(across(starts_with("AlcoholConditions"), factorAlcohol)) %>% 
  # mutate(AlcoholConditions_Cancer = factorAlcohol(AlcoholConditions_Cancer))
  # mutate(AlcoholConditions_Cancer = factor(AlcoholConditions_Cancer, 1:3,
  #                                          c("Yes", "No", "Don't know"))) %>% 
  # assuming no differences between modalities;
  as_survey_rep(weights = "TG_all_FINWT0",
                repweights = paste0("TG_all_FINWT", 1:50),
                type = "JK1", scale = 49/50, mse = TRUE)

hints5_3 %>% 
  group_by(AlcoholConditions_Cancer) %>% 
  summarize(pct = survey_mean(vartype = "ci")) %>% 
  mutate(across(starts_with("pct"), ~ 100 * .x))
# matches brief

# Kiviniemi et al. (2021)
# Limitations in American adults’ awareness of and beliefs about alcohol as a 
#   risk factor for cancer
# https://doi.org/10.1016/j.pmedr.2021.101433

# Table 1, select results
# cancer risk, all respondents
hints5_3 %>% 
  summarize(pct_cancer = survey_mean(AlcoholConditions_Cancer == "Yes",
                                     na.rm = TRUE, vartype = "ci"))
# cancer risk, excluding Don't Know
hints5_3 %>% 
  filter(AlcoholConditions_Cancer != "Don't know") %>% 
  summarize(pct_cancer = survey_mean(AlcoholConditions_Cancer == "Yes",
                                     na.rm = TRUE, vartype = "ci"))


