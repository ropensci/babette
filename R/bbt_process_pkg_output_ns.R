#' Process the BEAST2 output when using the NS BEAST2 package
#' @inheritParams bbt_default_params_doc
#' @param out a list with the complete babette output, with elements:
#' \itemize{
#'   \item \code{output} textual output of a BEAST2 run
#' }
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
bbt_process_pkg_output_ns <- function(
  out,
  alignment_ids,
  beast2_working_dir = tempfile(pattern = "beast2_tmp_folder")
) {
  if (beautier::is_one_na(alignment_ids)) {
    stop("'alignment_ids' cannot be NA when there is a nested sampling MCMC")
  }
  testit::assert(!beautier::is_one_na(alignment_ids))
  testit::assert(length(alignment_ids) == 1)
  ns_log_filename <- file.path(
    beast2_working_dir, paste0(alignment_ids, ".posterior.log")
  )
  ns_trees_filename <- file.path(
    beast2_working_dir, paste0(alignment_ids, ".posterior.trees")
  )
  if (!file.exists(ns_log_filename)) {
    stop(
      "Nested sampling log file absent. ",
      "Cannot find file with name '", ns_log_filename, "'."
    )
  }
  if (!file.exists(ns_trees_filename)) {
    stop(
      "Nested sampling trees file absent. ",
      "Cannot find file with name '", ns_trees_filename, "'."
    )
  }
  testit::assert(file.exists(ns_log_filename))
  testit::assert(file.exists(ns_trees_filename))


  out$ns <- bbt_create_ns(out$output) # nolint internal function
  out$ns$estimates <- tracerer::parse_beast_log(ns_log_filename)
  out$ns$trees <- tracerer::parse_beast_trees(ns_trees_filename)
  out
}
