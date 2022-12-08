# PROJECT: Visualize British Baking Show Bakes
# PURPOSE: Munge and Analysis of BBS bakes
# AUTHOR: Tim Essam | SI
# REF ID:   d25063c8
# LICENSE: MIT
# DATE: 2022-12-08
# NOTES: Tim Essam | SI

# LOCALS & SETUP ============================================================================

  # Libraries
    library(gagglr)
    library(tidyverse)
    library(scales)
    library(extrafont)
    library(ggtext)
    library(glue)
    library(googlesheets4)
    
    
  # SI specific functions / path of google sheet
    load_secrets()
    gs_sh <- "12YActFxNKp8RlrbL9im1_Lx0jA71bP36oj9_24ZBSi0"
  
  # REF ID for plots
    ref_id <- "d25063c8"

  # LOAD DATA ============================================================================  

  bbs <- read_sheet(gs_sh) 

# MUNGE & VIZ ============================================================================
  
 p <-  bbs %>% 
      # Need to complete the series for each season b/c season 1 & 2 did not have 10 episodes
      complete(Sea, Ep) %>% 
      group_by(Sea, Ep, `Week Theme`) %>% 
      summarise(tmp = 1) %>% 
      ungroup() %>% 
      ggplot(aes(y = factor(Sea), x = factor(Ep), fill = `Week Theme`)) +
      geom_tile(color = "white", alpha = 0.75) +
      geom_text(aes(label = stringr::str_wrap(`Week Theme`, 10)), size = 10/.pt,
                family = "Source Sans Pro") +
      si_style_nolines() +
      theme(legend.position = "none") +
      scale_fill_si(palette = "siei", discrete = T, na.value = grey20k) +
      scale_y_discrete(limits = rev) +
      scale_x_discrete(position = "top") +
      labs(x = NULL, y = NULL, 
           title = "THE GREAT BRITISH BAKING SHOW BAKE WEEK THEMES THROUGH TEN SEASONS",
           caption = "Source: www.reddit.com/r/bakeoff | ref id: d25063c8")
    
    # Show plot
    p
    
    # Exporting as an SVG so we can touch up in AI / PPT
    si_save(p, "Graphics/BBS_heat.svg")
  
  
