
# Kiviniemi et al. (2021)
# Limitations in American adults' awareness of and beliefs about alcohol as a 
#   risk factor for cancer
# https://doi.org/10.1016/j.pmedr.2021.101433

library(dplyr)
library(haven)
library(srvyr)
library(survey)
library(here)
library(forcats)

hints5_3 <- read_stata(unz(here("data-raw", "HINTS5_Cycle3_Stata_20210305.zip"),
                         "hints5_cycle3_public.dta")) %>% 
  mutate(across(starts_with("alcoholconditions"), 
              ~ factor(.x, 1:3, c("Yes", "No", "Don't know")))) %>% 
  # exclude "Don't know"
  mutate(across(starts_with("alcoholconditions"), ~ .x, .names = "{.col}_certain")) %>% 
  mutate(across(ends_with("_certain"), ~ factor(.x, c("Yes", "No")))) %>% 
  # collapse "Yes" and "No"
  mutate(across(starts_with("alcoholconditions"), 
                ~ fct_collapse(.x, Certain = c("Yes", "No")),
                .names = "{.col}_uncertain")) %>% 
  # construct replicate weights survey object
  as_survey_rep(weights = "tg_all_finwt0",
                repweights = paste0("tg_all_finwt", 1:50),
                type = "JK1", scale = 49/50, mse = TRUE)

# "... there was significantly more uncertainty for the cancer link with 
#    alcohol than for any of the other health conditions (X2(1,49) all > 314.85, 
#   all p < .001).
svychisq(~ alcoholconditions_cancer_uncertain + alcoholconditions_liverdisease_uncertain,
         hints5_3)
# Liver disease: F = 314.85, ndf = 1, ddf = 49, p-value < 2.2e-16
# Heart disease: F = 518.42, ndf = 1, ddf = 49, p-value < 2.2e-16
# Diabetes: F = 512.29, ndf = 1, ddf = 49, p-value < 2.2e-16

# "...among those participants who expressed a belief, there was significantly 
#  more disbelief that alcohol causes cancer than disbelief that it causes the
#  other three health conditions; (X2 (1,49) all > 124.1, all p < .001)"
svychisq(~ alcoholconditions_cancer_certain + alcoholconditions_diabetes_certain,
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
  filter(!is.na(alcoholconditions_cancer)) %>% 
  group_by(alcoholconditions_cancer) %>% 
  summarize(pct_cancer = survey_mean(na.rm = TRUE, vartype = "ci"))
# differ slightly in 3rd decimal place; only results that differs from paper

# Is alcohol a risk factor? 
# Those espousing a belief (excluding those responding don't know)
hints5_3 %>% 
  filter(alcoholconditions_cancer != "Don't know") %>% 
  group_by(alcoholconditions_cancer) %>% 
  summarize(pct_cancer = survey_mean(na.rm = TRUE, vartype = "ci"))
# matches perfectly


# multinomial logistic regression
# https://cran.r-project.org/web/packages/svyVGAM/index.html
# https://tech.popdata.org/pma-data-hub/posts/2021-08-15-covid-analysis
# https://stats.oarc.ucla.edu/sas/output/multinomial-logistic-regression
# https://stats.oarc.ucla.edu/r/dae/multinomial-logistic-regression/

# ice_cream <- foreign::read.dta("https://stats.idre.ucla.edu/stat/stata/output/mlogit.dta")

# covariates, all quantitative except as indicated
# gender            genderc (categorical, 1 = M, 2 = F)
# age               age
# education level   education
# income level      incomeranges)
# race/Hispanic              raceethn
#                              1 Hispanic 
#                              2 Non-Hispanic White
#                              3 Non-Hispanic Black or African American
#                              4 Non-Hispanic American Indian or Alaska Native
#                              5 Non-Hispanic Asian 
#                              6 Non-Hispanic Native Hawaiian or other Pacific Islander
#                              7 Non-Hispanic Multiple Races Mentioned
# family history of cancer   familyeverhadcancer (categorical, 1 = Yes, 2 = No, 
#                              4 = Not sure, apparently omitted)
# ever sought cancer info    seekcancerinfo (categorical, 1 = Yes, 2 = No)
# average drinks per week    avgdrinksperweek
# absolute risk              chancegetcancernodx
#                              1 = Strongly agree 
#                              2 = Somewhat agree 
#                              3 = Somewhat disagree 
#                              4 = Strongly disagree
# worry                      freqworrycancernoDx
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



         
       
     
 

