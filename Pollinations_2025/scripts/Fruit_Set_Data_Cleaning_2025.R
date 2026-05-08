# 1.0 Load and Import Data
## --------------------------------------------------------------------------------
## 1.1 Load Packages
## --------------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(stringr)
library(tidyr)
library(here)
library(readr)
library(data.table)

## 1.2 Load and Import PRM and Self-Nectar Data
## --------------------------------------------------------------------------------
# Set Working Directory
setwd(here())

# PRM Pollination Data
PRM_Poll <- read_csv("./Pollinations_2025/rawdata/PRM_2025.csv", 
                       na = "N/A") 

# Self-Nectar Pollination Data
Self_Nectar_Poll <- read_csv("./Pollinations_2025/rawdata/Self_Nectar_Pollination.csv", 
                               na = "N/A")

# PRM Fruit Set Data
PRM_Fruit_Set <- read_csv("./Pollinations_2025/rawdata/Fruit_Set_2025.csv") 

# Self-Nectar Fruit Set Data
Self_Nectar_Fruit_Set <- read_csv("./Pollinations_2025/rawdata/Self_Nectar_Fruit_Set.csv") 

# 2.0 Clean Data
## --------------------------------------------------------------------------------
## 2.1 Clean PRM Pollination Data
## --------------------------------------------------------------------------------
  
# Remove unwanted treatments (HP (Hand Pollination) and SD (Sugar Drop))
PRM_Poll <- PRM_Poll %>%
  filter(!(treatment %in% c("HP", "SD")))

# Rename column
PRM_Poll <- PRM_Poll %>% 
  rename(out = num_above_tape)

# Create bract_id for PRM_Poll data
PRM_Poll$bract_id <- paste(PRM_Poll$plant_id, PRM_Poll$bract, sep="-")

# Create a flower ID for each individual flower (counts rows per bract_id)
PRM_Poll <- PRM_Poll %>%
  group_by(bract_id) %>%
  mutate(flower_id = row_number())
PRM_Poll$fruit_id <- paste(PRM_Poll$bract_id, PRM_Poll$flower_id, sep = "-")

# Remove columns that are not present in Self_Nectar_Poll
PRM_Poll <- subset(PRM_Poll, select = -c(coll_date, coll_time, donor_state, removed))

## 2.2 Clean PRM Fruit Set Data
## --------------------------------------------------------------------------------
  
# Rename columns
PRM_Fruit_Set <- PRM_Fruit_Set %>% 
  rename(fruit_coll_date = Date,
         obs = Obs, 
         patch = Parch,
         plant_id = Plant_ID,
         bract = Bract,
         treatment = Treatment,
         method = Method,
         num_seeds = "# Semillas",
         falsa = Falsa)

# Rename treatments
PRM_Fruit_Set <- PRM_Fruit_Set %>%
  mutate(treatment = dplyr::recode(treatment, "CTRL" = "Ctrl"))

# Rename patches and method
PRM_Fruit_Set <- PRM_Fruit_Set %>%
  mutate(patch = dplyr::recode(patch,"Tinamu" = "tinamu",
                        "Tower" = "tower"),
         method = dplyr::recode(method,"RPM" = "PRM"))

# Create a bract_id
PRM_Fruit_Set$bract_id <- paste(PRM_Fruit_Set$plant_id, 
                                PRM_Fruit_Set$bract, sep = "-")

# Create fruit_id
PRM_Fruit_Set <- PRM_Fruit_Set %>%
  group_by(bract_id) %>%
  mutate(fruit_id = row_number())

PRM_Fruit_Set$fruit_id <- paste(PRM_Fruit_Set$bract_id, 
                                PRM_Fruit_Set$fruit_id, sep = "-")

# Fix falsa column (fruit_id of 545-2-1 should have 1 in the falsa column)
PRM_Fruit_Set$falsa[PRM_Fruit_Set$fruit_id == "545-2-1"] <- 1
  
## 2.3 Clean Self-Nectar Pollination Data
## --------------------------------------------------------------------------------
  
# Rename columns
Self_Nectar_Poll <- Self_Nectar_Poll %>% 
  rename(patch = Parch,
         treatment = Treatment,
         poll_date = Date,
         plant_id = "Plant_ID",
         bract = Bract,
         pollen_donor = "Pollen_Donor",
         poll_time = "Time of Pollen",
         out = Out,
         nectar_amount = "Amount of Nectar",
         bract_NS_donor = Bract_NS_Donor,
         notes = Notes)

# Rename treatments
Self_Nectar_Poll <- Self_Nectar_Poll %>%
  mutate(treatment = dplyr::recode(treatment,"CTRL" = "Ctrl"))

# Rename inconsistent patch names
Self_Nectar_Poll <- Self_Nectar_Poll %>%
  mutate(patch = dplyr::recode(patch,"k2" = "K2", "k3" = "K3"))

# Add nectar_source column (same as plant_id for Self_Nectar, "NA" for Ctrl)
Self_Nectar_Poll <- Self_Nectar_Poll %>%
  mutate(nectar_source = if_else(treatment == "Self_Nectar", 
                                 as.character(plant_id), NA_character_))
