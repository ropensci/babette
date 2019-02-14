#' Process the BEAST2 output dependent on BEAST2 package specifics
#' @param out complete babette output
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
#' @author Richel J.C. Bilderbeek
#' @noRd
bbt_process_pkg_output <- function(
  out,
  mcmc,
  alignment_ids = NA
) {
  if (beautier:::is_mcmc_nested_sampling(mcmc)) {
    out$ns <- bbt_create_ns(out$output) # nolint internal function
    testit::assert(!beautier::is_one_na(alignment_ids))
    testit::assert(length(alignment_ids) == 1)
    ns_log_filename <- paste0(alignment_ids, ".posterior.log")
    ns_trees_filename <- paste0(alignment_ids, ".posterior.trees")
    out$ns$estimates <- tracerer::parse_beast_log(ns_log_filename)
    out$ns$trees <- tracerer::parse_beast_trees(ns_trees_filename)
    file.remove(ns_log_filename)
    file.remove(ns_trees_filename)
  }
  out
}
