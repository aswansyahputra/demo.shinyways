#' @importFrom highcharter hchart hcaes
get_visual <- function(.data) {
  res <- 
    .data %>% 
    highcharter::hchart("scatter", highcharter::hcaes(bill_length_mm, bill_depth_mm, group = species))
  return(res)
}