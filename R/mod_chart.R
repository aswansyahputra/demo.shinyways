#' chart UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom highcharter highchartOutput
#' @importFrom shiny NS tagList
mod_chart_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    highcharter::highchartOutput(ns("display_chart"))
  )
}
    
#' chart Server Functions
#'
#' @noRd 
#' @importFrom highcharter renderHighchart
#' @importFrom shiny moduleServer reactive validate need
mod_chart_server <- function(id, .data) {
  shiny::moduleServer(
    id, function(input, output, session) {
      
      res_chart <- shiny::reactive({
        shiny::validate(
          shiny::need(!is.null(.data()), "Something not working, please contact your admin.")
        )
        get_visual(.data())
      })
      
      output$display_chart <- highcharter::renderHighchart({
        res_chart()
      })
      
      return(res_chart)
    }
  )
}
    
## To be copied in the UI
# mod_chart_ui("chart_1")
    
## To be copied in the server
# mod_chart_server("chart_1")
