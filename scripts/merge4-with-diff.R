
# MERGE ALL FOUR CYCLES OF HINTS 5 CONTROLLING FOR GROUP DIFFERENCES
# Merge four cycles controlling for group differences --------------------=
# Need total of 300 replicates: Cycle 1 (50), Cycle 2 (50), Cycle 3 (50 x 3),
#  Cycle 4 (50)
# From Phase 3 need weights nwgt1:nwgt150

library(dplyr)
library(purrr)
library(haven)
library(forcats)
library(srvyr)
library(here)

# Cycle 1
# sampling weight and replicate weights 1-50
cycle1a <- read_sas(unz(here("data-raw", "HINTS-5_Cycle1_SAS.zip"),
                        "SAS/hints5_cycle1_public.sas7bdat"))  
cycle1b <- cycle1a %>% 
  select(PersonID, c(paste0("PERSON_FINWT", 0:50))) %>% 
  rename_at(paste0("PERSON_FINWT", 0:50), ~ paste0("Merged_NWGT", 0:50)) 
# replicate weights 51-300
# copy sampling weight 250 times as Merged_NWGT51 : Merged_NWGT300
cycle1c <- map(1:250, ~ select(cycle1b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", 51:300)))  
cycle1 <- list(cycle1a, cycle1b, cycle1c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 1) 
rm(cycle1a, cycle1b, cycle1c)

# Cycle 2
# sampling weight and replicate weights 51-100
cycle2a <- 
  read_sas(unz(here("data-raw", "HINTS5_Cycle2_SAS_10132020.zip"),
               "HINTS 5- Cycle 2-SAS-10132020/hints5_cycle2_public.sas7bdat"))
cycle2b <- cycle2a %>% 
  select(PersonID, c(paste0("PERSON_FINWT", 0:50))) %>% 
  rename_at(paste0("PERSON_FINWT", 0:50), ~ 
              paste0("Merged_NWGT", c(0, 51:100))) 
# replicate weights 1-50, 101-300
cycle2c <- map(1:250, ~ select(cycle2b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", c(1:50, 101:300)))) 
cycle2 <- list(cycle2a, cycle2b, cycle2c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 2) 
rm(cycle2a, cycle2b, cycle2c)

# cycle 3
cycle3a <- read_sas(
  unz(here("data-raw", "HINTS5_Cycle3_SAS_20210305.zip"),
      "hints5_cycle3_public.sas7bdat"))
# final sampling weight and replicate weights 1-100, 251-300
cycle3b <- cycle3a %>% 
  select(PersonID, c(paste0("nwgt", 0:150))) %>% 
  rename_at(paste0("nwgt", 0:150), 
            ~ paste0("Merged_NWGT", c(0, 101:250))) 
# replicate weights 1-100
cycle3c <- map(1:150, ~ select(cycle3b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", c(1:100, 251:300))))
cycle3 <- list(cycle3a, cycle3b, cycle3c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 3)
rm(cycle3a, cycle3b, cycle3c)

# cycle 4
cycle4a <- read_sas(
  unz(here("data-raw", "HINTS5_Cycle4_SAS_20220519.zip"),
      "HINTS5_Cycle4_SAS_20220519/hints5_cycle4_public.sas7bdat"))
# final sampling weight and replicate weights 251-300
cycle4b <- cycle4a %>% 
  select(PersonID, c(paste0("PERSON_FINWT", 0:50))) %>% 
  rename_at(paste0("PERSON_FINWT", 0:50), 
            ~ paste0("Merged_NWGT", c(0, 251:300))) 
# replicate weights 1-150
cycle4c <- map(1:250, ~ select(cycle4b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", 1:250)))
# join into single table
cycle4 <- list(cycle4a, cycle4b, cycle4c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 4)
rm(cycle4a, cycle4b, cycle4c)

# combine four cycles into survey object
treatment_lbl <- c("Paper only", "Web option", "Web bonus")
hints5_svy_with_diff <- bind_rows(cycle1, cycle2, cycle3, cycle4) %>% 
  # add variable to distinguish surveys and groups
  # Cycles 1 and 2 were paper only; Cycle 3 was paper and online
  mutate(treatment = case_when(
    survey == 1 ~ 1,
    survey == 2 ~ 1,
    survey == 3 & Treatment_H5C3 == 1 ~ 1,
    survey == 3 & Treatment_H5C3 == 2 ~ 2,
    survey == 3 & Treatment_H5C3 == 3 ~ 3,
    survey == 4 ~ 1)) %>% 
  mutate_at("survey", factor, 1:4, paste("HINTS 5 Cycle ", 1:4)) %>% 
  mutate_at("treatment", factor, 1:3, treatment_lbl) %>% 
  mutate_at("SeekHealthInfo", factor, labels = c("(Missing)", "Yes", "No")) %>% 
  mutate_at("ChanceAskQuestions", factor, 1:4,
            c("Always", "Usually", "Sometimes", "Never")) %>%
  mutate_at("ChanceAskQuestions", fct_explicit_na) %>% 
  mutate_at("ChanceAskQuestions", relevel, "(Missing)") %>% 
  # reorder columns to put treatment and new weights in front
  select(survey, treatment, PersonID, num_range("Merged_NWGT", 0:300), 
         everything()) %>% 
  # create replicate weight survey object
  as_survey_rep(weights = "Merged_NWGT0",
                repweights = paste0("Merged_NWGT", 1:300), 
                type = "JK1", scale = 49/50, mse = TRUE)
rm(cycle1, cycle2, cycle3, cycle4)

# test with SeekHealthInfo (missings explicit)
# hints5_svy_with_diff %>% 
#   group_by(survey, treatment, SeekHealthInfo) %>% 
#   summarize(n = unweighted(n()),
#             pct = survey_mean(na.rm = TRUE)) %>% 
#   mutate_at(vars(starts_with("pct")), percentage)

# test with ChanceAskQuestions (missings explicit)
results4 <- hints5_svy_with_diff %>%
  group_by(survey, treatment, ChanceAskQuestions) %>%
  summarize(n = unweighted(n()),
            pct = survey_mean(na.rm = TRUE)) %>%
  mutate(across(starts_with("pct"), ~ 100 * .x))

# LOOKS GOOD--MATCHES SAS!

