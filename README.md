# Geocomputation: spatial data structure and mapping - Africa HDI and Tariff Data



**Problem**

Geographic data can be difficult to interpret when it is presented only in 
tables. Maps help reveal spatial patterns, regional differences, and the 
distribution of socioeconomic indicators across countries.

This project explores geospatial analysis in R by mapping Human Development 
Index (HDI) scores across Africa, comparing mapping techniques, visualising 
African subregions, and exploring the extraction and cleaning of tariff-related 
data from a webpage.



**Dataset**

- **Africa spatial dataset (`africa_sf.RData`):** Contains data for 50 African 
countries, including country names, subregions, GDP per capita (`gdpPercap`), 
Human Development Index (`HDI`), population growth (`pop_growth`), and 
geographic boundaries.
- **World geographic data:** Country-level spatial data obtained using 
`rnaturalearth` for exploring how external country-level data can be combined 
with geographic boundaries.
- **Tariff webpage data:** Data extracted from the New York Times' 2025 
tariff tracker. The extracted table contained product categories, tariff rates, 
and status information.

The African country dataset uses simple features (`sf`) to represent geographic 
boundaries. The geometry column contains multipolygons, and its coordinates are 
stored in a projected coordinate reference system rather than directly in 
degrees of longitude and latitude.



**Methods**

- Inspected the structure and geometry of the African spatial dataset.
- Examined coordinate reference systems and spatial geometry types.
- Created and compared HDI maps using base R, `tmap`, and `ggplot2`.
- Classified HDI values into high, medium, and low categories for thematic 
mapping.
- Visualised African subregions and arranged maps for comparison.
- Used `rvest` to extract tariff information from the New York Times tariff 
tracker.
- Cleaned and reorganised the extracted tariff table, including its product 
categories, rates, and status fields.



**Tools**

- **R and RStudio:** Data analysis, geospatial processing, and visualisation.
- **sf:** Managing spatial data, geographic geometries, and coordinate 
reference systems.
- **tmap:** Creating thematic and choropleth maps.
- **ggplot2:** Producing customisable maps and visualisations.
- **dplyr:** Selecting, transforming, and cleaning data.
- **rvest:** Extracting HTML content and tables from webpages.
- **stringr:** Cleaning text and extracting status information.
- **rnaturalearth:** Obtaining country-level geographic boundaries.
- **RColorBrewer and viridis:** Supporting colour palettes for maps and 
visualisations.



**Key Insights and Outcomes**

The project demonstrated how geographic data can be used to communicate 
socioeconomic differences across countries and regions.

- Explored spatial data covering 50 African countries and their geographic 
boundaries.
- Compared three mapping approaches, identifying their different strengths for 
spatial visualisation and presentation.
- Produced maps illustrating HDI categories and African subregions.
- Successfully extracted and analysed tariff information from the 
New York Times tariff tracker in the knitted report.
- Examined the cleaning of tariff rates and status fields, highlighting the 
importance of checking transformed data against the original source.\


Overall, the project displays practical skills in spatial data exploration, 
coordinate reference systems, thematic mapping, data cleaning, and web scraping.
It also demonstrated how different visualisation tools can be selected 
according to the needs of a geospatial analysis.



**Project Outputs**

- HTML report documenting the analysis, code, explanations, and visualisations.
- Africa HDI choropleth map created using base R graphics.
- Africa HDI choropleth map created using `tmap`.
- Africa HDI map created using `ggplot2`.
- Categorised HDI map showing high, medium, and low values.
- African subregion map and side-by-side map comparison.
- An extracted and cleaned tariff table from the New York Times tariff tracker.
- R script containing the analysis code.
- README documenting the project, methods, findings, and setup requirements.



**Reproducibility**

The `africa_sf.RData` dataset contains the African country-level HDI data and 
spatial geometries used for the mapping analysis.

Install the required packages in R:

```r
install.packages(c(
  "sf", "ggplot2", "dplyr", "tmap", "viridis",
  "RColorBrewer", "rvest", "stringr",
  "rnaturalearth", "tidyverse"
))
```

Load the packages and the spatial dataset before conducting the analysis:

```r
library(sf)
library(ggplot2)
library(dplyr)
library(tmap)
library(viridis)
library(RColorBrewer)
library(rvest)
library(stringr)
library(rnaturalearth)
library(tidyverse)
library(rnaturalearthdata)
library(countrycode)
library(tmaptools)
library(plotly)
library(leaflet)

load("africa_sf.RData")
```

The mapping analysis can then be carried out in RStudio by inspecting the 
spatial data, creating the maps, classifying HDI values, and comparing African 
subregions.

The tariff-scraping component requires internet access and an accessible 
webpage containing the relevant data. If the original webpage restricts 
automated access or changes its structure, a publicly accessible alternative 
data source may be needed to reproduce that part of the analysis.




