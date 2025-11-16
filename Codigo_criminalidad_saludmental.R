library(readr)
library(dplyr)

carpeta <- "INPUT/DATA/Salud_Mental"
archivos <- list.files(carpeta, pattern = "_UTF8\\.csv$", full.names = TRUE)

salud_mental <- read_delim(archivos, delim = ";", id = "archivo",
                           trim_ws = TRUE, show_col_types = FALSE)

View(salud_mental)



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

library(dplyr)
library(readr)


# 1) Arreglar nombres de comunidad en SALUD MENTAL ------------------------

salud_mental2 <- salud_mental %>%
  rename(Comunidad = `Comunidades y Ciudades Autónomas`) %>%
  mutate(
    Comunidad = case_when(
      Comunidad == "Andalucía"                   ~ "Andalucia",
      Comunidad == "Aragón"                      ~ "Aragon",
      Comunidad == "Asturias, Principado de"     ~ "Principado De Asturias",
      Comunidad == "Balears, Illes"              ~ "Islas Baleares",
      Comunidad == "Castilla-La Mancha"          ~ "Castilla La Mancha",
      Comunidad == "Castilla y León"             ~ "Castilla Y Leon",
      Comunidad == "Comunitat Valenciana"        ~ "Comunidad Valenciana",
      Comunidad == "Madrid, Comunidad de"        ~ "Comunidad De Madrid",
      Comunidad == "Murcia, Región de"           ~ "Region De Murcia",
      Comunidad == "Navarra, Comunidad Foral de" ~ "Comunidad Foral De Navarra",
      Comunidad == "País Vasco"                  ~ "Pais Vasco",
      Comunidad == "Rioja, La"                   ~ "La Rioja",
      TRUE ~ Comunidad
    )
  )


salud_resumen <- salud_mental2 %>%
  filter(
    `Total Nacional` == "Total",
    `Número medio`   == "Media",
    Sexo %in% c("AMBOS SEXOS","MUJERES","HOMBRES")
  ) %>%
  select(
    comunidad   = Comunidad,
    Sexo,
    SaludMental = Total
  ) %>%
  mutate(
    SaludMental = parse_number(SaludMental)  # pasar a número
  )


# 2) Resumen de CRIMINALIDAD por comunidad --------------------------------

criminalidad_resumen <- datos_criminalidad_total %>%
  mutate(
    comunidad = str_replace(comunidad, "^En\\s+", "")  # quita "En " al inicio
  ) %>%
  group_by(comunidad) %>%
  summarise(
    Criminalidad = mean(`Denuncias (Dato acumulados)`, na.rm = TRUE)
  )

# 3) Unimos criminalidad + salud mental por comunidad
datos_resumen <- left_join(
  criminalidad_resumen,
  salud_resumen,
  by = "comunidad"
)

View(datos_resumen)

#ver la comunuidad con mayor y menor tasa de salud mental y ver si hay relación con la criminalidad para ambos sexos
datos_ambos <- datos_resumen %>% 
  filter(Sexo == "AMBOS SEXOS")
comparacion <- datos_ambos %>%
  filter(
    SaludMental == max(SaludMental, na.rm = TRUE) |
      SaludMental == min(SaludMental, na.rm = TRUE)
  )

View(comparacion)
















