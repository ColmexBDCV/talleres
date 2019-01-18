# Primer taller de R en BiblioColmex
# Taller de introducción al tidyverse a cargo de @espejolento y Rodrigo Cuéllar

#TIP: Recuerden que si la codificación no es correcta tienen que ir a File - Reopen with Encoding 
#y seleccionar UTF-8

####### LOS PAQUETES ########

# Cuando programamos lo más común es escribir una serie de de instrucciones (funciones) 
# para que la computadora haga "algo" sobre algún objeto
# Un paquete es un conjunto de este tipo de instrucciones que alguien ha empaquetado 
# para un propósito en específico
# Hay funciones que ya están integradas en R por default.
# Esta es una lista de todas las funciones que ya tienes cargadas sólo por tener R: 
#https://stat.ethz.ch/R-manual/R-devel/library/base/html/00Index.html
# Además de este paquete base hay otros conjuntos que están pre-cargados, 
# como "utils" (más abajo veremos un ejemplo)

#### Instalar paquetes ####
# En este curso vamos a usara dos paquetes que no están cargados por default:#
# Para esto usamos la función precargada de "utils" llamada "install.packages"
#install.packages("tidyverse")
#install.packages("readr")

#### Variable vs Funcion ####

#Una variable es uina "cajita" en la que se guarda cierto contenido y se ve asi:
# a = 1
#Aqui la cajita "a" tiene el contenido "1"


#Una funcion es una coleccion de instrucciones que se puede invocar, 
#la forma de invocar es escribiendo el nombre de la funcion seguida de parentesis, que puede o no contener parametros

#Una funcion se ve asi
#getwd() -- la funcion se llama getwd y la forma en que se invoca es con un parentesis sin parametros


##### FUNCIONES #####

# sum 
# a = c(1, 2, 3)
# sum(a) -- igual a 6
#length(a) -- igual a 3


?readr
?install.packages

#### "Llamar" los paquetes que vas a usar ####
# Los paquetes sólo se instalan una vez en R después ya sólo se "llaman", esto se hace con la función "library"
library(readr) #readr es un paquete para leer de forma fácil csv, tsv, etc. (más info: https://cran.r-project.org/web/packages/readr/index.html)
library(tidyverse) #tidyverse es un conjunto de paquetes para  de datos (más info: https://www.tidyverse.org/)
#aquí estamos llamando a todos los paquetes que lo conforman. Nosotros trabajaremos específicamente con dplyr y ggplot

#### PRIMER RECORRIDO ####
# ¿Por qué hay un hashtag antes este texto?
# R usa el signo # para añadir comentarios, para que tú y otros puedan enteder de qué se trata el código. Los comentarios son texto que no se considera código, por lo tanto no tendrán influencia en tus operaciones.
## Obtener directorio donde se encuentra uno
getwd()

## Si el directorio actual no es donde están tus datos, cambiarlo al espacio donde sí estén
#setwd("/home/rod/Dropbox/Colmex/meta-tesis/Curso R")

setwd("C:/Users/lap-bdcv/Downloads/Curso R")

?read_csv

## CARGAR SET DE DATOS
cee = read_csv("archivos_bibliografxs_openrefine/cee_limpieza.csv")

cee[is.na(cee)] = 0

dim(cedua) #para saber cuantas filas y columnas tiene nuestro data frame usamos la funcion dim()
View(cedua) #para abrir tu tabla se puede usar la funcion View()
columnas = colnames(cee) #para saber el nombre de tus columnas, usa la funcion colnames()
columnas

annios = cedua$Año
unique(annios)

dosmildoce = subset(cedua, Año == 2012) #RECUERDEN! Un = significa asignacion y doble == significa comparacion
mayorigualque_dosmildoce = subset(cedua, Año >= 2012)

#### A continuacion variables de autor y anio, autor son ambos apellidos seguidos de anio en formato YYYY

sanchezpena_citasmayorquedos <- subset(cedua, (Autor == "Landy Lizbeth Sánchez Peña") & (`Validadas 2017` >2))


cedua$`Validadas 2017`
#Cambiar NA a 0
cee[is.na(cee)] = 0
 
# MIRADA INICIAL A LOS DATOS

# cedua # el paquete que descargamos contiene un objeto con la base de datos. Al escribir su nombre se imprimen las 10 primeras líneas y la cantidad de columnas qu caben en el ancho de página.
View(cedua) # muestra la base completa en otra pestaña
str(cedua) # imprime información sobre el dataset y las variables
glimpse(cedua) # imprime las primeras observaciones de cada variable
head(cedua) # imprime las seis primeras líneas
tail(cedua) # imprime las últimas seis líneas (muy útil para chequear si la base que cargamos está completa)



