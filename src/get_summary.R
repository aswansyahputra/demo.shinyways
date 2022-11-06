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