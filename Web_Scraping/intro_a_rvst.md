Introducción a rvest
====================

> Por: Silvia Gutiérrez \[CC BY 2.0\]
> Adaptado de:**https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/**
> **rvest** es un paquete de R inspirado en beautiful soup de Python

> Trabaja con [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html) para poder escribir expresiones
> compleja como pipelines sencillos (recuerden la sesión del tidyverse y
> los pipes  %\>%)

1.  Para instalar ejecuta:

```r
install.packages("rvest")
```

2.  Imaginemos que estamos analizando el cine mexicano, específicamente
    de Iñárritu y queremos sacar algunos datos sobre su película
    [[Amores Perros]{.underline}] de IMDB. Empezaremos por descargar y
    leer la página con la función de rvest que se llama read\_html():

```r
library(rvest)
amores_perros <-read_html(\"http://www.imdb.com/title/tt0245712/\")
```

3.  Si quisiera extraer el rating de la película, puedo seleccionar esa
    parte de la página web dar botón derecho, y copiar 

> ![][1]

a.  el selector de CSS:
```css
#title-overview-widget>div.vital>div.title_block>div> div.ratings_wrapper > div.imdbRating > div.ratingValue > strong > span
```

b.  o bien, la ruta de XPath:
```
//*[@id="title-overview-widget"]/div[2]/div[2]/div/div[1]/div[1]/div[1]/strong/span
```
> rvest es muy listo, por lo que no siempre tenemos que copiar toda la
> ruta sino sólo un pedacito del final, con el siguiente código podrías
> entonces extraer el rating de la película:

```r
amores_perros %>%
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()
```

> ![backhand index pointing right] **Ejercicio:** Corre el código parte
> por parte y deduce: ¿para qué creees que sirve html\_node(), para qué
> html\_text()?, ¿qué crees que hace as.numeric()?

4.  Ahora, para obtener el título de la película haremos algo parecido
    sólo que esta vez nos fijaremos cómo se llama el \<div\> que
    contiene al título; en este caso el nombre de la clase de este div
    es "title\_wrapper", para seleccionar un div con una clase dada lo
    único que tenemos que hacer es poner un punto antes del nombre como
    se indica en el ejemplo:

##Obtener el título
```r  
amores_perros %>%
  html_nodes(".title_wrapper")%>%
  html_nodes("h1") %>%
  html_text()

##Obtener elenco
amores_perros %>%
    html_nodes("#titleCast .itemprop span") %>%
    html_text()
```

5.  Con lo que aprendiste hasta ahora, deduce cómo obtendrías a los
    miembros del elenco

Sacando jugo a la programación
------------------------------

> Ahora bien, hacer todo esto para tan poca información parece un poco
> tonto, ¿no? Bien podríamos haber extraído los datos manualmente.
>
> Sin embargo, todo este esfuerzo se ve pagado cuando podemos
> automatizar este proceso para extraer los datos de más películas.
>
> Sigamos con el ejemplo de Iñárritu y obtengamos todas las urls de las
> películas en las que fue director. ¿Cómo harías esto?
>
> \[Intenta no ver la solución\]

1.  Pues sí, el primer paso sería visitar la página de Iñárritu y
    encontrar la sección en donde se enlistan las películas que hizo y
    leer esa información

> ![][2]
>
> ![][3]
>
> inarritu \<- read\_html(\"http://www.imdb.com/name/nm0327944/\")

2.  Una vez ahí identificamos la sección que corresponde a las películas
    que él dirigió

```r  
peliculas <-inarritu  %>%
  html_nodes(xpath='//*[@id="filmography"]/div[4]/div')%>%
  html_nodes("a")%>% 
  html_attr('href')
```

3.  Observa lo que quedó guardado en tu variable de películas. ¿Qué
    observas?

4.  Pues sí, para hacernos la tarea difícil IMDB no puso las urls
    completas, ¿cómo crees que se podría solucionar esto?

```r  
urls_pelis <- paste0(rep("http://www.imdb.com",length(peliculas)),peliculas)
```

5.  Ahora que ya tenemos guardadas todas las urls de las películas que
    dirigió Iñárritu, viene lo bueno, porque ahora sí podemos hacer una
    función que recorra todas las listas y guarde nuestra información en
    un data.frame


```r  
# escribir función que guarde título, rating y cast en un df
df_pelis = function(url_peli)
{
  # leer html 
  html_peli <- read_html(url_peli)
  
  # leer título
  titulo = html_peli %>%
    html_nodes(".title_wrapper")%>%
    html_nodes("h1") %>%
    html_text()
  
  # leer rating de la película
  rating = html_peli %>%
    html_node("strong span") %>%
    html_text() %>%
    as.numeric()
  
  # obtener el cast de la película
  cast = html_peli%>%
    html_nodes("#titleCast .itemprop span") %>%
    html_text()
  
  info_peli = data.frame(titulo=titulo,rating=rating,cast=paste(cast,collapse=","),
                         stringsAsFactors = FALSE)
  
  return(info_peli)
}

# poblar data.frame

## primero llenamos la tabla leyendo la primera url de nuestra lista de películas (urls_pelis[1]
inarritu_tabla = df_pelis(urls_pelis[1])

## después seguimos con las demás urls 
## (a partir de la segunda [2:] hasta la última [length(url_pelis)]
for (i in 2:length(urls_pelis)){

#usamos rbind para pegar verticalmente los datos ver:
#http://www.endmemo.com/program/R/rbind.php
#http://www.endmemo.com/program/R/cbind.php
  inarritu_tabla = rbind(inarritu_tabla,df_pelis(urls_pelis[i]))
}


View(inarritu_tabla)
```
