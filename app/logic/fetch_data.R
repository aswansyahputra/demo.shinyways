box::use(
  palmerpenguins
)

#' @export
fetch_data <- function(creds, source = c("db", "gsheets", "sqlite", "flatfiles")) {
  res <- NULL
  if (isTRUE(creds)) {
    res <- palmerpenguins::penguins
  }
  return(res)
}