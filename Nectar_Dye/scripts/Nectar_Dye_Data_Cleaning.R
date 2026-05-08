###### Script to clean species_dye data ######

# Import and Clean Data

## Load Packages 
## --------------------------------------------------------------------------------
library(ddimport) # for importing data to the correct folder
library(dplyr) # for data wrangling
library(ggplot2) # for plotting
library(here) # for setting the working directory
library(tidyverse) # for data cleaning

# Set directory
## --------------------------------------------------------------------------------
setwd(here())

## Import Data
## --------------------------------------------------------------------------------
species_ND <- read.csv("./Nectar_Dye/rawdata/Nectar_Dye_Experiment.csv", na = "N/A")

## Clean Data
## --------------------------------------------------------------------------------
# Note: In the "dye_on_stigma" column, there is one "M", or "maybe".
# In this case, there was dye high up on the style, but not at the very tip of the stigma surface. 
# I decided to convert the "M" into "little" because there were no other maybes, so this allowed me to collapse an entire column.

# Combine species and sex to make unique bill
species_ND$bill_type <- 
  paste(species_ND$species, species_ND$sex, sep = "-")

# Convert "M" (maybe) to "little"
species_ND <- species_ND %>% 
  mutate(dye_on_stigma = recode(dye_on_stigma, "M" = "little"))

# Make a new column for presence/absence of dye on stigma
species_ND$dye_on_stigma_binary <- 
  ifelse(species_ND$dye_on_stigma %in% c("little", "lots"), "Yes", "No")

# Make a new column for presence/absence of dye on anthers
species_ND$dye_on_anthers_binary <- 
  ifelse(species_ND$dye_on_anthers %in% c("little", "lots", "Y"), "Yes", "No")

# Make a new column for if there was dye on any of the reproductive structures
species_ND$dye_on_rep_strucs <- 
  ifelse(species_ND$dye_on_stigma_binary == "Yes" | 
           species_ND$dye_on_anthers_binary == "Yes", "Yes", "No")

# Make a new column for foraging strategy
species_ND$foraging <- 
  ifelse(species_ND$species %in% c("GREH", "VISA"), "trapliner", "territorial")
