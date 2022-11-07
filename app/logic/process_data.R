box::use(
  dplyr[mutate, across, filter, `%>%`],
  tidyselect[where],
  stats[na.omit],
)

#' @export
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