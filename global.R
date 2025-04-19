# GLOBAL SCRIPT

# Load packages
pacman::p_load(here,
               shiny, shinyjs,
               DT, janitor,
               readxl, tidyverse,
               flextable, lubridate,
               officer, officedown,
               glue, gt, 
               zoo, ggplot2,
               stringi, flextable)



# Get R scripts with funcitons and source them
funcs <- list.files(here::here("R"), pattern = ".R$", full.names = TRUE)
walk(funcs, source)


#-----------------------------------------------------------------
# simpleCap <- function(x) {
#   s <- tolower(x)
#   s <- strsplit(s, ' ')[[1]]
#   str <- paste(toupper(substring(s, 1, 1)), substring(s, 2),
#                sep = '', collapse = ' ')
#   return(str)
# }


