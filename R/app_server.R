#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  odata <- reactive({palmerpenguins::penguins})
  pdata <- mod_selector_server("selector", .data = odata)
  
  mod_table_server("table", .data = pdata)
  mod_chart_server("chart", .data = pdata)
}
