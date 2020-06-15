#install.packages(tidyverse)
install.packages(c("choroplethr", "choroplethrMaps", 
                   "gapminder"))

library(tidyverse)
library(choroplethr)
library(choroplethrMaps)
library(gapminder)


#### Mapear datos con el paquete choropleth

unique(gapminder$year)
datos_limpios <- gapminder %>%
  rename(region = country, #cambiar "country" a "region"
         value = lifeExp)%>% #cambiar "lifeExp" a "value"
  mutate(region = tolower(region)) %>%
  mutate(region = recode(region, #aquí se cambian los nombres de los datos de gapminder a los nombres de los países en el paquete de chorolopleth
                         "united states"    = "united states of america",
                         "congo, dem. rep." = "democratic republic of the congo",
                         "congo, rep."      = "republic of congo",
                         "korea, dem. rep." = "south korea",
                         "korea. rep."      = "north korea",
                         "tanzania"         = "united republic of tanzania",
                         "serbia"           = "republic of serbia",
                         "slovak republic"  = "slovakia",
                         "yemen, rep."      = "yemen"))



datos_1952 <- datos_limpios %>% 
  filter(year == 1952) #filtrar los datos de 1952

datos_2007 <- datos_limpios %>% 
  filter(year == 2007) #filtrar los datos de 2007

#Con los colores de default
choroplethr::country_choropleth(datos_1952)

#Con los colores de tu elección (paleta YlOrRd)
choroplethr::country_choropleth(datos_2007,
                                num_colors=9) +
  scale_fill_brewer(palette="YlOrRd") +
  labs(title = "Esperanza de vida por país",
       subtitle = "Datos de Gapminder (2007)",
       caption = "Fuente: https://www.gapminder.org",
       fill = "Edad")