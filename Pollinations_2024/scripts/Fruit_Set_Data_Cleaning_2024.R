# Load Packages
## --------------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(stringr)
library(tidyr)
library(data.table)
library(here)
library(readr)
library(hms)

# Set directory
## --------------------------------------------------------------------------------
setwd(here())

# Load Data
## --------------------------------------------------------------------------------

# Load fruit set data (first column are just row numbers)
Fruit_Set_2024 <- read_csv("./Pollinations_2024/rawdata/Fruit_Set_2024.csv", 
                             col_select = -1)
  
# Load and import PRM pollination data (each row represents a flower/fruit)
PRM_OG <- read_csv("./Pollinations_2024/rawdata/PRM_Trials.csv")

# Load Extended PRM pollination data
PRM_Ext_OG <- read_csv("./Pollinations_2024/rawdata/PRM_Extended.csv")


# Clean Fruit Set Data (Fruit_Set_2024)
## --------------------------------------------------------------------------------
# Change "# Semillas" to "Semillas"
colnames(Fruit_Set_2024)[which(names(Fruit_Set_2024) == "# Semillas")] <- "Semillas"

# Create a Bract_ID
Fruit_Set_2024$Bract_ID <- paste(Fruit_Set_2024$Planta, 
                                 Fruit_Set_2024$Bractea, sep="-")

# Create Fruit_ID
Fruit_Set_2024 <- Fruit_Set_2024 %>%
  group_by(Bract_ID) %>%
  mutate(Fruit_ID = row_number())


# Clean Pollination Data (PRM_OG)
## --------------------------------------------------------------------------------
# Convert killed treatments to "Polish"
PRM_Pol <- PRM_OG %>%
  mutate(Treatment = if_else(Killed == "Y", "Polish", Treatment))

# Remove "Polish" rows
PRM_Pol <- PRM_Pol %>%
  filter(Treatment != "Polish")

# Create a Bract_ID
PRM_Pol$Bract_ID <- paste(PRM_Pol$Plant_ID, PRM_Pol$Bract_Num, sep="-")

# Keep only the relevant columns
PRM_Pol <- PRM_Pol[,c("Patch","Plant_ID", "Bract_Num", "Treatment", 
                      "Bract_ID", "Poll_Date", "Poll_Time", 
                      "Pollen_Donor", "Num_Above_Tape")]

# Convert Poll_Date from character to date class
PRM_Pol$Poll_Date <- as.Date(PRM_Pol$Poll_Date)

# Create Fruit_ID
PRM_Pol <- PRM_Pol %>%
  group_by(Bract_ID) %>%
  mutate(Fruit_ID = row_number())

PRM_Pol # 201 rows (5 polish's removed)


# Clean Extended Pollination Data (PRM_Ext_OG)
## --------------------------------------------------------------------------------
# Remove "Polish" rows
PRM_Ext_Pol <- PRM_Ext_OG %>%
  filter(Treatment != "Polish")

# Create a Bract_ID
PRM_Ext_Pol$Bract_ID <- paste(PRM_Ext_Pol$Plant_ID, PRM_Ext_Pol$Bract, sep="-")
colnames(PRM_Ext_Pol)[which(names(PRM_Ext_Pol) == "Out")] <- "Num_Above_Tape"

# Keep only the relevant columns
PRM_Ext_Pol <- PRM_Ext_Pol[,c("Patch","Plant_ID", "Bract", "Treatment", 
                              "Bract_ID", "Poll_Date", "Poll_Time", 
                              "Pollen_Donor", "Num_Above_Tape")]

# Remove the incorrect from the time column
PRM_Ext_Pol$Poll_Time <- as_hms(format(PRM_Ext_Pol$Poll_Time, 
                                       format = "%H:%M:%S"))

# Create Fruit_ID
PRM_Ext_Pol <- PRM_Ext_Pol %>%
  group_by(Bract_ID) %>%
  mutate(Fruit_ID = row_number())

PRM_Ext_Pol # 254 rows (25 polish's removed)


# Merge Fruit Set and Pollination Data
## --------------------------------------------------------------------------------
# Filter Fruit_Set_2024 for PRM and PRM-Ext Separately
PRM_FS <- Fruit_Set_2024 %>% filter(Method=="PRM")
PRM_Ext_FS <- Fruit_Set_2024 %>% filter(Method=="PRM-Ext")

# Merge PRM and PRM_FS datasets and add a column with fruit set
PRM_Final <- PRM_Pol %>%
  left_join(PRM_FS, by = c("Bract_ID", "Treatment", "Fruit_ID")) %>%
  mutate(Fruit_Set = if_else(!is.na(Fecha), "Yes", "No")) 

# Merge PRM_Ext and PRM_FS datasets and add a column with fruit set
PRM_Final_Ext <- PRM_Ext_Pol %>%
  left_join(PRM_Ext_FS, by = c("Bract_ID", "Treatment", "Fruit_ID")) %>%
  mutate(Fruit_Set = if_else(!is.na(Fecha), "Yes", "No")) 

# Remove unnecessary/redundant columns
PRM_Final_Ext <- subset(PRM_Final_Ext, select = -c(Parche, Planta, Bractea))
PRM_Final <- subset(PRM_Final, select = -c(Parche, Planta, Bractea))

# Remove E from PRM_Final
PRM_Final_AD <- PRM_Final %>%
  filter(Treatment != "E")

# View Tables
PRM_Final
PRM_Final_AD
PRM_Final_Ext


# Merge OG and Extended (Ext) Experiments
## --------------------------------------------------------------------------------
# Rename "Bract_Num" to "Bract" in PRM_Final so it's consistent with PRM_Final_Ext
colnames(PRM_Final)[which(names(PRM_Final) == "Bract_Num")] <- "Bract"

# Change class of Pollen_Donor
PRM_Final$Pollen_Donor <- as.numeric(PRM_Final$Pollen_Donor)
PRM_Final_Ext$Pollen_Donor <- as.numeric(PRM_Final_Ext$Pollen_Donor)

# Filter Fruit_Set_2024 for PRM
PRM_FS <- Fruit_Set_2024 %>% filter(Method=="PRM")

# Merge PRM_Final and PRM_Final_Ext
PRM_All <- rbind(PRM_Final, PRM_Final_Ext)

# Convert ND-Far and ND-NN to ND
PRM_Trio <- PRM_All %>%
  mutate(Treatment = case_when(
    Treatment == "ND-Far" ~ "ND",
    Treatment == "ND-NN" ~ "ND",
    TRUE ~ Treatment))

# PRM_Trio + Extras
PRM_Trio_Ext <- PRM_Trio %>%
  filter(Treatment != "ND-S")

# Remove all other treatments (PRM_Trio OG)
PRM_Trio <- PRM_Trio %>%
  filter(!(Treatment %in% c("ND-S", "SD", "E")))

# Create Strict PRM Dataset
## --------------------------------------------------------------------------------

# Convert ND-Far to ND
PRM_Trio_Strict <- PRM_All %>%
  mutate(Treatment = case_when(
    Treatment == "ND-Far" ~ "ND",
    TRUE ~ Treatment))

# Remove all other treatments
PRM_Trio_Strict <- PRM_Trio_Strict %>%
  filter(!(Treatment %in% c("ND-S", "SD", "E", "ND-NN")))
