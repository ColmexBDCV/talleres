# Taller de introducción al procesamiento básico de textos en R por @espejolento para el Seminario de Ciencia de Datos y Programación
# Derivado del primer taller para RLadiesCDMX en la BDCV
# Adaptado de: https://programminghistorian.org/es/lecciones/procesamiento-basico-de-textos-en-r



#### INTRODUCCIÓN ####


#Grandes cantidades de texto requieren nuevas metodologías de exploración.
#Este taller permite conocer una de esas formas: el análisis de texto con el lenguaje de programación R. 
#En esta lección usaremos un tokenizador (tokenizer) que realiza un análisis sintáctico del texto con elementos como 
#palabras, frases y oraciones. 
# Para esto usaremos dos conjuntos de funciones o "paquetes": tidyverse y tokenizers
# -- Tidyverse proporciona herramientas cómodas para leer y trabajar con grupos de datos
# Para una introducción muy práctica del tidyverse: http://rpubs.com/palominoM/uso-basico-de-tidyverse
# -- Tokenizers contiene funciones para "datificar" el texto en palabras y oraciones. 


###### PASO 1 #####
# 1.1 Revisar encoding #
#TIP: Recuerden que si la codificación no es correcta tienen que ir a File - Reopen with Encoding 
#y seleccionar UTF-8
# 1.2 Revisar el directorio de trabajo
getwd()
# 1.3 Establecer el directorio de trabajo (donde estén tus datos)
#P:\ --> cambiar dirección de las diagonales invertida a diagonal derecha
setwd("P:/")
list.files()

###### PASO 2 #####
# instalar paquetes #
# install.packages("tidyverse")

#Los siguientes paquetes están dentro del tidyverse pero pueden sólo instalar estos
#porque el tidyverse es enorme:
#install.packages("dplyr")
#install.packages("readr")
#install.packages("ggplot2")
install.packages("tokenizers")
#install.packages("wordcloud")

###### PASO 3 #####
# cargar o llamar paquetes #
# Tip: para correr una línea presiona Ctrl+Enter
#library(tidyverse)
library(tokenizers)
library(readr)
library(wordcloud)
library(dplyr)
library(readr)
library(ggplot2)


###### PASO 4 #####
# asignar el texto que vamos a analizar a una variable #
# (fuente: https://cnnespanol.cnn.com/2016/01/12/discurso-completo-de-obama-sobre-el-estado-de-la-union/)
texto <- "También entiendo que como es temporada de elecciones, las expectativas para lo que lograremos este año son bajas. Aún así, señor Presidente de la Cámara de Representantes, aprecio el enfoque constructivo que usted y los otros líderes adoptaron a finales del año pasado para aprobar un presupuesto, y hacer permanentes los recortes de impuestos para las familias trabajadoras. Así que espero que este año podamos trabajar juntos en prioridades bipartidistas como la reforma de la justicia penal y ayudar a la gente que está luchando contra la adicción a fármacos de prescripción. Tal vez podamos sorprender de nuevo a los cínicos."

#Puedes observar el contenido que asignaste a la variable "texto"
texto

###### PASO 5 #####
# dividir un texto en palabras y oraciones #

#### Tokenizar Palabras ####
?tokenize_words
palabras <- tokenize_words(texto)

#Recuerda que puedes observar el contenido que asignaste a cualquier variable 
#escribiendo su nombre y "corriendo" la línea
palabras

#Para saber qué tipo de objeto es palabras puedes usar la función class()
class(palabras)


# ¿Qué pasó?
# tokenize_words es una función del paquete tokenizer
# lo que hace es quitar todos los signos de puntuación y espacios
# convertir todo a minúsculas y dividir el texto en palabras individuales

#### Tokenizar Oraciones ####
?tokenize_sentences
oraciones <- tokenize_sentences(texto)
oraciones

###### PASO 6 #####
# obtener el número de palabras por párrafo y por oraciones#


###Palabras por párrafo###

?length
length(palabras)
#length es una función que devuelve la longitud de un objeto.
#no obstante si sólo pedimos la longitud de "palabras" la respuesta es "uno" porque es sólo "una" lista
#para obtener cuántas palabras hay dentro de la lista tenemos que usar doble corchete:

