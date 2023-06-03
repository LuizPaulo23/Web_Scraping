#' @title Web Scraping simples 
#' @author Luiz Paulo T. Gonçalves 

rm(list = ls())
graphics.off()

# \ Dependências e Packages 
library(tidyverse)
library(rvest)

# usar a função read_html() para obter o HTML da página
# Dados de Laticínios do mercado internacional 
page <- rvest::read_html("https://www.indexmundi.com/agriculture/?commodity=milk&graph=production")

# raspando os dados da tabela disponível no HTML 

db_index_mundi <- page %>% 
                  rvest::html_nodes("table") %>% 
                  html_table(fill = T)

# Organizando e limpando os dados raspados 
# Lista = 6 com a tabela de dados de laticínios do mercado internacional 

index_raw = db_index_mundi[[6]] %>% 
            base::as.data.frame() %>% 
            janitor::clean_names() %>% 
            dplyr::select(country, 
                          production_1000_mt) %>% 
            dplyr::mutate(index = ifelse(country == "Brazil", "1", "0"),
                          production_1000_mt = as.numeric(gsub(",", "", production_1000_mt))/10^3) %>% 
                   rename(tonnes = production_1000_mt) %>% 
                   relocate(index, .after = NULL) %>% 
                   arrange(desc(tonnes))

# Visualziando os dados --------------------------------------------------------

index_raw %>% 
      ggplot2::ggplot() +
      aes(x = reorder(country,tonnes), 
          y = tonnes, 
          fill = index) +
      geom_bar(position = "dodge",
               stat = "identity") +
      scale_fill_manual(values = c("0" = "gray","1" = "black")) +
      geom_text(aes(label = sprintf(paste0("%0.", 1, "f"),
                    round(tonnes, digits = 1))),
                    color = "black",
                    size = 3.0,
                    vjust = 0.5, 
                    hjust = -0.1) +
      guides(fill = "none")+
      coord_flip()+
      labs(title = "Maiores Produtores de Leite no Mercado Mundial (2023) - 1000 MT",
           y = "Produção por país (1000 MT)", 
           x = "") + 
      theme(legend.title = element_blank())

