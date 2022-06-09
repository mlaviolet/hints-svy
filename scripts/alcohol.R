
# Kiviniemi et al. (2021)
# Limitations in American adults' awareness of and beliefs about alcohol as a 
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

hints5_3 %>% 
  mutate(HaveAlcoholBelief = 
           fct_collapse(AlcoholConditions_Cancer,
                        `Alcohol` = c("Yes", "No")),
         HaveDiabetesBelief = 
           fct_collapse(AlcoholConditions_Diabetes,
                        `Diabetes` = c("Yes", "No"))) %>% 
  svychisq(~ HaveAlcoholBelief + HaveDiabetesBelief, . )

# AlcoholConditions_Cancer, AlcoholConditions_Diabetes
# AlcoholConditions_HeartDisease, AlcoholConditions_LiverDisease

# Section 6.1
# ... among those participants who expressed a belief, there was significantly 
#   more disbelief that alcohol causes cancer than disbelief that it causes the 
#   other three health conditions; (X2 (1,49) all > 124.1, all p < .001).
# remove "Don't know" from all four variables, test alcohol against each of 
#   the other three
# DO THIS AS A FUNCTION
hints5_3 %>% 
  filter(AlcoholConditions_Cancer != "Don't know",
         AlcoholConditions_LiverDisease != "Don't know") %>% 
  mutate(AlcoholConditions_Cancer = fct_drop(AlcoholConditions_Cancer),
         AlcoholConditions_LiverDisease = 
           fct_drop(AlcoholConditions_LiverDisease)) %>%
  svychisq(~ AlcoholConditions_Cancer + AlcoholConditions_LiverDisease, .)
# Diabetes: F = 124.11, ndf = 1, ddf = 49, p-value = 4.947e-15  
# Heart disease: F = 161.2, ndf = 1, ddf = 49, p-value < 2.2e-16
# Liver disease: F = 228.31, ndf = 1, ddf = 49, p-value < 2.2e-16

# "... there was significantly more uncertainty for the cancer link with 
#    alcohol than for any of the other health conditions (X2(1,49) all > 314.85, 
#   all p < .001).
# collapse Yes and No to make 2 x 2 tables
collapseToBinary <- function(x) {
  fct_collapse(x, Certain = c("Yes", "No"))
  }
  
# chk1 <- collapseToBinary(hints5_3$variables$AlcoholConditions_Cancer)

hints5_3 <- hints5_3 %>% 
  mutate(across(starts_with("AlcoholConditions"),
         collapseToBinary, .names = "{.col}_binary"))

svychisq(~ AlcoholConditions_Cancer_binary + 
           AlcoholConditions_LiverDisease_binary,
         hints5_3)
# Liver disease: F = 314.85, ndf = 1, ddf = 49, p-value < 2.2e-16
# Heart disease: F = 518.42, ndf = 1, ddf = 49, p-value < 2.2e-16
# Diabetes: F = 512.29, ndf = 1, ddf = 49, p-value < 2.2e-16

# relationship between F and chi-square: with one numerator degree of
#   freedom, F and chi-square are the same
# https://www.stata.com/support/faqs/statistics/chi-squared-and-f-distributions/

# multinomial logistic regression
# https://cran.r-project.org/web/packages/svyVGAM/index.html
# https://tech.popdata.org/pma-data-hub/posts/2021-08-15-covid-analysis
# https://stats.oarc.ucla.edu/sas/output/multinomial-logistic-regression
# https://stats.oarc.ucla.edu/r/dae/multinomial-logistic-regression/

ice_cream <- foreign::read.dta("https://stats.idre.ucla.edu/stat/stata/output/mlogit.dta")


# covariates, all quantitative except as indicated
# gender            GenderC (categorical, 1 = M, 2 = F)
# age               Age
# education level   Education
# income level               IncomeRanges)
# race/Hispanic              RaceEthn
#                              1 Hispanic 
#                              2 Non-Hispanic White
#                              3 Non-Hispanic Black or African American
#                              4 Non-Hispanic American Indian or Alaska Native
#                              5 Non-Hispanic Asian 
#                              6 Non-Hispanic Native Hawaiian or other Pacific Islander
#                              7 Non-Hispanic Multiple Races Mentioned
# family history of cancer   FamilyEverHadCancer (categorical, 1 = Yes, 2 = No, 
#                              4 = Not sure, apparently omitted)
# ever sought cancer info    SeekCancerInfo (categorical, 1 = Yes, 2 = No)
# average drinks per week    AvgDrinksPerWeek
# absolute risk              ChanceGetCancerNoDX
#                              1 = Strongly agree 
#                              2 = Somewhat agree 
#                              3 = Somewhat disagree 
#                              4 = Strongly disagree
# worry                      FreqWorryCancerNoDx
#                              1 Not at all
#                              2 Slightly
#                              3 Somewhat
#                              4 Moderately
#                              5 Extremely
# everything causes cancer   EverythingCauseCancer (same as ChanceGetCancerNoDX)
# cancer can't be prevented  PreventNotPossible (same as ChanceGetCancerNoDX)
# too many recommendations   TooManyRecommendations (same as ChanceGetCancerNoDX)
# ability to care for own health  OwnAbilityTakeCareHealth
#                                   1 = Completely confident
#                                   2 = Very confident
#                                   3 = Somewhat confident
#                                   4 = A little confident
#                                   5 = Not confident at all
# consideration of future consequences ConsiderFuture (same as ChanceGetCancerNoDX)




         
         
       
     
 

