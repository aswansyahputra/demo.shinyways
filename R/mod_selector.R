#' selector UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList checkboxGroupInput actionButton
mod_selector_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::checkboxGroupInput(ns("sex"), label = "Must pick one or both:", choices = c("female", "male")),
    shiny::actionButton(ns("apply"), label = "Apply")
  )
}

#' selector Server Functions
#'
#' @noRd 
#' @importFrom shiny moduleServer eventReactive
mod_selector_server <- function(id, .data) {
  shiny::moduleServer(
    id, function(input, output, session) {
      res <- shiny::eventReactive(input$apply, {
        tryCatch(
          process_data(.data(), selector = input$sex),
          error = function(err) NULL
        )
      })
      return(res)
    }
  )
}
    
## To be copied in the UI
# mod_selector_ui("selector_1")
    
## To be copied in the server
# mod_selector_server("selector_1")
