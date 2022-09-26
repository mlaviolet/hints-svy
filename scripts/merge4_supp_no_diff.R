# This R script is a supplement to the article "Analyzing the HINTS Survey with R." 
# To run this script, download the data files for HINTS 5, Cycles 1, 2, 3 and 4. 
#   Then set up an RStudio project and copy this file to a subfolder `scripts` 
#   and the data files to a subfolder `data-raw`. For more see the link 
#   https://rfortherestofus.com/2021/08/rstudio-project-structure

# This script merges all four cycles of HINTS 5 assuming no differences
#   between Phase 3 modes. It creates a data tibble with 16,092 rows, 
#   person-level weight Merged_NWGT0 and 200 replicate weights Merged_NWGT1 
#   through Merged_NWGT200

# For each cycle, the following steps are processed: 
# Step "a" imports the SAS data
# Step "b" subsets the PersonID and PERSON_FINWT variables, then renames
#   the 50 replicate weights to names beginning with "Merged_NWGT"
# Step "c" joins the data tibbles from the previous two steps and renames 
#   the remaining 150 replicate weights so that all 200 replicate weights have
#   the correct sequential names
# All three temporary data tibbles "a," "b," and "c"  are joined by PersonID 
#   to produce a single data tibble for that cycle. The temporary data 
#   sets are deleted.
# After all four cycles are completed, the four tibbles are concatenated
#   into a single tibble which is used to create a replicate weights
#   survey object

library(dplyr)
library(purrr)
library(haven)
library(forcats)
library(srvyr)
library(here)

# Merge four cycles with no group differences -----------------------------
# assuming no differences between the three modalities of HINTS 5 Cycle 3, so
#   using TG_all_FINWT0 through TG_all_FINWT50 from Cycle 3
# creating 200 replicate weights

# Cycle 1
# final sampling weight and replicate weights 1-50
cycle1a <- read_sas(unz(
  here("data-raw", "HINTS-5_Cycle1_SAS.zip"),
                        "SAS/hints5_cycle1_public.sas7bdat")) 
cycle1b <- cycle1a %>% 
  select(PersonID, c(paste0("PERSON_FINWT", 0:50))) %>% 
  rename_at(paste0("PERSON_FINWT", 0:50), ~ paste0("Merged_NWGT", 0:50)) 
# replicate weights 51-200
# copy sampling weight 150 times as Merged_NWGT51 : Merged_NWGT200
cycle1c <- map(1:150, ~ select(cycle1b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", 51:200))) 
# merge three parts into one table and add survey identifier
cycle1 <- list(cycle1a, cycle1b, cycle1c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 1) 
rm(cycle1a, cycle1b, cycle1c)

# Cycle 2
# sampling weights and replicate weights 51-100
cycle2a <- 
  read_sas(unz(here("data-raw", "HINTS5_Cycle2_SAS_10132020.zip"),
               "HINTS 5- Cycle 2-SAS-10132020/hints5_cycle2_public.sas7bdat"))
cycle2b <- cycle2a %>% 
  select(PersonID, c(paste0("PERSON_FINWT", 0:50))) %>% 
  rename_at(paste0("PERSON_FINWT", 0:50), ~ 
              paste0("Merged_NWGT", c(0, 51:100))) 
# replicate weights 1:50, 101:200
cycle2c <- map(1:150, ~ select(cycle2b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", c(1:50, 101:200)))) 
# join into single table
cycle2 <- list(cycle2a, cycle2b, cycle2c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 2) 
rm(cycle2a, cycle2b, cycle2c)

# cycle 3
cycle3a <- read_sas(
  unz(here("data-raw", "HINTS5_Cycle3_SAS_20210305.zip"),
                        "hints5_cycle3_public.sas7bdat"))
# final sampling weight and replicate weights 101-150
cycle3b <- cycle3a %>% 
  select(PersonID, c(paste0("TG_all_FINWT", 0:50))) %>% 
  rename_at(paste0("TG_all_FINWT", 0:50), 
            ~ paste0("Merged_NWGT", c(0, 101:150))) 
# replicate weights 1:100, 151-200
cycle3c <- map(1:150, ~ select(cycle3b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", c(1:100, 151:200)))) 
# join into single table 
cycle3 <- list(cycle3a, cycle3b, cycle3c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 3) 
rm(cycle3a, cycle3b, cycle3c)

# cycle 4
cycle4a <- read_sas(
  unz(here("data-raw", "HINTS5_Cycle4_SAS_20220519.zip"),
      "HINTS5_Cycle4_SAS_20220519/hints5_cycle4_public.sas7bdat"))
# final sampling weight and replicate weights 101-150
cycle4b <- cycle4a %>% 
  select(PersonID, c(paste0("PERSON_FINWT", 0:50))) %>% 
  rename_at(paste0("PERSON_FINWT", 0:50), 
            ~ paste0("Merged_NWGT", c(0, 151:200))) 
# replicate weights 1-150
cycle4c <- map(1:150, ~ select(cycle4b, PersonID, Merged_NWGT0)) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  set_names(c("PersonID", paste0("Merged_NWGT", 1:150)))
# join into single table
cycle4 <- list(cycle4a, cycle4b, cycle4c) %>% 
  reduce(inner_join, by = "PersonID") %>% 
  mutate(survey = 4)
rm(cycle4a, cycle4b, cycle4c)

# concatenate cycles 1, 2, 3, 4 into single table and create survey object
hints5_svy_no_diff <- bind_rows(cycle1, cycle2, cycle3, cycle4) %>% 
  # reorder columns to put new weights in front
  select(survey, PersonID, num_range("Merged_NWGT", 0:200), everything()) %>% 
  # variable to distinguish survey iterations
  mutate_at("survey", factor, 1:4, paste("HINTS 5 Cycle", 1:4)) %>% 
  mutate_at("SeekHealthInfo", factor, labels = c("(Missing)", "Yes", "No")) %>% 
  mutate_at("ChanceAskQuestions", factor, 1:4,
            c("Always", "Usually", "Sometimes", "Never")) %>%
  mutate_at("ChanceAskQuestions", fct_explicit_na) %>% 
  mutate_at("ChanceAskQuestions", relevel, "(Missing)") %>% 
  as_survey_rep(weights = "Merged_NWGT0",
                repweights = paste0("Merged_NWGT", 1:200), 
                type = "JK1", scale = 49/50, mse = TRUE)
rm(cycle1, cycle2, cycle3, cycle4)

# SeekHealthInfo NOT IN CYCLE 4
# test with ChanceAskQuestions (missings explicit)
hints5_svy_no_diff %>%
  group_by(survey, ChanceAskQuestions) %>%
  summarize(n = unweighted(n()),
            pct = survey_mean(na.rm = TRUE)) %>%
  mutate(across(starts_with("pct"), ~ 100 * .x))
# RECHECK THIS AGAINST SAS--2021-08-03


