
# Kiviniemi et al. (2021)
# Limitations in American adults' awareness of and beliefs about alcohol as a 
#   risk factor for cancer
# https://doi.org/10.1016/j.pmedr.2021.101433

library(tidyverse)
library(haven)
library(survey)
library(here)
library(svyVGAM)
library(srvyr)


hints5_3 <- read_sas(unz(here("data-raw", "HINTS5_Cycle3_SAS_20210305.zip"),
                         "hints5_cycle3_public.sas7bdat")) %>% 
  mutate(across(starts_with("AlcoholConditions"), 
              ~ factor(.x, 1:3, c("Yes", "No", "Don't know")))) %>% 
  # exclude "Don't know"
  mutate(across(starts_with("AlcoholConditions"), ~ .x, .names = "{.col}_certain")) %>% 
  mutate(across(ends_with("_certain"), ~ factor(.x, c("Yes", "No")))) %>% 
  # collapse "Yes" and "No"
  mutate(across(starts_with("AlcoholConditions"), 
                ~ fct_collapse(.x, Certain = c("Yes", "No")),
                .names = "{.col}_uncertain")) %>% 
  # construct replicate weights survey object
  as_survey_rep(weights = "TG_all_FINWT0",
                repweights = paste0("TG_all_FINWT", 1:50),
                type = "JK1", scale = 49/50, mse = TRUE)

# "... there was significantly more uncertainty for the cancer link with 
#    alcohol than for any of the other health conditions (X2(1,49) all > 314.85, 
#   all p < .001).
svychisq(~ AlcoholConditions_Cancer_uncertain + AlcoholConditions_LiverDisease_uncertain,
         hints5_3)
# Liver disease: F = 314.85, ndf = 1, ddf = 49, p-value < 2.2e-16
# Heart disease: F = 518.42, ndf = 1, ddf = 49, p-value < 2.2e-16
# Diabetes: F = 512.29, ndf = 1, ddf = 49, p-value < 2.2e-16

# "...among those participants who expressed a belief, there was significantly 
#  more disbelief that alcohol causes cancer than disbelief that it causes the
#  other three health conditions; (X2 (1,49) all > 124.1, all p < .001)"
svychisq(~ AlcoholConditions_Cancer_certain + AlcoholConditions_Diabetes_certain,
         hints5_3)
# Diabetes: F = 124.11, ndf = 1, ddf = 49, p-value = 4.947e-15  
# Heart disease: F = 161.2, ndf = 1, ddf = 49, p-value < 2.2e-16
# Liver disease: F = 228.31, ndf = 1, ddf = 49, p-value < 2.2e-16

# relationship between F and chi-square: with one numerator degree of
#   freedom, F and chi-square are the same
# https://www.stata.com/support/faqs/statistics/chi-squared-and-f-distributions/

# Table 1, select results
# Is alcohol a risk factor? 
# All respondents
hints5_3 %>% 
  filter(!is.na(AlcoholConditions_Cancer)) %>% 
  group_by(AlcoholConditions_Cancer) %>% 
  summarize(pct_cancer = survey_mean(na.rm = TRUE, vartype = "ci"))
# differ slightly in 3rd decimal place; only results that differs from paper

# Is alcohol a risk factor? 
# Those espousing a belief (excluding those responding don't know)
hints5_3 %>% 
  filter(AlcoholConditions_Cancer != "Don't know") %>% 
  group_by(AlcoholConditions_Cancer) %>% 
  summarize(pct_cancer = survey_mean(na.rm = TRUE, vartype = "ci"))
# matches perfectly


# multinomial logistic regression -----------------------------------------
# https://cran.r-project.org/web/packages/svyVGAM/index.html
# https://tech.popdata.org/pma-data-hub/posts/2021-08-15-covid-analysis
# https://stats.oarc.ucla.edu/sas/output/multinomial-logistic-regression
# https://stats.oarc.ucla.edu/r/dae/multinomial-logistic-regression/

# ice_cream <- foreign::read.dta("https://stats.idre.ucla.edu/stat/stata/output/mlogit.dta")

# covariates, all quantitative except as indicated
# gender            genderc (categorical, 1 = M, 2 = F)
# age               age
# education level   education
# income level      incomeranges
# race/Hispanic     raceethn5
#                     1 Non-Hispanic White 
#                     2 Non-Hispanic Black or African American 
#                     3 Hispanic 
#                     4 Non-Hispanic Asian
#                     5 Non-Hispanic Other (count as NA)
# family history of cancer   familyeverhadcancer (categorical, 1 = Yes, 2 = No, 
#                              4 = Not sure, apparently omitted)
# ever sought cancer info    seekcancerinfo (categorical, 1 = Yes, 2 = No)
# average drinks per week    avgdrinksperweek
# absolute risk              chancegetcancernodx
#                              1 = Strongly agree 
#                              2 = Somewhat agree 
#                              3 = Somewhat disagree 
#                              4 = Strongly disagree
# worry                      freqworrycancernodx
#                              1 Not at all
#                              2 Slightly
#                              3 Somewhat
#                              4 Moderately
#                              5 Extremely
# everything causes cancer   everythingcausecancer (same as ChanceGetCancerNoDX)
# cancer can't be prevented  preventnotpossible (same as ChanceGetCancerNoDX)
# too many recommendations   toomanyrecommendations (same as ChanceGetCancerNoDX)
# ability to care for own health  ownabilitytakecarehealth
#                                   1 = Completely confident
#                                   2 = Very confident
#                                   3 = Somewhat confident
#                                   4 = A little confident
#                                   5 = Not confident at all
# consideration of future consequences considerfuture (same as ChanceGetCancerNoDX)

hints5_3 <- hints5_3 %>% 
  mutate(GenderC = factor(GenderC, 2:1, c("Female", "Male"))) %>% 
  mutate(across(c(FamilyEverHadCancer, SeekCancerInfo),
                ~ factor(.x, 1:2, c("Yes", "No")))) %>% 
  mutate(RaceEthn5 = factor(RaceEthn5, 1:4, 
                            c("White", "Black", "Hispanic", "Asian"))) %>% 
  mutate(across(c(Age, Education, IncomeRanges, AvgDrinksPerWeek,
                  ChanceGetCancerNoDX, FreqWorryCancerNoDx,
                  EverythingCauseCancer, PreventNotPossible,
                  TooManyRecommendations, OwnAbilityTakeCareHealth,
                  ConsiderFuture),
                ~ ifelse(.x < 0, NA, .x)))

svy_vglm(
  formula = AlcoholConditions_Cancer ~ GenderC+ Age,
  family = multinomial(refLevel = "Yes"), design = hints5_3)

svy_vglm(
  formula = AlcoholConditions_Cancer ~ 
    GenderC + FamilyEverHadCancer + SeekCancerInfo + RaceEthn5 + Age + 
    Education + IncomeRanges + AvgDrinksPerWeek + ChanceGetCancerNoDX + 
    FreqWorryCancerNoDx + EverythingCauseCancer + PreventNotPossible + 
    TooManyRecommendations + OwnAbilityTakeCareHealth + ConsiderFuture,
  family = multinomial(refLevel = "Yes"), design = hints5_3)


