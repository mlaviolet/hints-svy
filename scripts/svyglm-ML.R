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

hints5_3 <- read_sas(unz(here("data-raw", "HINTS5_Cycle3_SAS_20210305.zip"),
                         "hints5_cycle3_public.sas7bdat")) %>% 
  # three-level response variable alcoholconditions_cancer
  mutate(across(starts_with("AlcoholConditions"), 
                ~ factor(.x, 1:3, c("Yes", "No", "Don't know")))) %>%
  # gender with female as referent,
  #   four-level race-Hispanic with White Non-Hispanic as referent
  mutate(genderc = factor(GenderC, 1:2, c("Male", "Female")),
         raceethn5 = factor(RaceEthn5, 1:4, 
                            c("White", "Black", "Hispanic", "Asian"))) %>% 
  # Yes-No categorical variables; make "No" the referent
  mutate(across(c(FamilyEverHadCancer, SeekCancerInfo),
                ~ factor(.x, 2:1, c("No", "Yes")))) %>% 
  # in continuous variables, make negative values NA
  mutate(across(c(Age, Education, IncomeRanges, AvgDrinksPerWeek,
                  ChanceGetCancerNoDX, FreqWorryCancerNoDx,
                  EverythingCauseCancer, PreventNotPossible,
                  TooManyRecommendations, OwnAbilityTakeCareHealth,
                  ConsiderFuture),
                ~ ifelse(.x < 0, NA, .x))) %>%
  # replicate weights survey object
  as_survey_rep(weights = "TG_all_FINWT0",
                repweights = paste0("TG_all_FINWT", 1:50),
                type = "JK1", scale = 49/50, mse = TRUE)

# full model
mult_log <- 
  svy_vglm(AlcoholConditions_Cancer ~ 
             GenderC + Age + Education + IncomeRanges + RaceEthn5 + 
             FamilyEverHadCancer + SeekCancerInfo + AvgDrinksPerWeek + 
             ChanceGetCancerNoDX + FreqWorryCancerNoDx + 
             EverythingCauseCancer + PreventNotPossible + 
             TooManyRecommendations + OwnAbilityTakeCareHealth + ConsiderFuture,
           multinomial(refLevel = "Yes"), 
         hints5_3)

# Warning messages:
#   1: In vglm.fitter(x = x, y = y, w = w, offset = offset, Xm2 = Xm2,  :
#      iterations terminated because half-step sizes are very small
#   2: In vglm.fitter(x = x, y = y, w = w, offset = offset, Xm2 = Xm2,  :
#      some quantities such as z, residuals, SEs may be inaccurate due to 
#      convergence at a half-step

