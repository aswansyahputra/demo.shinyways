server <- function(input, output, session) {
  
  odata <- reactive({
    fetch_data(creds = TRUE)
  })
  
  pdata <- eventReactive(input$apply, {
    tryCatch(
      process_data(odata(), selector = input$sex),
      error = function(err) NULL
    )
  })
  
  res_table <- reactive({
    validate(
      need(!is.null(pdata()), "Something not working, please contact your admin.")
    )
    get_summary(pdata())
  })
  
  res_chart <- reactive({
    validate(
      need(!is.null(pdata()), "Something not working, please contact your admin.")
    )
    get_visual(pdata())
  })
  
  output$display_table <- renderTable({
    res_table()
  })
  
  output$display_chart <- renderHighchart({
    res_chart()
  })
  
}