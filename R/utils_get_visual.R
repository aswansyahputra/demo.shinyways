#' get_visual 
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
#' @importFrom highcharter hchart hcaes
get_visual <- function(.data) {
  res <- 
    .data %>% 
    highcharter::hchart("scatter", highcharter::hcaes(bill_length_mm, bill_depth_mm, group = species))
  return(res)
}