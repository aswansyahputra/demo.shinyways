mod_chart_ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("display_chart"))
  )
}

mod_chart_server <- function(id, .data) {
  moduleServer(
    id, function(input, output, session) {
      
      res_chart <- reactive({
        validate(
          need(!is.null(.data()), "Something not working, please contact your admin.")
        )
        get_visual(.data())
      })
      
      output$display_chart <- renderHighchart({
        res_chart()
      })
      
      return(res_chart)
    }
  )
}