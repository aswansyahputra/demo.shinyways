ui <- fluidPage(
  h1("Palmer Penguins"),
  wellPanel(
    p("Size measurements for adult foraging penguins near Palmer Station, Antarctica"),
    checkboxGroupInput("sex", label = "Pick one or both:", choices = c("female", "male")),
    actionButton("apply", label = "Apply"),
  ),
  fluidRow(
    column(6, tableOutput("display_table")),
    column(6, highchartOutput("display_chart"))
  )
)