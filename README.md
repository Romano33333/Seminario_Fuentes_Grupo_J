# Seminario_Fuentes_Grupo_J
Análisis Estadístico de Salud mental , Criminalidad, Fumadores y enfermedades cardiovasculares  en España
Proyecto final — Seminario de Datos
Descripción del proyecto

Este proyecto desarrolla un análisis estadístico completo sobre la relación entre salud mental, criminalidad, tabaquismo,enfermedades cardiovasculares y factores demográficos en las Comunidades Autónomas de España.
Se integran, limpian y analizan múltiples fuentes oficiales (INE, Ministerio del Interior) con el objetivo de comprender:

La relación entre distintos tipos de delitos y los problemas de salud mental.

Qué comunidades presentan mayores tasas ajustadas por población.

Si hábitos como el tabaquismos influyen en indicadores de criminalidad.

Qué comunidades muestran mayor vulnerabilidad combinando indicadores de criminalidad y salud.

Estructura del repositorio
Proyecto
 ├── Seminario_final.Rmd      # Documento principal del análisis
 ├── Seminario_final.html     # Informe generado (si está incluido)
 ├── input/data/              # Archivos de datos utilizado
 ├── README.md                # Documento informativo

Objetivos del análisis

- Analizar la criminalidad por comunidades autónomas, tanto total como por tipos delictivos específicos.

- Estudiar problemas de salud mental y su relación con la criminalidad.

- Analizar la relación entre la tasa de fumadores diarios y la criminalidad.

- Calcular tasas por 100.000 habitantes integrando los datos poblacionales autonómicos.

Evaluar correlaciones entre:

- Delitos y salud mental

- Delitos y tabaquismo

Salud mental y criminalidad ajustada

Crear visualizaciones claras mediante ggplot2.

Metodología
1. Limpieza y preparación

- Corrección de nombres de comunidades mediante str_replace.

- Manejo de valores faltantes con na.rm = TRUE.

- Agrupación de valores por comunidad y por parámetro delictivo.

- Integración de múltiples fuentes mediante left_join.

2. Cálculo estadístico

- Medias autonómicas de cada variable.

- Tasas normalizadas por población.

- Cálculo de correlaciones y análisis de regresión.

- Comparaciones entre comunidades y parámetros delictivos.

3. Visualización

Se generaron gráficos representando:

- Criminalidad vs salud mental

- Criminalidad vs fumadores diarios

- Criminalidad vs enfermedades cardiovasculares

- Series temporales por comunidad

-Tendencias lineales y comparativas autonómicas

Principales resultados
1. Correlación entre salud mental y criminalidad

Se observaron correlaciones positivas moderadas en algunos delitos, entre ellos:

Homicidios dolosos y asesinatos consumados

Tráfico de drogas

Secuestro

Sustracción de vehículos

Esto indica que las comunidades con mayor criminalidad en estas categorías tienden también a presentar cifras más elevadas de problemas de salud mental.

2. Comunidades destacadas

- Cataluña y Comunidad de Madrid muestran un ratio salud mental/criminalidad cercano a 1, lo que indica una fuerte relación proporcional.

- Comunidades con menor población, como La Rioja, Navarra o Cantabria, presentan valores más bajos y estables.

3. Relación entre fumadores y criminalidad

- La correlación es baja a moderada de forma general, aunque se observan patrones similares en regiones con indicadores sociales más desfavorables.
- No se detecta un patrón claro de causalidad, pero sí coincidencias contextuales.

Fuentes de datos

Criminalidad autonómica (Ministerio del Interior):
https://www.epdata.es/datos/crimen-espana-hoy-asesinatos-robos-secuestros-otros-delitos/4/espana/106

Ataques al corazón (INE):
https://www.ine.es/jaxi/Datos.htm?tpx=46687#_tabs-tabla

Fumadores diarios por comunidad (INE):
https://www.ine.es/jaxiT3/Datos.htm?t=69667#_tabs-tabla

Salud mental (INE):
https://www.ine.es/jaxi/Datos.htm?path=/t15/p419/a2011/p01/l0/&file=01056.px#_tabs-tabla

Población por comunidad (INE):
https://www.ine.es/jaxiT3/Tabla.htm?t=2853

Conclusiones generales

Algunos delitos graves muestran relación moderada con la prevalencia de problemas de salud mental, lo que sugiere un entorno social más tensionado.

El tabaquismo no parece ser un predictor significativo de criminalidad, aunque sí aparecen patrones comunes en regiones con peores indicadores sociales.

Las tasas ajustadas por población permiten comparaciones más fiables entre comunidades y muestran que Cataluña y Madrid presentan los niveles más altos tanto en criminalidad total como en prevalencia de problemas de salud mental.

La combinación de datos sociales, sanitarios y criminológicos permite obtener una visión global más precisa de las diferencias estructurales entre comunidades.

Tecnologías utilizadas

R

tidyverse

ggplot2

dplyr

stringr

knitr y rmarkdown
