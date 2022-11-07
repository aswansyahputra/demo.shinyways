box::use(
  shiny[fluidPage, wellPanel, p, fluidRow, column, moduleServer, NS, tags, reactive, h1],
)

box::use(
  app/logic/fetch_data[fetch_data],
  app/view[mod_selector, mod_table, mod_chart],
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    h1("Palmer Penguins"),
    wellPanel(
      p("Size measurements for adult foraging penguins near Palmer Station, Antarctica"),
      mod_selector$ui(ns("selector"))
    ),
    fluidRow(
      column(6, mod_table$ui(ns("table"))),
      column(6, mod_chart$ui(ns("chart")))
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    odata <- reactive({
      fetch_data(creds = TRUE)
    })
    pdata <- mod_selector$server("selector", .data = odata)
    mod_table$server("table", .data = pdata)
    mod_chart$server("chart", .data = pdata)
  })
}
