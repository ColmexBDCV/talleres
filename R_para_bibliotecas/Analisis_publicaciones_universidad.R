# Primer taller de R en BiblioColmex
# Taller de introducción al tidyverse a cargo de @espejolento y Rodrigo Cuéllar
###### PASO 1 #####
# revisar encoding #
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




#### PASO 2: Instalar paquetes ####
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


#?readr
#?install.packages


#### PASO 3: Cargar paquetes que vas a usar ####
# Los paquetes sólo se instalan una vez en R después ya sólo se "llaman", esto se hace con la función "library"
library(readr) 
#readr es un paquete para leer de forma fácil csv, tsv, etc. (más info: https://cran.r-project.org/web/packages/readr/index.html)
library(tidyverse) 
#tidyverse es un conjunto de paquetes para  de datos (más info: https://www.tidyverse.org/)
#aquí estamos llamando a todos los paquetes que lo conforman. Nosotros trabajaremos específicamente con dplyr y ggplot

#### PASO 4: Revisar tu directorio de trabajo ####
# ¿Por qué hay un hashtag antes este texto?
# R usa el signo # para añadir comentarios, para que tú y otros puedan enteder de qué se trata el código. Los comentarios son texto que no se considera código, por lo tanto no tendrán influencia en tus operaciones.
## Obtener directorio donde se encuentra uno
getwd()

#### PASO 5: Cambiar tu directorio de trabajo ####
## Si el directorio actual no es donde están tus datos, cambiarlo al espacio donde sí estén
#setwd("/home/rod/Dropbox/Colmex/meta-tesis/Curso R")
#setwd("C:/Users/silvi/Dropbox/meta-tesis/Curso R")

?read_csv

## PASO 6: CARGAR SET DE DATOS
cedua = read_csv('archivos_bibliografxs_openrefine/CEDUA.csv')

## PASO 7: Ver datos
# (dar clic sobre el nombre de tu data frame en el Global Environment)

## PASO 8: Cambiar NA a 0
cedua[is.na(cedua)] = 0

dim(cedua) #para saber cuantas filas y columnas tiene nuestro data frame usamos la funcion dim()
View(cedua) #para abrir tu tabla se puede usar la funcion View()
columnas = colnames(cedua) #para saber el nombre de tus columnas, usa la funcion colnames()


annios = cedua$Año
unique(annios)

dosmildoce = subset(cedua, Año == 2012) #RECUERDEN! Un = significa asignacion y doble == significa comparacion
mayorigualque_dosmildoce = subset(cedua, Año >= 2012)

#### A continuacion variables de autor y anio, autor son ambos apellidos seguidos de anio en formato YYYY

menorquecero <- subset(cedua, `Nuevas 2017` < 0)

citas2016 = cedua$`Citas 2016`
citas2017 = cedua$`Validadas 2017` 

nuevas2017 = citas2017-citas2016
nuevas2017

cedua$nuevas2017b = nuevas2017

cedua <- subset(cedua, select = -c(Column) )

View(menorquecero)

cedua$`Validadas 2017`

 
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
            "Total de errores 2017","Porcentaje de artículos con citas reconocidas",
            "Porcentaje de artículos con citas validadas")

#Comenzamos a crear Variables y asignarles resultados



#cuenta el numero de filas (en nuestro caso el total de articulos)
total_articulos = nrow(cedua)
total_articulos

#Cuenta el total de citas nuevas reportadass en 2017

articulos_nuevas_citas_2017 = length(cedua$`Nuevas 2017`[cedua$`Nuevas 2017`>0])
articulos_nuevas_citas_2017

#Suma todas las nuevas citas de todos los articulos en 2017
total_nuevas_citas_2017 <- sum(cedua$`Nuevas 2017`[cedua$`Nuevas 2017`>0])
total_nuevas_citas_2017

#Cuenta el total de artículos con citas validadas en el 2017
articulos_citas_validadas_2017 = length(cedua$`Validadas 2017`[cedua$`Validadas 2017`>0])

