library(shiny)
library(palmerpenguins)
library(highcharter)
library(dplyr)

options(
  shiny.launch.browser = .rs.invokeShinyPaneViewer,
  shiny.autoreload = TRUE,
  shiny.port = 5555
)

fetch_data <- function(creds) {
  res <- NULL
  if (isTRUE(creds)) {
    res <- palmerpenguins::penguins
  }
  return(res)
}

process_data <- function(.data, selector) {
  if (is.null(selector)) stop("Selector must not be NULL!", call. = FALSE)
  selector <- match.arg(selector, choices = unique(.data[["sex"]]), several.ok = TRUE)
  res <- 
    .data %>% 
    mutate(across(where(is.factor), as.character)) %>% 
    filter(sex %in% selector) %>% 
    na.omit()
  return(res)
}

get_summary <- function(.data) {
  res <- 
    .data %>% 
    group_by(species) %>% 
    summarise(
      n = n(),
      across(c(bill_length_mm, bill_depth_mm), mean)
    )
  return(res)  
}

get_visual <- function(.data) {
  res <- 
    .data %>% 
    hchart("scatter", hcaes(bill_length_mm, bill_depth_mm, group = species))
  return(res)
}

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

shinyApp(ui, server)
