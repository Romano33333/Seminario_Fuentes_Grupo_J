library(tidyverse)
library(stringr)
library(jsonlite)
library(tidyr)

ruta_criminalidad <- "INPUT/DATA/CRIMINALIDAD"
archivos <- list.files(path = ruta_criminalidad, pattern = "*.csv", full.names = TRUE)

# Función para procesar cada CSV y añadir la columna comunidad
procesar_csv <- function(f) {
  df <- read_csv2(f)  # read_csv2 usa ";" como separador, típico en España
  comunidad <- f %>%
    basename() %>%
    str_remove("\\.csv$") %>%
    str_to_lower() %>%
    str_extract("(?<=en_).*") %>%
    str_replace_all("_+", " ") %>%
    str_replace_all("-", " ") %>%
    str_squish() %>%
    str_to_title()
  
  df$comunidad <- comunidad
  return(df)
}


# Aplicar a todos los archivos y unir
datos_criminalidad_total <- bind_rows(lapply(archivos, procesar_csv))

# Ver resultado
view(datos_criminalidad_total)

library(readr)
library(dplyr)

carpeta <- "INPUT/DATA/Enfermedades_Cardiovasculares"
archivos <- list.files(carpeta, pattern = "_UTF8\\.csv$", full.names = TRUE)

Enf_card <- read_delim(archivos, delim = ";", id = "archivo",
                           trim_ws = TRUE, show_col_types = FALSE)

View(Enf_card)


library(dplyr)
library(stringr)

# 1) Limpiar comunidades y quedarnos solo con años numéricos
criminalidad_limpia <- datos_criminalidad_total %>%
  mutate(
    comunidad = str_replace(comunidad, "^En\\s+", "")   # quita "En "
  ) %>%
  filter(str_detect(Año, "^[0-9]{4}$"))                 # solo años tipo "2023"

# 2) Sumar los 4 trimestres por crimen, año y comunidad
crimen_anual <- criminalidad_limpia %>%
  group_by(comunidad, Año, Parámetro) %>%              # comunidad + año + tipo de delito
  summarise(
    Denuncias_anuales = sum(`Denuncias (Dato acumulados)`, na.rm = TRUE)
  )

View(crimen_anual)

secuestro_anual <- crimen_anual %>%
  filter(Parámetro == "Secuestro")

View(secuestro_anual)