#Creamos un vector con los nombres de los campos para nuestros resultados
campos <- c("Total de artículos","Artículos con nuevas citas en 2017","Total de nuevas citas 2017",
            "Artículos con citas validadas en 2017","Total de citas validadas 2017","Reconocidas vs validadas",
            "Total de errores 2017","Porcentaje de artículos con citas reconocidas2",
            "Porcentaje de artículos con citas validadas")

total_articulos = nrow(cee)

articulos_nuevas_citas_2017 = length(cee$`Nuevas 2017` [cee$`Nuevas 2017`>0])

total_nuevas_citas_2017 <- sum(cee$`Nuevas 2017`[cee$`Nuevas 2017`>0])

articulos_citas_validadas_2017 = length(cee$`Validadas 2017`[cee$`Validadas 2017`>0])
articulos_citas_validadas_2017

total_citas_validadas_2017 = sum(cee$`Validadas 2017`[cee$`Validadas 2017`>0])




#Comenzamos a crear Variables y asignarles resultados



#cuenta el numero de filas (en nuestro caso el total de articulos)
total_articulos = nrow(cedua)


#Cuenta el total de citas nuevas reportadass en 2017

length(cedua$`Nuevas 2017`[cedua$`Nuevas 2017`>0])

articulos_nuevas_citas_2017
#Suma todas las nuevas citas de todos los articulos en 2017
total_nuevas_citas_2017 <- sum(cedua$`Nuevas 2017`)


####### EJERCICIOS PARA LXS BIBLIÓGRAFXS ####################



#Cuenta los articulos con citas nuevas en 2017
articulos_con_citas_nuevas_2017 <- length(cedua$`Nuevas 2017`[cedua$`Nuevas 2017`>0])
articulos_con_citas_nuevas_2017
#Suma el total de citas nuevas en 2017
total_nuevas_citas_nuevas_2017 <- sum(cedua$`Nuevas 2017`)
total_nuevas_citas_nuevas_2017


#Se contrastan citas reportas contr las validadas
reconocidas_vs_validadas_2017 <- total_nuevas_citas_2017 - total_nuevas_citas_validadas_2017

#Se cuentan los errores dectectados
total_errores_2017 <- length(cedua$Nuevas.2017[cedua$Nuevas.2017 < 0])

#Se obtiene el porcentaje de articulos con nuevas Citas reportadas
porcentaje_articulos_reconocidas <- articulos_nuevas_citas_2017*100/total_articulos

porcentaje_articulos_citas_nuevas_2017 = articulos_citas_validadas_2017*100/total_articulos


#Se obtiene el porcentaje de articulos con nuevas Citas validadas
porcentaje_articulos_validadas <- articulos_citas_validadas_2017*100/total_articulos

#Se crea un vector con nuestros resultados
matriz <- c(total_articulos,articulos_nuevas_citas_2017,total_nuevas_citas_2017,
            articulos_citas_validadas_2017,total_nuevas_citas_validadas_2017,
            reconocidas_vs_validadas_2017,total_errores_2017,porcentaje_articulos_reconocidas,
            porcentaje_articulos_validadas)

#Asignamos los nombres ya definidos en el vector campos
names(matriz) <- campos

#Visualizar la matriz de resultados
View(matriz)

#Graficación

d= table(cedua$Lugar.de.publicación,cedua$Año)

#Creamos un grafico de barras para conocer los lugares de publicacion usando la funcion table()
barplot(table(cedua$Lugar.de.publicación))

#Creamos un grafico de barras para conocer los lugares de publicacion usando la funcion rowSums()
barplot(rowSums(d), ylim=c(0,25))

md = t(as.matrix(d))

#Creamos un grafico con todos los años y paises con el numero de publicación
grafico = barplot(md, beside=TRUE, ylim=c(0,25), main = "Articulos por Año y Lugar", 
          xlab = "Paises y Años", ylab = "Cantidad", legend = colnames(d), 
          col=c('red','blue','black','green','brown','pink','purple'))

t_md <- replace(md[,], md[,]== 0, "")

text(grafico, md, labels=t_md ,cex=0.8, pos=3)

#estadistica descriptiva

#obtener media
mean(cedua$Nuevas.2017)
#obtener desviación estandar
sd(cedua$Nuevas.2017)
#obtener resumen descriptivo
summary(cedua$Nuevas.2017)