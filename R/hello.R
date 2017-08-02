# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

hello <- function() {
  print("Hello, world!")
}

#' Increment a value by one
#' @param value a value to increment
#' @export
add_one <- function(value) {
  value + 1
}

add_two <- function(x) {
  x + 2
}

#' Create a scatterplot
#' @param data the data to use for the plot
#' @param .xVar the value to plot on the x axis
#' @param .yVar the value to plot on the y axis
#' @export
#' @importFrom ggplot2 ggplot aes geom_point
#' @importFrom rlang enexpr quo eval_tidy
#' @importFrom magrittr %>%
#' @examples
#' conc_plot(Theoph, Time, conc)
conc_plot <- function(data, .xVar, .yVar) {
  .xVar <- rlang::enexpr(.xVar)
  .yVar <- rlang::enexpr(.yVar)

  temp <- rlang::quo(
    data %>% ggplot2::ggplot(aes(x = !!.xVar, y = !!.yVar)) +
      geom_point()
  )
  return(eval_tidy(temp))
}

#' A function that creates a scatterplot
#' @param dataset the dataset to plot
#' @import shiny
#' @export
shinydata <- function(dataset) {
  #
  # This is a Shiny web application. You can run the application by clicking
  # the 'Run App' button above.
  #
  # Find out more about building applications with Shiny here:
  #
  #    http://shiny.rstudio.com/
  #

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
