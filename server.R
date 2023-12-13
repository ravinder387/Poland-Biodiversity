# activate shiny pkg
library(sf)
library(shiny)
library(tidyverse)
library(plotly)

# poland boundries
poland_boundries <- st_read("poland-boundries/pol_admbnda_adm1_gov_v02_20220414.shp")

df <- read_csv("final.csv")
poland_df <- df |> st_as_sf(coords = c("longitudeDecimal", "latitudeDecimal"),
                        crs = 4326)

# server script
server <- function(input, output, session) {
    data <- reactive({
      poland_df |> filter(scientificName == input$bioinput)
    })
    
    output$mymap <- renderPlotly({
      info <- paste0(
        "\nTotalObservation:", data()$totalObservation,
        "\nLocal Area:", data()$locality,
        "\nlocalObservation:", data()$individualCount
      )
      
      p <-  ggplot() +
        geom_sf(mapping = aes(fill = ADM1_PL),
                data = poland_boundries) +
        geom_point(aes(geometry = data()$geometry, text = info),stat = "sf_coordinates" ) +
        theme(
          panel.background = element_rect(fill = '#e0e0e0', color = '#e0e0e0'),
          plot.background = element_rect(fill = "#e0e0e0"),
          panel.grid.major = element_line(color = '#e0e0e0'),
          panel.grid.minor = element_line(color = '#e0e0e0', size = 0.1),
          axis.title.x = element_blank(),
          axis.title.y = element_blank()
         ) 
       ggplotly(p)
      p
    })
    
    output$myImage <- renderImage({
      list(
        src = file.path("images", paste0(input$bioinput, ".jpg")),
        contentType = "image/jpeg",
        width = 300,
        height = 200
      )
    }, deleteFile = F)
}
