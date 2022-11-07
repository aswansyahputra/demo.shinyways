box::use(
  dplyr[group_by, summarise, n, across, `%>%`]
)

#' @export 
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