length(palabras[[1]])
# el resultado de esto debe ser 101, que es el número de palabras en nuestro texto

###Palabras por oración###

oraciones_palabras <- tokenize_words(oraciones[[1]])
oraciones_palabras
oraciones_palabras[[1]]

#¿se acuerdan de cómo obtener cuántas palabras hay en un párrafo?
#intenten pensar cómo obtendrían cuántas palabras hay en la tercera oración de nuestro texto
#acá les van unas pistas:
length(oraciones_palabras[[1]])
length(oraciones_palabras[[2]])


#Hacer esto para cada oración sería engorroso, afortunadamente hay una función que simplifica este proceso
sapply(oraciones_palabras, length)


###### PASO 7 #####
# obtener la frecuencia de las palabras #
tabla <- table(palabras)
#la función table crea una tabla con las frecuencias de la lista que le demos 

#Para ver tu tabla puedes usar la función View(); recuerda que R es sensible a capitalización entonces importa
#que la primera palabra sea mayúscula 
View(tabla)
class(tabla)
#En la siguiente línea, vamos a convertir nuestra tabla en un data frame
df <- data_frame(palabra = names(tabla), frecuencia = as.numeric(tabla))
class(df)

#Para entender un poco mejor la diferencia entre una tabla y un dataframe corran las siguientes líneas:
tabla[1]
df[1]

tabla[,2]
df[,2]

tabla$Freq
df$frecuencia

#¿Qué notan?
#Para entender mejor lo que está pasando pueden echarle un ojo a:
#https://blog.rstudio.com/2016/03/24/tibble-1-0-0/


###### PASO 8 #####
# ordena tu data frame #
arrange(df, desc(frecuencia))


##### LEER TU PROPIO ARCHIVO DE TEXTO
# En la sección pasada vimos cómo hacer pruebas con un párrafo, ¡ahora veamos cómo leer nuestros propios archivos de texto!

#Indica la ubicación de tu texto
archivoAMLO <- "textos/20181201_amlo.txt"


# Utiliza la función file, con el parámetro r (de "read", leer)
objetoAMLO <- file(archivoAMLO,open="r")


# Aplica la función readLines para leer las líneas del archivo, fíjate que el encoding sea UTF-8!
amloprueba <- readLines(objetoAMLO, encoding = "UTF-8")


# Junta todas las oraciones en un solo texto con paste()
amloTexto <- paste(amloprueba, collapse = "\n")

# Obtén las palabras del discurso
palabrasamlo <- tokenize_words(amloTexto)


# Obtén la frecuencia de las palabras
amlotabla <- table(palabrasamlo[[1]])
View(amlotabla)


# Convierte tu tabla en un data frame
amlodf <- data_frame(palabra = names(amlotabla), frecuencia = as.numeric(amlotabla))
amlodf <- arrange(amlodf, desc(frecuencia))
View(amlodf)
length(amlodf$palabra)

# Filtra las palabras funcionales o stopwords

#swES <- stopwords(kind = "es")
sw <- read_csv("stopwords_es.csv")

amlodf_sinstopwords = subset(amlodf, !(palabra %in% sw$swES))
#amlodf_sinstopwords<- amlodf %>% filter(!palabra %in% swES)

