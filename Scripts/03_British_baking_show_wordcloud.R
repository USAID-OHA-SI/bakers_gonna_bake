# PROJECT:  Visualize British Baking Show Bakes
# AUTHOR:   J.Hoehner | USAID
# PURPOSE:  Munge and Analysis of BBS bakes (word cloud)
# REF ID:   e26cd8c3 
# LICENSE:  MIT
# DATE:     2022-12-08

# DEPENDENCIES ----------------------------------------------------------------
  
  library(tidyverse)
  library(dplyr)
  library(extrafont)
  library(gagglr)
  library(tidytext)
  library(stringr)
  library(wordcloud2)
  library(knitr)
  library(tidyr)
  library(googlesheets4)
  library(janitor)
  library(stopwords)

# SI specific functions
  load_secrets()

# GLOBAL VARIABLES ------------------------------------------------------------
  
  # path of google sheet
  gs_sh <- "12YActFxNKp8RlrbL9im1_Lx0jA71bP36oj9_24ZBSi0"
  
  # REF ID for plots
  ref_id <- "e26cd8c3"

# IMPORT ----------------------------------------------------------------------

  df <- read_sheet(gs_sh)

# MUNGE -----------------------------------------------------------------------


bbs_words <- df %>%
    clean_names() %>%
    unnest_tokens(word, bake) %>%
    anti_join(get_stopwords()) %>%
    mutate(word = as.character(word)) %>%
    filter(nchar(word) > 1, 
           word != "3d") %>%
    count(word, sort = TRUE) %>%
    filter(n > 4) 

# VIZ --------------------------------------------------------------------------
  
  bbs_words %>%
    with(wordcloud2(., 
                  n, 
                  size = 0.75, 
                  fontFamily = "Source Sans Pro", 
                  color = rev(si_palettes$moody_blues), 
                  backgroundColor = moody_blue_light, 
                  shuffle = FALSE, 
                  maxRotation = 0.5))