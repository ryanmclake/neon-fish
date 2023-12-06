# Clear your environment and memory
rm(list=ls())
gc()

# install packages needed for the analysis

if (!"pacman" %in% installed.packages()) install.packages("pacman")
pacman::p_load(tidyverse, neonstore)

# Get the newest NEON fish data
source("~/R/neon-fish/download/download_fish_data.R")

# Identify the lakes
lakes <- c("CRAM","LIRO","PRLO","PRLA","SUGG","BARC","TOOK")

# Identify the streams
streams <- c()

# Identify the rivers
rivers <- c()


lake_fish_bulkCount <- neonstore::neon_read(table = table_names[1], site = lakes) %>%
  filter(siteID == "PRLA")

ggplot(lake_fish_bulkCount, aes(passEndTime, bulkFishCount))+
  geom_point()

summary(lake_fish_bulkCount)

lake_fish_fieldData <- neonstore::neon_read(table = table_names[2], site = lakes)
summary(lake_fish_fieldData)

lake_fish_perFish <- neonstore::neon_read(table = table_names[3], site = lakes)
summary(lake_fish_perFish)

lake_fish_perPass <- neonstore::neon_read(table = table_names[4], site = lakes)
summary(lake_fish_perPass)