Self_Nectar_Poll$nectar_source <- as.numeric(Self_Nectar_Poll$nectar_source)

# Remove columns that are not present in PRM_Poll
Self_Nectar_Poll <- subset(Self_Nectar_Poll, 
                           select = -c(bract_NS_donor, nectar_amount))

# Create bract_id
Self_Nectar_Poll$bract_id <- paste(Self_Nectar_Poll$plant_id, 
                                   Self_Nectar_Poll$bract, sep="-")

# Create a flower ID for each individual flower (counts rows per bract_id)
Self_Nectar_Poll <- Self_Nectar_Poll %>%
  group_by(bract_id) %>%
  mutate(flower_id = row_number())

Self_Nectar_Poll$fruit_id <- paste(Self_Nectar_Poll$bract_id, 
                                   Self_Nectar_Poll$flower_id, sep = "-")

## 2.4 Clean Self_Nectar Fruit Set Data
## --------------------------------------------------------------------------------
  
# Rename columns
Self_Nectar_Fruit_Set <- Self_Nectar_Fruit_Set %>% 
  rename(fruit_coll_date = Date,
         obs = Obs, 
         patch = Parch,
         plant_id = Plant_ID,
         bract = Bract,
         treatment = Treatment,
         method = Method,
         num_seeds = "# Semillas",
         falsa = Falsa)

# Rename treatments
Self_Nectar_Fruit_Set <- Self_Nectar_Fruit_Set %>%
  mutate(treatment = dplyr::recode(treatment,"CTRL" = "Ctrl"))

# Create a bract_id
Self_Nectar_Fruit_Set$bract_id <- paste(Self_Nectar_Fruit_Set$plant_id, 
                                        Self_Nectar_Fruit_Set$bract, sep = "-")

# Create fruit_id
Self_Nectar_Fruit_Set <- Self_Nectar_Fruit_Set %>%
  group_by(bract_id) %>%
  mutate(fruit_id = row_number())

Self_Nectar_Fruit_Set$fruit_id <- paste(Self_Nectar_Fruit_Set$bract_id, 
                                        Self_Nectar_Fruit_Set$fruit_id, sep = "-")

# 3.0 Combine Datasets
## --------------------------------------------------------------------------------
  
## 3.1 Combine Fruit Set and Pollination Datasets
## --------------------------------------------------------------------------------
  
# Merge PRM_Poll and PRM_Fruit_Set datasets and add a column with fruit set
PRM_Combined <- PRM_Poll %>%
  left_join(PRM_Fruit_Set, 
            by = c("fruit_id", "bract_id", "plant_id", "bract", 
                   "treatment", "patch")) %>%
  mutate(fruit_set = if_else(!is.na(fruit_coll_date), "Yes", "No"),
         fruit_set_binary = if_else(!is.na(fruit_coll_date), 1, 0))

# Merge Self_Nectar_Poll and Self_Nectar_Fruit_Set datasets and add a column with fruit set
Self_Nectar_Combined <- Self_Nectar_Poll %>%
  left_join(Self_Nectar_Fruit_Set, 
            by = c("fruit_id", "bract_id", 
                   "plant_id", "bract", "treatment", "patch")) %>%
  mutate(fruit_set = if_else(!is.na(fruit_coll_date), "Yes", "No"),
         fruit_set_binary = if_else(!is.na(fruit_coll_date), 1, 0))

## 3.2 Combine PRM and Self_Nectar datasets
## --------------------------------------------------------------------------------
  
# Add column for treatment-set
PRM_Combined$treatment_type <- "PRM"
Self_Nectar_Combined$treatment_type <- "Self_Nectar"

# Combine PRM and Self_Nectar datasets
All_Combined <- rbind(PRM_Combined, Self_Nectar_Combined)

## 3.3 Calculate real fruit and seed set
## --------------------------------------------------------------------------------
  
# Create a real seed set column
All_Combined$seed_set <- All_Combined$num_seeds - All_Combined$falsa

# Create strict binary fruit set
All_Combined <- All_Combined %>% 
  mutate(fruit_set_strict = if_else(seed_set == 0, "No", fruit_set),
       fruit_set_binary_strict = if_else(fruit_set_strict == "Yes", 1, 0),
       fruit_set_strict = if_else(is.na(fruit_set_strict), "No", fruit_set_strict),
       fruit_set_binary_strict = if_else(is.na(fruit_set_binary_strict), 0, fruit_set_binary_strict))

# 4.0 Combine all fruit set data
## --------------------------------------------------------------------------------
  
# Add column for treatment-set
PRM_Fruit_Set$treatment_type <- "PRM"
Self_Nectar_Fruit_Set$treatment_type <- "Self_Nectar"

# Combine PRM and Self-Nectar datasets
All_Fruit_Set <- rbind(PRM_Fruit_Set, Self_Nectar_Fruit_Set)
  
# 5.0 Simulated Visits
## --------------------------------------------------------------------------------
  
# Combine nectar and self-nectar into the same treatment
Simulated_Visits <- All_Combined %>%
  mutate(treatment_combined = if_else(treatment %in% c("N", "NS"), "N", treatment))

