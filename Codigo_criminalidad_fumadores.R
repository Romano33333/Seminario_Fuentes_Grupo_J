
### Importación de datos de criminalidad por comunidad autonomica
install.packages("tidyverse")
install.packages("jsonlite")
library(tidyverse)
library(stringr)
library(jsonlite)
library(tidyr)
library(readxl)
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


# -------------------------------------------------------------
# Eliminación de archivos antiguos de fumadores
# -------------------------------------------------------------

# Carpeta donde se almacenan los datos de fumadores
carpeta_fumadores <- "INPUT/DATA/FUMADORES"

# Listamos todos los archivos JSON presentes en la carpeta
archivos_json_antiguos <- list.files(
  path = carpeta_fumadores,
  pattern = "\\.json$",
  full.names = TRUE
)

# Eliminamos todos los JSON previos
file.remove(archivos_json_antiguos)

# Confirmación en consola
cat("Archivos JSON eliminados:\n")
print(archivos_json_antiguos)

# -------------------------------------------------------------
# Incorporación de nuevos archivos CSV de fumadores
# -------------------------------------------------------------

# Ruta local donde descargaste los nuevos datos
archivo_nuevo <- "C:\\Users\\Usuario\\Desktop\\UBU\\5º SEMESTRE\\FUENTES BIOMÉDICAS\\fumadores_comunidad_hasta_2023.xlsx"   # <-- SUSTITUIR

# Carpeta destino dentro del proyecto
carpeta_fumadores <- "INPUT/DATA/FUMADORES"

# Copiamos el archivo nuevo a la carpeta del proyecto
file.copy(from = archivo_nuevo, to = carpeta_fumadores, overwrite = TRUE)

cat("Archivo CSV nuevo copiado correctamente a la carpeta FUMADORES\n")
## --- Comprobación del contenido final ---

s
