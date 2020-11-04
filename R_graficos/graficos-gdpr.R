### Task:

#Visualising per-country GDPR fines

#Full readme for task available within the **TidyTuesday** github repository, available [here](https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-04-21/readme.md)



#### Installing and loading libraries
#install.packages("ggtext")
library(ggtext)  #para anotar
library(sf)  #for maps
library(tmap) #for interactive maps using Rshiny
library(sp) #required for rgeos
library(rgeos) #required for rnaturalearthhires
library(rnaturalearthhires) # for dealing with sf data
??rnaturalearthhires
#library(tmaptools)
library(leaflet)
library(dplyr)
library(skimr) #para inspeccionar datos
library(scales)
library(tidyverse)
library(here)
devtools::install_github("jakelawlor/PNWColors") # stealing colour palette from @jakelawlor
library(PNWColors)



#### Obtaining and inspecting data


## obtaining data:
gdpr_violations <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-21/gdpr_violations.tsv')
## viewing
gdpr_violations %>%
  view()
# Confirming distinct countries
gdpr_violations %>%
  distinct(name) %>%
  view()  #25 distinct European countries
# browsing the data
gdpr_violations %>%
  skim() #no missing vals




#### Preparing data


# read in country file
countries <-
  read_csv(here("2020/2020-Apr-GDPR_fines", "country_file.csv"))
# get countries in gdpr dataset
gdpr_countries <- gdpr_violations %>%
  distinct(name) %>%
  pull()
## DISCLAIMER ##
#(stole/adapted a lot of the next few bits of code from @gkaramanis!)
# Obtaining filtered country list with geometry info for mapping to geom_sf
filtered_countries <-
  ne_countries(
    country = c(gdpr_countries, "Czechia"),
    scale = "large",
    returnclass = "sf"
  ) %>%
  select(name, geometry) %>%
  mutate(name = replace(name, name == "Czechia", "Czech Republic")) %>%
  inner_join(countries) # adding in lat and long info
# checking
filtered_countries %>%
  view()
filtered_countries %>%
  dim() #25 entries
# generating total fine info to plot on map
prices <- gdpr_violations %>%
  group_by(name) %>%
  mutate(
    price_sum = sum(price),
    # calculating total fine per country
    price_legend = case_when(
      price_sum == 0 ~ paste0("No Fine"),
      price_sum > 0 & price_sum <= 10000 ~ paste0("0-10K"),
      price_sum > 10000 & price_sum <= 50000 ~ paste0("10K-50K"),
      price_sum > 50000 & price_sum <= 100000 ~ paste0("50K-100K"),
      price_sum > 100000 & price_sum <= 500000 ~ paste0("100K-500K"),
      price_sum > 500000 & price_sum <= 1000000 ~ paste0("500K-1M"),
      price_sum > 1000000 & price_sum <= 10000000 ~ paste0("1M-10M"),
      price_sum > 10000000 ~ paste0(">10M"))) %>% # creating discrete labels for chart
  select(name, price_sum, price_legend) %>% # filtering to only columns interested in
  distinct() # filtering out duplicate rows - so 25 unique entries
# reforming prices ready for chart
# joining price info with geom info
for_map <- filtered_countries %>%
  inner_join(prices)
# checking
for_map %>%
  view()
# checking in order of price of fine
for_map %>%
  arrange(price_sum) %>%
  view()
# filtering countries with extreme fine totals for ggtext
for_map_extremes <- for_map %>%
  filter(price_legend == ">10M") %>%  #filtering to countries with largest fines
  mutate(price_label = paste0(name, "\n", substr(
    as.character(price_sum), start = 1, stop = 2
  ), "M", sep = "")) %>% #creating new label with more precise fine totals
  select(name, latitude, longitude, price_label)
# creating colour palette for vis
# background_col<-pnw_palette("Winter", n=5, type="discrete")
map_colours <-
  c(
    "#d8b365",
    "#f5f5f5",
    "#CCCCCC",
    "#999999",
    "#81a9ad",
    "#537380",
    "#33454e",
    "darkred"
  )
# mapping price labels to factor levels to control order of legend colours
for_map$price_legend <-
  factor(
    for_map$price_legend,
    levels = c(
      "No Fine",
      "0-10K",
      "10K-50K",
      "50K-100K",
      "100K-500K",
      "500K-1M",
      "1M-10M",
      ">10M"
    )
  ) 





#### Plotting data


# generating geom_sf plot
gdpr_plot <- ggplot(data = for_map) +
  geom_sf(aes(geometry = geometry, fill = price_legend),
          colour = "white",
          size = 0.25) +
  scale_fill_manual(values = map_colours) +
  theme_void() +
  geom_text(
    data = for_map_extremes %>%
      filter(name %in% c("France", "Germany")),
    aes(
      x = as.numeric(longitude) + 0.65,
      y = as.numeric(latitude) + 0.5,
      label = price_label
    ),
    family = "Times New Roman Bold",
    hjust = 0.5,
    size = 3,
    colour = "#CCCCCC"
  ) +
  geom_text(
    data = for_map_extremes %>%
      filter(name %in% c("Austria", "Italy")),
    aes(
      x = as.numeric(longitude) + 0.7,
      y = as.numeric(latitude) + 0.4,
      label = price_label
    ),
    family = "Times New Roman Bold",
    hjust = 0.5,
    size = 2,
    colour = "#999999"
  ) +
  labs(title = "Total GDPR Fines Accumulated \nper European Country",
       subtitle = "Graphic by: Jodie Lord | @jodielord5") +
  theme(
    plot.title = element_text(
      size = 30,
      colour = "white",
      family = "Times New Roman Bold"
    ),
    plot.subtitle = element_text(
      size = 15,
      colour = "#CCCCCC",
      family = "Times New Roman"
    ),
    legend.title = element_blank(),
    legend.position = "bottom",
    legend.text = element_text(
      color = "white",
      size = 12,
      family = "Times New Roman"
    ),
    plot.background = element_rect(fill = "#333333", color = "#333333"),
    plot.margin = margin(20, 20, 20, 20)
  ) +
  coord_sf(
    xlim = c(-27.5, 37.5),
    ylim = c(32.5, 82.5),
    expand = FALSE
  )




#### Saving plot


# saving plot
ggsave(
  here("2020/2020-Apr_GDPR_fines", "OUTPUT_STATIC_GDPR_fines.png"),
  plot = gdpr_plot,
  width = 17,
  height = 11,
  units = c("in", "cm", "mm"),
  dpi = 320,
)
