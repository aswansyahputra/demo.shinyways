library(shiny)
library(palmerpenguins)
library(highcharter)
library(dplyr)

options(
  shiny.launch.browser = .rs.invokeShinyPaneViewer,
  shiny.autoreload = TRUE,
  shiny.port = 5555
)

invisible(
  lapply(
    list.files(path = "src", pattern = "\\.R$", full.names = TRUE),
    source
  )
)

ui <- fluidPage(
  h1("Palmer Penguins"),
  wellPanel(
    p("Size measurements for adult foraging penguins near Palmer Station, Antarctica"),
    mod_selector_ui("selector")
  ),
  fluidRow(
    column(6, mod_table_ui("table")),
    column(6, mod_chart_ui("chart"))
  )
)

server <- function(input, output, session) {
  
  odata <- reactive({fetch_data(creds = TRUE)})
  pdata <- mod_selector_server("selector", .data = odata)
  
  mod_table_server("table", .data = pdata)
  mod_chart_server("chart", .data = pdata)
  
}

shinyApp(ui, server)
