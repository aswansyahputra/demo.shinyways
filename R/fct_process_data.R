#' process_data 
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
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