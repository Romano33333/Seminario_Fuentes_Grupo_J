
### Importación de datos de criminalidad por comunidad autonomica
install.packages("tidyverse")
install.packages("jsonlite")
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
glimpse(datos_criminalidad_total)

#-------------------------------------------------------------
### Importación de datos de fumadores por comunidad autonomica
#-------------------------------------------------------------
f <- "INPUT/DATA/Fumadores/poblacion_que_fuma_a_diario_en_andalucia.json"
raw_text <- readLines(f, warn = FALSE, encoding = "UTF-8")
raw_text <- paste(raw_text, collapse = "")
raw_text <- sub("\ufeff", "", raw_text)  # eliminar BOM si existe

# 2. Parsear el JSON
x <- fromJSON(raw_text)

# 3. Explorar la estructura
str(x, max.level = 7)  # ver los niveles principales del JSON

folder <- "INPUT/DATA/Fumadores"

# Lista de todos los archivos JSON
files <- list.files(folder, pattern = "\\.json$", full.names = TRUE)

# Función para procesar un JSON
procesar_json <- function(f) {
  # Leer y parsear JSON
  raw_text <- readLines(f, warn = FALSE, encoding = "UTF-8")
  raw_text <- paste(raw_text, collapse = "")
  raw_text <- sub("\ufeff", "", raw_text)
  x <- fromJSON(raw_text)
  
  # Extraer comunidad desde el nombre del archivo
  comunidad <- f %>%
    basename() %>%
    str_remove("\\.json$") %>%
    str_to_lower() %>%
    str_extract("(?<=en_).*") %>%
    str_replace_all("_+", " ") %>%
    str_squish() %>%
    str_to_title()
  
  # Tomar la columna Datos de cada fila en Metricas$Datos
  lista_df <- x$Respuesta$Datos$Metricas$Datos
  
  # Unir todos los data.frames internos
  bind_rows(lapply(lista_df, function(d) {
    tmp <- d$Datos  # esto sí es un data.frame con Agno y Valor
    data.frame(
      comunidad = comunidad,
      anio = tmp$Agno,
      fumadores_diarios = tmp$Valor,
      stringsAsFactors = FALSE
    )
  }))
}

# Aplicar a todos los archivos y unir
datos_fumadores_total <- bind_rows(lapply(files, procesar_json))

# Ver resultado
datos_fumadores_total
