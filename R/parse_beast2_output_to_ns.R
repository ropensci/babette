#' Parse BEAST2 NS output
#'
#' Parse the BEAST2 output when run with the BEAST2 NS ('Nested Sampling')
#' package.
#' @param output screen output
#' @seealso use \code{\link{create_test_ns_output}} to obtain
#' a test screen output.
#' @return a list with the following elements:
#'   \itemize{
#'     \item \code{marg_log_lik} the marginal log likelihood estimate
#'     \item \code{marg_log_lik_sd} the standard deviation around the estimate
#'   }
#' @author Richèl J.C. Bilderbeek
#' @examples
#' beastier::remove_beaustier_folders()
#' beastier::check_empty_beaustier_folders()
#'
#' parse_beast2_output_to_ns(
#'   output = create_test_ns_output()
#' )
#'
#' beastier::remove_beaustier_folders()
#' beastier::check_empty_beaustier_folders()
#' @export
parse_beast2_output_to_ns <- function(
  output
) {
  ns <- list()

  # Marginal likelihood
  # Extract the line
  x <- stringr::str_extract(output, "Marginal likelihood: -?[0-9\\.]+\\(.*\\)$")
  x <- x[!is.na(x)]
  check_string(x)

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
  check_number_whole(length(x), min = 2)
  x <- x[1]

  # Get the marginal log likelihood
  ns$ess <- as.numeric(
    stringr::str_extract(x, pattern = "[0-9\\.]+")
  )

  ns
}
