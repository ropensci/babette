#' Process the 'BEAST2' output dependent on 'BEAST2' package specifics
#' @inheritParams default_params_doc
#' @param out a list with the complete babette output, with elements:
#' \itemize{
#'   \item \code{output} textual output of a 'BEAST2' run
#' }
#' @return complete babette output with added attributes,
#'   which depends on the 'BEAST2' package.
#'   \itemize{
#'     \item \code{marg_log_lik} the marginal log likelihood estimate
#'     \item \code{marg_log_lik_sd} the standard deviation around the estimate
#'     \item \code{estimates} the parameter estimates
#'       created during the marginal likelihood estimation
#'     \item \code{trees} the trees
#'       created during the marginal likelihood estimation
#'   }
#' @author Richèl J.C. Bilderbeek
#' @export
parse_beast2_output <- function(
  out,
  inference_model
) {
  if (beautier::is_mcmc_nested_sampling(inference_model$mcmc)) {
    out$ns <- babette::parse_beast2_output_to_ns(out$output)
  }
  out
}
