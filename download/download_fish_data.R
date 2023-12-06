# Clear your environment and memory
rm(list=ls())
gc()

# install packages needed for the analysis

if (!"pacman" %in% installed.packages()) install.packages("pacman")
pacman::p_load(neonstore)

# quickly ingest the fish data across all sites using the neonstore package
# more efficient than neonUtilities as it avoids repeat downloading

# this finds the existing the directory
neonstore::neon_dir()

# This sets the new directory on your local machine that the data are loaded to
Sys.setenv("NEONSTORE_HOME" = "C:/Users/mcclurer/OneDrive - National Ecological Observatory Network/Documents/R/neon-fish/neonstore")
Sys.setenv("NEONSTORE_DB" = "C:/Users/mcclurer/OneDrive - National Ecological Observatory Network/Documents/R/neon-fish/neonstore")

# download the neon-fish data
neonstore::neon_download(product="DP1.20107.001")

# store downloaded data in the above specified environment
neonstore::neon_store(product="DP1.20107.001")

# generate a data frame of all tables that were downloaded
table_index <- neonstore::neon_index(product="DP1.20107.001")

# collect the specific table names needed when using neon_read function
table_names <- unique(table_index$table) %>% str_subset(pattern = "-basic")
