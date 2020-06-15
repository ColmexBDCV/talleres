#Basado en: https://github.com/timelyportfolio/leaftime/blob/master/inst/examples/example_leaftime.R
#install.packages("leaftime")
#install.packages("leaflet")
#install.packages("htmltools")
#install.packages("geojsonio")
library(leaftime)
library(leaflet)
library(htmltools)
library(geojsonio)


#En estas líneas creamos un dataframe lat, long, y fecha de inicio, fecha de fin (sólo para que vean cómo funciona)

power <- data.frame(
  "Latitude" = c(
    33.515556, 38.060556, 47.903056, 49.71, 49.041667, 31.934167,
    54.140586, 54.140586, 48.494444, 48.494444
  ),
  "Longitude" = c(
    129.837222, -77.789444, 7.563056, 8.415278, 9.175, -82.343889,
    13.664422, 13.664422, 17.681944, 17.681944
  ),
  "start" = seq.Date(as.Date("2015-01-01"), by = "day", length.out = 10),
  "end" = seq.Date(as.Date("2015-01-01"), by = "day", length.out = 10) + 1
)

# Usamos geojsonio para convertir nuestro data.frame a geojson
power_geo <- geojsonio::geojson_json(power,lat="Latitude",lon="Longitude")

# Activamos leaflet y le metemos nuestros datos Geojson (power_geo)
leaflet(power_geo) %>%
  addTiles() %>%
  setView(44.0665,23.74667,2) %>%
  addTimeline()

# Podemos controlar modificar el slider con sliderOptions
leaflet(power_geo) %>%
  addTiles() %>%
  setView(44.0665,23.74667,2) %>%
  addTimeline(
    sliderOpts = sliderOptions(
      formatOutput = htmlwidgets::JS(
        "function(date) {return new Date(date).toDateString()}
      "),
      position = "bottomright",
      step = 10,
      duration = 3000,
      showTicks = FALSE
    )
  )

# Podemos cambiar el estilo con styleOptions
leaflet(power_geo) %>%
  addTiles() %>%
  setView(44.0665,23.74667,2) %>%
  addTimeline(
    timelineOpts = timelineOptions(
      styleOptions = styleOptions(
        radius = 10,
        color = "black",
        fillColor = "pink",
        fillOpacity = 1
      )
    )
  )

# Para cambiar los puntos según el tipo de dato 
power_styled <- power
power_styled$color <- substr(topo.colors(6)[ceiling(runif(nrow(power),0,6))],1,7)
power_styled$radius <- seq_len(nrow(power_styled)) # ceiling(runif(nrow(power),3,10))

leaflet(geojsonio::geojson_json(power_styled)) %>%
  addTiles() %>%
  setView(44.0665,23.74667,2) %>%
  addTimeline(
    timelineOpts = timelineOptions(
      styleOptions = NULL, # que no se vaya a sobrescribir el estilo
      pointToLayer = htmlwidgets::JS(
        "
function(data, latlng) {
  return L.circleMarker(
    latlng,
    {
      radius: +data.properties.radius,
      color: data.properties.color,
      fillColor: data.properties.color,
      fillOpacity: 1
    }
  );
}
"
      )
    )
  )


#Para hacer que el timeline sea del tamaño del mapa
leaflet(power_geo, elementId = "leaflet-wide-timeline") %>%
  addTiles() %>%
  setView(44.0665,23.74667,2) %>%
  addTimeline(
    width = "96%"
  )

