## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------
library(sf)
library(ggplot2)
library(dplyr)
library(tmap)
library(viridis)
library(RColorBrewer)
library(leaflet)
library(stringr)
library(plotly)
library(leaflet)




## ----warning=FALSE, echo=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------

load("africa_sf.RData")



## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------
colnames(africa)
glimpse(africa)
st_geometry_type(africa)


## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------
st_crs(africa)



## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------

table(st_is_valid(africa))
africa <- st_make_valid(africa)

plot(africa["HDI"],reset = FALSE,
     main = "Human Development Index (HDI) 
     across Africa",
     col = viridis::viridis(10),
     axes = TRUE,
     key.pos = 4)


plot(st_geometry(africa[is.na(africa$HDI), ]), col = "grey90", add = TRUE)



## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------
tmap_mode("plot")

tm_shape(africa) +
  tm_polygons(col = "HDI", palette = "blue") +
  tm_layout (main.title = "Human Development Index (HDI) 
     across Africa",
     main.title.size = 1.2,
     main.title.position = "center")



## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(africa) +
  geom_sf(aes(geometry = geom, fill = HDI)) +
  scale_fill_viridis_c(option = "Y1GnBu", direction = - 1, name = "HDI",
                        breaks = c(0, 0.3, 0.4, 0.5, 0.6, 0.7),
    labels = c("Less than 0.3",
               "0.3 - 0.4",
               "0.4 - 0.5",
               "0.5 - 0.6",
               "0.6 - 0.7",
               "More than 0.7"),
    guide = guide_colourbar(reverse = TRUE)) +
  theme_minimal() +
  labs(title = "Human Development Index (HDI) 
     across Africa") +
    theme(
    plot.title = element_text (face = "bold", size = 10, colour = "black", 
    hjust = 0.5))




## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------

tmap_mode("plot")

hdi_map <- 
tm_shape(africa) +
  tm_polygons(col = "HDI", 
              palette = c("#d73027", "#fee08b", "#1a9850"), 
              style = "fixed",
              breaks = c(0, 0.55, 0.7, 0.72),
              labels = c("Low (HDI below 0.55)", 
                         "Medium (HDI between 0.55 and 0.7)",
                         "High (HDI above 0.7)"),
                title = "HDI Level") +
  tm_layout (main.title = "Human Development Index (HDI) across Africa",
     main.title.size = 1,
     main.title.position = "center",
     legend.title.size = 1.2,
     legend.text.size = 0.9)

hdi_map



## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------

tmap_mode("plot")

subreg_map <-
  tm_shape(africa) +
  tm_polygons(
    col = "subregion",
    palette = "Set3",
    title = "Various Subregions"
  ) +
  tm_layout(
    main.title = "Subregions of Africa",
    main.title.size = 1.5,
    main.title.position = "center",
    legend.title.size = 1.2,
    legend.text.size = 0.9,
    frame = FALSE
  )
  
subreg_map

tmap_arrange(subreg_map, hdi_map)


## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------

library(dplyr)
library(rvest)

url<- 
"https://www.nytimes.com/interactive/2025/business/economy/trump-tariff-tracker.html?unlocked_article_code=1.a08.lGLs.vdMzuO07C8q5=url-share" 

trump_table <- url %>% 
read_html() %>% 
html_element("table") %>% 
html_table(fill = TRUE) 

trump_table %>% 
head(10)


## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------

library(stringr)

status_1<- c("New rateimposed", "Deal rate", "Baselinetariff", "Upcomingdeadline")

trump_table_clean <- trump_table %>%
rename(Products = 1) %>%
  select(-matches("^[sS]tatus$")) %>% 
mutate(
across(-Products,~ gsub("\\*","", .x)), 
across(-Products,~ na_if(.x, "—")), 
across(-Products, as.numeric),
Status = str_extract(Products, str_c(status_1, collapse = "|")),
Products = str_trim(str_remove_all(Products, str_c(status_1, collapse = "|"))))

trump_table_clean





## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------

url <- "https://www.nytimes.com/interactive/2025/business/economy/trump-tariff-tracker.html?unlocked_article_code=1.a08.lGLs.vdMzuO07C8q5=url-share"

trump_table <- url %>% 
read_html() %>% 
html_element("table") %>% 
html_table(fill = TRUE) 

trump_table 


status_1<- c("New rateimposed", "Deal rate", "Baselinetariff", "Upcomingdeadline")

trump_table_clean <- trump_table %>%
rename(Products = 1) %>%
  select(-matches("^[sS]tatus$")) %>% 
mutate(
across(-Products,~ gsub("\\*","", .x)), 
across(-Products,~ na_if(.x, "—")), 
across(-Products, as.numeric),
Status = str_extract(Products, str_c(status_1, collapse = "|")),
Products = str_trim(str_remove_all(Products, str_c(status_1, collapse = "|"))))

trump_table_clean

head(trump_table, 10)
head(trump_table_clean, 10)


setdiff(trump_table$countries, trump_table_clean$countries)



## ----warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------

status_1<- c("New rateimposed", "Deal rate", "Baselinetariff", "Upcomingdeadline")

trump_table_clean <- trump_table %>%
rename(Products = 1) %>%
  select(-matches("^[sS]tatus$")) %>% 
mutate(
across(-Products,~ gsub("\\*","", .x)), 
across(-Products,~ na_if(.x, "—")), 
across(-Products, as.numeric),
Status = str_extract(Products, str_c(status_1, collapse = "|")),
Products = str_trim(str_remove_all(Products, str_c(status_1, collapse = "|"))))

trump_table_clean


url <- "https://www.nytimes.com/interactive/2025/business/economy/trump-tariff-tracker.html?unlocked_article_code=1.a08.lGLs.vdMzuO07C8q5=url-share"

all_tables <- url %>%
  read_html() %>%
  html_elements("table") %>%
  lapply(html_table, fill = TRUE)
  
all_tables

length(all_tables)


status_1<- c("New rateimposed", "Deal rate", "Baselinetariff", "Upcomingdeadline")

trump_table_2 <- all_tables[[2]] %>% 
  rename(Countries = 1) %>%
  select(-matches("^[sS]tatus$")) %>%
mutate(
across(-Countries,~ gsub("\\*","", .x)), 
across(-Countries,~ na_if(.x, "—")), 
across(-Countries, as.numeric),
Status = str_extract(Countries, str_c(status_1, collapse = "|")),
Countries = str_trim(str_remove_all(Countries, str_c(status_1, collapse = "|"))))

trump_table_2

status_summary <- trump_table_clean %>%
  group_by(Status) %>% 
  summarise(
    Avg_Product_Rate = mean(across(where(is.numeric)), na.rm = TRUE)
  )

merged_trump_data <- left_join(trump_table_2, status_summary, by = "Status")

glimpse(merged_trump_data)


library(rnaturalearthdata)
library(countrycode)

merged_trump_data_country_codes <- merged_trump_data %>% 
 mutate(
    iso_a3 = countrycode(
      Countries, 
      origin = "country.name",
      destination = "iso3c"
    )
  )

library(rnaturalearth)

world <- ne_countries(scale = "medium", returnclass = "sf")

world

world_merged_data <- left_join(world, merged_trump_data_country_codes,
                               by = "iso_a3")

world_merged_data

class(world_merged_data)

library(tmaptools)

tmap_mode("view")

tm_shape(world_merged_data) +
  tm_polygons(
    "Total",
    title = "Total Tariff (%)",
    palette = "plasma",
    id = "Countries",
    popup.vars = c("Countries", "Total", "Status"),
    border.col = "white",
    lwd = 0.4,
    alpha = 0.9
    ) +
  tm_layout(
    main.title = "Global Trump Tariff Rates on Countries (Total)",
    main.title.size = 1.2,
    main.title.position = "center",
    legend.outside = TRUE,
    frame = FALSE)
  



