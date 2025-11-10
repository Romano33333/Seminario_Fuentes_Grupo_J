
### Importación de datos de criminalidad por comunidad autonomica
install.packages("tidyverse")
install.packages("jsonlite")
library(tidyverse)
library(stringr)
library(jsonlite)
library(tidyr)
ruta_criminalidad<-"INPUT/DATA/CRIMINALIDAD"
archivos <- list.files(path = ruta_criminalidad, pattern = "*.csv", full.names = TRUE)
archivos
datos_criminalidad_total <- criminalidad_total %>%
  mutate(
    comunidad = archivo %>% 
      basename() %>%                                  # Quita la ruta, deja solo el nombre del archivo
      str_remove("\\.csv$") %>%                       # Quita la extensión .csv
      str_to_lower() %>%                              # Pasa todo a minúsculas
      str_extract("(?<=en_).*") %>%                   # Toma lo que viene después de 'en_'
      str_replace_all("_+", " ") %>%                  # Sustituye múltiples "_" por espacios
      str_replace_all("-", " ") %>%                   # Sustituye guiones por espacios
      str_squish() %>%                                # Limpia espacios duplicados
      str_to_title()                                  # Pone mayúscula inicial en cada palabra
  )
view(datos_criminalidad_total)
criminalidad_total
glimpse(datos_criminalidad_total)
### Importación de datos de fumadores por comunidad autonomica
ruta_fumadores<-"INPUT/DATA/Fumadores"
archivos_fumadores <- list.files(path = ruta_fumadores, pattern = "*.json", full.names = TRUE)
datos_fumadores_total <- archivos_fumadores %>%
  set_names() %>%
  map_dfr(~ {
    texto <- readLines(.x, encoding = "UTF-8")        # lee el texto en UTF-8
    texto <- sub("\ufeff", "", texto)                 # elimina el BOM si existe
    fromJSON(paste(texto, collapse = ""))             # parsea el JSON limpio
  }, .id = "archivo")
datos_fumadores_total <- fumadores_total %>%
  mutate(
    comunidad = archivo %>% 
      basename() %>% 
      str_remove("\\.json$") %>% 
      str_to_lower() %>% 
      str_extract("(?<=en_).*") %>% 
      str_replace_all("_+", " ") %>% 
      str_replace_all("-", " ") %>% 
      str_squish() %>% 
      str_to_title()
  )
fumadores_total <- fumadores_total %>%
  unnest_wider(Respuesta, names_sep = "_")
view(datos_fumadores_total)
glimpse(datos_fumadores_total)
