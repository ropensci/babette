#' Process the BEAST2 output dependent on BEAST2 package specifics
#' @param out complete babette output
#' @param mcmc an MCMC
bbt_process_pkg_output <- function(
  out,
  mcmc
) {
  if (beautier:::is_mcmc_nested_sampling(mcmc)) {
    out$ns <- bbt_create_ns(out$output) # nolint internal function
  }
  out
}
