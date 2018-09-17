#' Create the structure from a Nested Sampling run
#' @param output screen output
#' @author Richel J.C. Bilderbeek
bbt_create_ns <- function(
  output
) {
  # Extract the line
  x <- stringr::str_extract(output, "Marginal likelihood: -?[0-9\\.]+\\(.*\\)$")
  x <- x[!is.na(x)]
  testit::assert(length(x) == 1)

  ns <- list()
  # Get the marginal log likelihood
  ns$marg_log_lik <- as.numeric(
    stringr::str_sub(
      stringr::str_extract(x, pattern = ":.*\\("),
      start = 2,
      end = -2
    )
  )

  # Get the marginal log likelihood standard deviation
  ns$marg_log_lik_sd <- as.numeric(
    stringr::str_sub(
      stringr::str_extract(x, pattern = "\\(.*\\)"),
      start = 2,
      end = -2
    )
  )
  ns
}
