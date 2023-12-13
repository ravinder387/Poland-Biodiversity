# activate shiny pkg
library(shiny)
library(plotly)
library(tidyverse)

df <- read_csv("final.csv")

mychoice <- vector("list", 689)
names(mychoice) <- unique(df$scientificName)
for(i in 1:length(mychoice)){
  mychoice[[i]] = unique(df$scientificName)[i]
}

# build user interface
ui <- fluidPage(
  tags$head(tags$link(
    rel = "stylesheet",
    type = "text/css",
    href = "style.css"
  )),
  fluidRow(
    div(h2("Observation of Different Animal Species which going to extinct in Poland"),
        
        style = "
        margin: 20px;
        padding: 20px;
        border-radius: 30px;
background: #e0e0e0;
box-shadow:  20px 20px 60px #bebebe,
             -20px -20px 60px #ffffff;
        ")
  ),
  fluidRow(
    column(4, div(selectInput("bioinput", "Select Species:",mychoice),
                  imageOutput("myImage"),
                  style = "
        margin: 20px;
        padding: 20px;
        border-radius: 30px;
background: #e0e0e0;
box-shadow:  20px 20px 60px #bebebe,
             -20px -20px 60px #ffffff;")),
    column(8, div( plotlyOutput("mymap"),
                  style = "
        margin: 20px;
        padding: 5px;
        border-radius: 30px;
background: #e0e0e0;
box-shadow:  20px 20px 60px #bebebe,
             -20px -20px 60px #ffffff;
        " ))
  )
)
