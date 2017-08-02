shinydata <- function(dataset) {
  #
  # This is a Shiny web application. You can run the application by clicking
  # the 'Run App' button above.
  #
  # Find out more about building applications with Shiny here:
  #
  #    http://shiny.rstudio.com/
  #

  library(shiny)
  library(hackathon)
  library(rlang)

  # Define UI for application that draws a histogram
  ui <- fluidPage(

    # Show a plot of the generated distribution
    mainPanel(

      selectInput("xval", "xval", choices = names(dataset)),
      selectInput("yval", "yval", choices = names(dataset)),
      plotOutput("concplot"))
  )

  # Define server logic required to draw a histogram
  server <- function(input, output) {

    output$concplot <- renderPlot({
      conc_plot(dataset, !!sym(input$xval), !!sym(input$yval))
    })
  }

  # Run the application
  shinyApp(ui = ui, server = server)


}
