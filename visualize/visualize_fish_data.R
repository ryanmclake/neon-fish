# Clear your environment and memory
rm(list=ls())
gc()

# install packages needed for the analysis

if (!"pacman" %in% installed.packages()) install.packages("pacman")
pacman::p_load(tidyverse, neonstore, lubridate, zoo)

# generate a data frame of all tables that were downloaded
table_index <- neonstore::neon_index(product="DP1.20107.001")

# collect the specific table names needed when using neon_read function
table_names <- unique(table_index$table) %>% str_subset(pattern = "-basic")

# Identify the lakes
lakes <- c("CRAM","LIRO","PRPO","PRLA","SUGG","BARC","TOOK")

# Identify the streams
streams <- c()


lake_fish_bulkCount <- neonstore::neon_read(table = table_names[1], site = lakes) %>%
  dplyr::filter(siteID == c("PRLA","PRPO")) %>%
  dplyr::filter(str_detect(eventID, "fyke")) %>%
  dplyr::filter(taxonID == "PIMPRO") %>%
  mutate(date = lubridate::date(passEndTime)) %>%
  mutate(date = as.Date(as.yearmon(date, "%m/%Y"))) %>%
  group_by(namedLocation) %>%
  mutate(location_count = length(namedLocation))
  





ggplot(lake_fish_bulkCount, aes(passEndTime, bulkFishCount, color = as.character(passNumber)))+
  geom_point(size = 3)

summary(lake_fish_bulkCount)

lake_fish_fieldData <- neonstore::neon_read(table = table_names[2], site = lakes)
summary(lake_fish_fieldData)

lake_fish_perFish <- neonstore::neon_read(table = table_names[3], site = lakes)
summary(lake_fish_perFish)

lake_fish_perPass <- neonstore::neon_read(table = table_names[4], site = lakes)
summary(lake_fish_perPass)
