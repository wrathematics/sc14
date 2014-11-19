library(shiny)

dataset <- iris

ui <- fluidPage(responsive = FALSE,
  fluidRow(
    column(4, selectInput('xcol', 'X Variable', names(dataset))),
    column(4, selectInput('ycol', 'Y Variable', names(dataset),
                          selected=names(dataset)[[2]])),
    column(4, numericInput('clusters', 'Cluster count', 3, min=1, max=9))
  ),
  fluidRow(
    plotOutput('kmeans', height = "400px")
  )
)

server <- function(input, output, session) {
  selectedData <- reactive({
    dataset[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$kmeans <- renderPlot({
    plot(selectedData(), col=clusters()$cluster, pch=20, cex=3)
    points(clusters()$centers, pch=4, cex=4, lwd=4)
  })
}
