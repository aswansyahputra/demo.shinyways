box::use(
  dplyr[`%>%`],
  highcharter[hchart, hcaes]
)

#' @export
get_visual <- function(.data) {
  res <- 
    .data %>% 
    hchart("scatter", hcaes(bill_length_mm, bill_depth_mm, group = species))
  return(res)
}