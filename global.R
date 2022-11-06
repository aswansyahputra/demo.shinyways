library(shiny)
library(palmerpenguins)
library(highcharter)
library(dplyr)

options(
  shiny.launch.browser = .rs.invokeShinyPaneViewer,
  shiny.autoreload = TRUE,
  shiny.port = 5555
)

#' @importFrom palmerpenguins penguins
fetch_data <- function(creds) {
  res <- NULL
  if (isTRUE(creds)) {
    res <- palmerpenguins::penguins
  }
  return(res)
}

#' @importFrom dplyr mutate across filter
#' @importFrom tidyselect where
#' @importFrom stats na.omit
process_data <- function(.data, selector) {
  if (is.null(selector)) stop("Selector must not be NULL!", call. = FALSE)
  selector <- match.arg(selector, choices = unique(.data[["sex"]]), several.ok = TRUE)
  res <- 
    .data %>% 
    dplyr::mutate(dplyr::across(tidyselect::where(is.factor), as.character)) %>% 
    dplyr::filter(sex %in% selector) %>% 
    stats::na.omit()
  return(res)
}

#' @importFrom dplyr group_by summarise n across
get_summary <- function(.data) {
  res <- 
    .data %>% 
    dplyr::group_by(species) %>% 
    dplyr::summarise(
      n = dplyr::n(),
      dplyr::across(c(bill_length_mm, bill_depth_mm), mean)
    )
  return(res)  
}

#' @importFrom highcharter hchart hcaes
get_visual <- function(.data) {
  res <- 
    .data %>% 
    highcharter::hchart("scatter", highcharter::hcaes(bill_length_mm, bill_depth_mm, group = species))
  return(res)
}
