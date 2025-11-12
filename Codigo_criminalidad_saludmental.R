library(readr)
Datos_crimen_salud_mental <- read_delim("INPUT/DATA/Salud_Mental", 
                      delim = ";", escape_double = FALSE, trim_ws = TRUE)
