
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




         
         
       
     
 

