box::use(
  shiny[NS, tagList, checkboxGroupInput, actionButton, moduleServer, eventReactive],
)

box::use(
  app/logic/process_data[process_data]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    checkboxGroupInput(ns("sex"), label = "Must pick one or both:", choices = c("female", "male")),
    actionButton(ns("apply"), label = "Apply")
  )
}

#' @export
server <- function(id, .data) {
  moduleServer(
    id, function(input, output, session) {
      res <- eventReactive(input$apply, {
        tryCatch(
          process_data(.data(), selector = input$sex),
          error = function(err) NULL
        )
      })
      return(res)
    }
  )
}