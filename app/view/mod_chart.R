box::use(
  shiny[NS, tagList, moduleServer, reactive, validate, need],
  highcharter[highchartOutput, renderHighchart]
)

box::use(
  app/logic/get_visual[get_visual]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    highchartOutput(ns("display_chart"))
  )
}

#' @export
server <- function(id, .data) {
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