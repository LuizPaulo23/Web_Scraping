#' @title Web Scraping - Project Maddison 
#' @author Luiz Paulo T. Gonçalves 
#' @details Busca-se fazer o download de uma tabela em formato .xlsx

rm(list = ls())

# Dependências

library(tidyverse)
library(rvest)
library(httr)

# WebScraping - Project Maddison Database

maddison_link <- rvest::html_nodes(read_html("https://www.rug.nl/ggdc/historicaldevelopment/maddison/releases/maddison-project-database-2020"),
                                # código do botão de download
                                ".rug-mr-s") %>% rvest::html_attr("href")

excel_url = base::paste0("https://www.rug.nl", maddison_link[2])

# getwd() #\ verificar em qual pasta será salvo o arquivo .xlsx
# Fazendo o download - mpd2020

httr::GET(excel_url,
          write_disk("mpd2020.xlsx",
                     overwrite = T))

# Salvando o xlsx sheet Full Data
# db_maddison = readxl::read_excel("mpd2020.xlsx", sheet = 3) %>%
#               dplyr::relocate(year, .after = NULL)
