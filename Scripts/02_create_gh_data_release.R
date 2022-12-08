# PROJECT: Visualize British Baking Show Bakes
# PURPOSE: Munge and Analysis of BBS bakes
# DATE: 2022-12-08
# AUTHOR: Tim Essam | SI

# LOCALS & SETUP ============================================================================

# Libraries
  library(gagglr)
  library(tidyverse)
  library(scales)
  library(extrafont)
  library(ggtext)
  library(glue)
  library(googlesheets4)
  library(piggyback)


# SI specific functions / path of google sheet
  load_secrets()
  gs_sh <- "12YActFxNKp8RlrbL9im1_Lx0jA71bP36oj9_24ZBSi0"
  
# MUNGE GBBS DATA ---------------------------------------------------------
  
  
  # Load data and convert to an rds file  
  gbbs <- read_sheet(gs_sh) %>% 
    rename(season = Sea, 
           episode = Ep, 
           theme = `Week Theme`,
           round = Round, 
           bake = Bake, 
           time = Time)
  
  # Save the data as a rds file for publishing to github
  gbbs %>% 
    saveRDS(file = "Dataout/gbbs_themes.rds")  
  
# SET UP RELEASE METADATA ============================================================================  

  repo <- "USAID-OHA-SI/bakers_gonna_bake"
  tag <- "gbbs-data-2022"
  
# PIGGYBACKIN' MAGIC TIME -------------------------------------------------

  # Make a new release
  #pb_new_release(repo = repo, tag = tag)
  
  # Upload data to the repo and tag
  pb_upload(file = "Dataout/gbbs_themes.rds", 
            repo = repo,
            tag = tag)   
   
   
   