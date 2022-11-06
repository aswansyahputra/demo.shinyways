#' table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom shiny NS tagList tableOutput
mod_table_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::tableOutput(ns("display_table"))
  )
}
    
#' table Server Functions
#'
#' @noRd 
#' @importFrom shiny moduleServer reactive validate need renderTable
mod_table_server <- function(id, .data) {
  shiny::moduleServer(
    id, function(input, output, session) {
      
      res_table <- shiny::reactive({
        shiny::validate(
          shiny::need(!is.null(.data()), "Something not working, please contact your admin.")
        )
        get_summary(.data())
      })
      
      output$display_table <- shiny::renderTable({
        res_table()
      })
      
      return(res_table)
    }
  )
}
    
## To be copied in the UI
# mod_table_ui("table_1")
    
## To be copied in the server
# mod_table_server("table_1")
