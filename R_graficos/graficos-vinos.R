library(tidyverse)
library(DataExplorer) #Más sobre este paquete en: https://cran.r-project.org/web/packages/DataExplorer/vignettes/dataexplorer-intro.html
library(ggrepel)


#Contexto de los datos: https://github.com/cienciadedatos/datos-de-miercoles/tree/master/datos/2019/2019-06-12

#Cargar datos:
vinos <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-06-12/vinos.csv")

View(vinos)

chile %>%
  filter(puntos > 90 & precio_mxn < 5000) %>%
  ggplot() +
  geom_boxplot(aes(provincia, precio_mxn, fill = provincia)) +
  theme(legend.position = "none") +
  labs(title = "Vinos", subtitle = "Precio y calidad")

#Explorar datos
DataExplorer::plot_bar(vinos) 
DataExplorer::plot_histogram(vinos)

#Filtrar por vinos chilenos (agregar columnas de precio en pesos MXN y ratio precio/calidad)
chile <-vinos%>%
  #filter(pais=="Argentina")%>%
  mutate(precio_mxn= precio*69.74) %>% #convertí a pesos mexicanos al cambio de 2020/06/19
  mutate(calidad_precio = precio_mxn/puntos) 

#Añadir etiqueta de nombre de vino a los que tengan más de 90 puntos y mejor relación calidad/precio por provincia
buenoybarato <- chile %>%
  filter(puntos > 90 & precio_mxn < 1000) %>% 
  group_by(pais) %>% 
  top_n(-1, calidad_precio) %>% 
  select(pais, titulo_resena, puntos) %>% 
  mutate(bueno_barato = gsub("\\s*\\([^\\)]+\\)","",as.character(titulo_resena))) #quité provincia

provinciasbyb <- unique(buenoybarato$pais)

vinos <- chile %>% 
  left_join(buenoybarato) %>% 
  filter(pais %in% provinciasbyb)

vinos <- unique(vinos)

View(vinos)
#x_limits <- c(3, NA)
ggplot(vinos, aes(puntos, precio_mxn))+
  geom_jitter(color = ifelse(is.na(vinos$bueno_barato), "#faced3", "#91101f"))+
  geom_label_repel(data= vinos, aes(x=puntos, y= precio_mxn, label=bueno_barato),
                   alpha = .8, size=2)+
  facet_wrap(~pais, ncol=3, scales = "free_y")+
  xlim(80, 100)+
  labs(title= "Vinos del mundo con mejor precio/puntaje", 
       subtitle = "puntaje > 90; precio < 1000", 
       y = "Precio en pesos argentinos", 
       x = "Puntuación 80-100", 
       caption = "Elaborado por Silvia Gutiérrez (@espejolento) \n Fuente: #datosdemiércoles \n https://github.com/cienciadedatos/datos-de-miercoles/tree/master/datos/2019/2019-06-12")+
  theme(plot.title = element_text(size=30, hjust=0,face="bold"), 
        plot.subtitle = element_text(size=25, hjust=0), 
        plot.caption = element_text(size=20, hjust = 1),
        axis.title.x = element_text(size = 20),
        axis.text.x = element_text(size = 15),
        axis.title.y = element_text(size = 20))

