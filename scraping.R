library(tidyverse)
library(rvest)
library(janitor)


url_base <- "https://www.twse.com.tw/exchangeReport/MI_INDEX20?response=html&date="
url <- url_base %>% 
    paste0(
        format(Sys.Date(), "%Y%m%d")
    )


url_html <- read_html(url, encoding = "UTF-8")
url_html %>% 
    html_elements("thead td") %>% 
    html_text() -> table_title
url_html %>% 
    html_elements("tbody td") %>% 
    html_text() %>% 
    matrix(ncol=13, byrow=T) -> top_volumn
colnames(top_volumn) <- table_title


if(!all(is.na(top_volumn))) write_csv(top_volumn, paste0('data/',Sys.Date(),'_top_volumn','.csv'))