#Suma el total de citas validadas 2017

total_nuevas_citas_validadas_2017 <- sum(cedua$`Validadas 2017`[cedua$`Validadas 2017`>0])
total_nuevas_citas_validadas_2017


#Se contrastan citas reportas contra las validadas
reconocidas_vs_validadas_2017 <- total_nuevas_citas_2017 - total_nuevas_citas_validadas_2017

#Se cuentan los errores dectectados
total_errores_2017 <- length(cedua$`Nuevas 2017`[cedua$`Nuevas 2017` < 0])
total_errores_2017

#Se obtiene el porcentaje de articulos con nuevas Citas reportadas
porcentaje_articulos_citas_nuevas <- articulos_nuevas_citas_2017*100/total_articulos
porcentaje_articulos_citas_nuevas


#Se obtiene el porcentaje de articulos con nuevas Citas validadas

porcentaje_articulos_citas_validadas = articulos_citas_validadas_2017*100/total_articulos
porcentaje_articulos_citas_validadas


#Se crea un vector con nuestros resultados
matriz <- c(total_articulos,articulos_nuevas_citas_2017,total_nuevas_citas_2017,
            articulos_citas_validadas_2017,total_nuevas_citas_validadas_2017,
            reconocidas_vs_validadas_2017,total_errores_2017,porcentaje_articulos_citas_nuevas,
            porcentaje_articulos_citas_validadas)

#Asignamos los nombres ya definidos en el vector campos
names(matriz) <- campos

#Visualizar la matriz de resultados
View(matriz)

##############################################
############## Graficación ##################
#############################################


# Hacemos una tabla donde estén los países de publicación, los años de publicación 
#y cuántos artículos hubo para ambas condiciones. Es decir la tabla tendrá filas como:
# Alemania | 2015 | 1 <-- indicando que en el 2015 hubo un solo artículo publicado en Alemania

pais_anio = table(cedua$`Lugar de publicación`,cedua$Año)
View(pais_anio)

#Creamos un gráfico de barras para conocer los lugares de publicación usando la funcion table()
#En este caso nos muestra todas las ocurrencias de un país (sin importar en qué año)
barplot(table(cedua$`Lugar de publicación`))

#La tabla "pais_anio" está organizada por país, pero si quisiéramos la organización inversa por año podemos usar 
#la función t() que hace un cambio en el eje de la columna que organiza
#es decir, no es lo mismo contabilizar las ocurrencias de un país en cada año (como en la tabla "pais_anio"),
#en lugar de las ocurrencias de un año, en diferentes países (como será en la tabla que crearemos a continuación)
anio_pais = t(as.matrix(pais_anio))
View(pais_anio)

#Creamos un grafico con todos los años y paises con el numero de publicación

grafico = barplot(anio_pais, beside=TRUE, ylim=c(0,25), main = "Artículos por Año y Lugar", 
          xlab = "Países y años", ylab = "Cantidad", legend = colnames(pais_anio), 
          col=c('red','blue','black','green','brown','pink','purple','white'))


#Para colocar la cantidad exacta representada por cada barra, se puede usar la función text() como sigue:
#grafico_conceros <- text(g, anio_pais, labels=anio_pais ,cex=0.8, pos=3)

#Como podemos observar "0" también fue considerada. Para evitar su aparición podemos reemplazar las apariciones de "0" por un texto vacío

anio_pais_sinceros <- replace(anio_pais[,], anio_pais[,]== 0, "")
View(anio_pais_sinceros)
grafico_sinceros <- text(grafico, anio_pais, labels=anio_pais_sinceros ,cex=0.8, pos=3)
grafico_sinceros
#estadistica descriptiva

#obtener media
mean(cedua$`Nuevas 2017`)
#obtener desviación estandar
sd(cedua$`Nuevas 2017`)
#obtener resumen descriptivo
summary(cedua$`Nuevas 2017`)