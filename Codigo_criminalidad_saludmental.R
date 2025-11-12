library(readr)
library(dplyr)

carpeta <- "INPUT/DATA/Salud_Mental"
archivos <- list.files(carpeta, pattern = "_UTF8\\.csv$", full.names = TRUE)

salud_mental <- read_delim(archivos, delim = ";", id = "archivo",
                           trim_ws = TRUE, show_col_types = FALSE)

View(salud_mental)

library(tidyverse)

ruta_criminalidad <- "INPUT/DATA/CRIMINALIDAD"
archivos <- list.files(path = ruta_criminalidad, pattern = "\\.csv$", full.names = TRUE)


criminalidad_total <- readr::read_csv(archivos, id = "archivo", show_col_types = FALSE)

datos_criminalidad_total <- criminalidad_total %>%
  mutate(
    comunidad = archivo %>%
      basename() %>%
      str_remove("\\.csv$") %>%
      str_to_lower() %>%
      str_extract("(?<=en_).*") %>%
      str_replace_all("_+", " ") %>%
      str_replace_all("-", " ") %>%
      str_squish() %>%
      str_to_title()
  )

View(datos_criminalidad_total)
