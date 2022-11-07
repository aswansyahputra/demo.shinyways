box::use(
  shiny[NS, tagList, moduleServer, reactive, validate, need, tableOutput, renderTable],
)

box::use(
  app/logic/get_summary[get_summary]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    tableOutput(ns("display_table"))
  )
}

#' @export
server <- function(id, .data) {
  moduleServer(
    id, function(input, output, session) {
      
      res_table <- reactive({
        validate(
          need(!is.null(.data()), "Something not working, please contact your admin.")
        )
        get_summary(.data())
      })
      
      output$display_table <- renderTable({
        res_table()
      })
      
      return(res_table)
    }
  )
}