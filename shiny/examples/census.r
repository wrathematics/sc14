library(shiny)
library(maps)
library(mapproj)

source("./examples/percent_map.r")
counties <- readRDS("./examples/counties.rds")


### ui
ui <- fluidPage(
  titlePanel("2010 US Census"),
  sidebarLayout(
    sidebarPanel(
      selectInput("var", 
        label="Choose a variable to display",
        choices=c("% White", "% Black", "% Hispanic", "% Asian"),
        selected="% White"),
      
      sliderInput("range", label="Range of interest:",
        min=0, max=100, value=c(0, 100))
    ),
    
    mainPanel(plotOutput("map"))
  )
)



### server
server <- function(input, output) {
  output$map <- renderPlot({
    args <- switch(input$var,
      "% White"=list(counties$white, "darkgreen", "% White"),
      "% Black"=list(counties$black, "black", "% Black"),
      "% Hispanic"=list(counties$hispanic, "darkorange", "% Hispanic"),
      "% Asian"=list(counties$asian, "darkviolet", "% Asian"))
      
    args$min <- input$range[1]
    args$max <- input$range[2]
    
    do.call(percent_map, args)
  })
}
