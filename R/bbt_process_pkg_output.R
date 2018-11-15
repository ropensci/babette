#' Process the BEAST2 output dependent on BEAST2 package specifics
#' @param out complete babette output
#' @param mcmc an MCMC
bbt_process_pkg_output <- function(
  out,
  mcmc,
  alignment_ids = NA
) {
  if (beautier:::is_mcmc_nested_sampling(mcmc)) {
    out$ns <- bbt_create_ns(out$output) # nolint internal function
    testit::assert(!beautier:::is_one_na(alignment_ids))
    testit::assert(length(alignment_ids) == 1)
    ns_log_filename <- paste0(alignment_ids, ".posterior.log")
    ns_trees_filename <- paste0(alignment_ids, ".posterior.trees")
    out$ns$estimates <- tracerer::parse_beast_log(ns_log_filename)
    out$ns$trees <- tracerer::parse_beast_trees(ns_trees_filename)
  }
  out
}
