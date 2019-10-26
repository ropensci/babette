#' Put the info of a Nested Sampling run in a structure
#' @param output screen output
#' @return a list with the following elements:
#'   \itemize{
#'     \item \code{marg_log_lik} the marginal log likelihood estimate
#'     \item \code{marg_log_lik_sd} the standard deviation around the estimate
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
bbt_create_ns <- function(
  output
) {
  ns <- list()

  # Marginal likelihood
  # Extract the line
  x <- stringr::str_extract(output, "Marginal likelihood: -?[0-9\\.]+\\(.*\\)$")
  x <- x[!is.na(x)]
  testit::assert(length(x) == 1)

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

  # ESS
  # Extract the line
  x <- stringr::str_extract(output, "Max ESS: [0-9\\.]+$")
  x <- x[!is.na(x)]
  # There are two ESSes, just pick the first
  testit::assert(length(x) >= 2)
  x <- x[1]

  # Get the marginal log likelihood
  ns$ess <- as.numeric(
    stringr::str_extract(x, pattern = "[0-9\\.]+")
  )

  ns
}