#Crea una nube de palabras con la siguiente función
set.seed(1234)
wordcloud(words = amlodf_sinstopwords$palabra, freq = amlodf_sinstopwords$frecuencia, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

#https://rstudio-pubs-static.s3.amazonaws.com/40817_63c8586e26ea49d0a06bcba4e794e43d.html


#### CARGAR TUS PROPIOS METADATOS

# Paso 1. Carga los metadatos
getwd()
metadatos <- read_csv("metadatos_presidentes.csv")
View(metadatos)

# Paso 2. Especifica en qué carpeta está tu corpus
# OJO: fíjate que las diagonales estén en la dirección correcta,
#si lo copias y pegas de Windows estarán al revés
input_loc <- "P:/textos"

#Paso 3. Para leer y guardar todos los .txt en la variable "texto"
# corre el siguiente bloque de código:

archivos <- dir(input_loc, full.names = TRUE)
archivos

texto <- c()
for (a in archivos) {
  texto <- c(texto, paste(readLines(a, encoding = "UTF-8"), collapse = "\n"))
}

#Paso 4. Extrae las palabras del texto con las funciones que ya aprendimos
palabras <- tokenize_words(texto)
length(palabras) #tiene que dar 15, pues tenemos 15 discursos
no_palabras <- sapply(palabras, length)
no_palabras
#Añadimos una columna con el número de palabras de cada discurso
metadatos$palabras <- no_palabras
#Añadimos una columna con la divergencia de la media
metadatos$dif_media <- metadatos$palabras-mean(no_palabras)
View(metadatos)


#Paso 5. Grafica las palabras usando qplot ¡hasta le pueden poner una línea de cuál es la media! 
qplot(metadatos$año, metadatos$palabras) + labs(x = "Año", y = "Número de palabras")+
                  geom_hline(yintercept = mean(metadatos$palabras), color="blue")


#Puedes agregar leyendas con la función labs
qplot(metadatos$año, no_palabras, color = metadatos$partido, label= metadatos$presidente)+
  labs(x = "Año", y = "Número de palabras", color = "Partido del Presidente")


#install.packages("ggrepel")
#library(ggrepel)
# geom_label_repel(aes(label = metadatos$presidente),
#                  box.padding   = 0.35, 
#                  point.padding = 0.5,
#                  segment.color = 'grey50') +
#   theme_classic()

#Paso 6. Extrae las oraciones del texto con las funciones que ya aprendimos
oraciones <- tokenize_sentences(texto)
oraciones_palabras <- sapply(oraciones, tokenize_words)
oraciones_palabras[[13]]

#Paso 7. Crear una lista con el número de palabras en cada oración
#7.1 creamos una lista vacía
longitud_oraciones <- list()
#7.2 la poblamos en un "for loop" donde i se va convirtiendo en un número en cada iteración
# este bucle hará iteraciones de 1 al total de número de filas que tenemos en nuestros metadatos
# es decir, al total de discursos que tenemos en nuestra base
for (i in 1:nrow(metadatos)) {
  longitud_oraciones[[i]] <- sapply(oraciones_palabras[[i]], length)
}

#Paso 8. Sacamos la mediana del número de palabras por oración por discurso

mediana_longitud_oraciones <- sapply(longitud_oraciones, median)

#Paso 9. Graficamos esa mediana y agregamos geom_smooth
#Para mayor información: https://ggplot2.tidyverse.org/reference/geom_smooth.html
# Para más sobre LOESS: https://en.wikipedia.org/wiki/Local_regression
# http://www.math.wpi.edu/saspdf/stat/chap38.pdf

qplot(metadatos$año, mediana_longitud_oraciones)+
  labs(x = "Año", y = "Longitud media de las oraciones")+
  geom_text(aes(label=metadatos$presidente),hjust=0, vjust=0, angle = 55)+
  geom_smooth()
?geom_text
# Paso 10. Guardemos toda la información que tenemos en un espacio y creemos nubes de palabras
# para cada discurso
descripcion <- c()
for (i in 1:length(palabras)) {
  tabla <- table(palabras[[i]])
  tabla <- data_frame(palabra = names(tabla), frecuencia = as.numeric(tabla))
  tabla <- arrange(tabla, desc(frecuencia))
  tabla <- tabla[!(tabla$palabra %in% sw$swES),]
  #tabla <- subset(tabla, !(palabra %in% swES))
  mediana <- round(median(tabla$frecuencia))
  resultado <- c(metadatos$presidente[i], metadatos$año[i], tabla$palabra[1:5], tabla$frecuencia[1:5], mediana)
  descripcion <- c(descripcion, paste(resultado, collapse = "; "))
  nombre_de_imagen <- paste0(metadatos$año[i],".png")
  png(nombre_de_imagen)
  set.seed(1234)
  wordcloud(words = tabla$palabra, freq = tabla$frecuencia, min.freq = mediana,
            max.words=200, random.order=FALSE, rot.per=0.35,
            colors=brewer.pal(8, "Dark2"))
  dev.off()
}
descripcion
