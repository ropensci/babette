#' Process the BEAST2 output dependent on BEAST2 package specifics
#' @inheritParams bbt_default_params_doc
#' @param out a list with the complete babette output, with elements:
#' \itemize{
#'   \item \code{output} textual output of a BEAST2 run
#' }
#' @param mcmc an MCMC
#' @param alignment_ids alignment IDs, as obtained by
#'   \link[beautier]{get_alignment_ids}
#' @return complete babette output with added attributes,
#'   which depends on the BEAST2 package specificics
#'   \itemize{
#'     \item \code{marg_log_lik} the marginal log likelihood estimate
#'     \item \code{marg_log_lik_sd} the standard deviation around the estimate
#'     \item \code{estimates} the parameter estimates
#'       created during the marginal likelihood estimation
#'     \item \code{trees} the trees
#'       created during the marginal likelihood estimation
#'   }
#' @author Richèl J.C. Bilderbeek
#' @noRd
bbt_process_pkg_output <- function(
  out,
  mcmc,
  beast2_working_dir = tempfile(pattern = "beast2_tmp_folder"),
  alignment_ids = NA
) {
  if (beautier::is_mcmc_nested_sampling(mcmc)) {
    out <- bbt_process_pkg_output_ns(
      out = out,
      beast2_working_dir = beast2_working_dir,
      alignment_ids = alignment_ids
    )
  }
  out
}
