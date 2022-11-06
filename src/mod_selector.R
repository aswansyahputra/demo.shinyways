mod_selector_ui <- function(id) {
  ns <- NS(id)
  tagList(
    checkboxGroupInput(ns("sex"), label = "Must pick one or both:", choices = c("female", "male")),
    actionButton(ns("apply"), label = "Apply")
  )
}

mod_selector_server <- function(id, .data) {
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