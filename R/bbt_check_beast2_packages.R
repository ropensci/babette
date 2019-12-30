#' Checks if \code{bbt_run} has the BEAST packages needed to process
#' its arguments. Will throw if not.
#' @inheritParams bbt_default_params_doc
#' @export
bbt_check_beast2_packages <- function(
  mcmc,
  beast2_path = get_default_beast2_bin_path()
) {
  if (beautier::is_mcmc_nested_sampling(mcmc) &&
    isFALSE(mauricer::is_beast2_ns_pkg_installed())
  ) {
    stop(
      "Must install 'NS' to use 'create_ns_mcmc'. ",
      "Tip: use 'mauricer::install_beast2_pkg(\"NS\")'"
    )
  }
  if (beautier::is_mcmc_nested_sampling(mcmc) &&
      !beastier::is_bin_path(beast2_path)
  ) {
    stop(
      "When using nested sampling (that is, ",
      "using 'create_ns_mcmc'), ",
      "one must use the binary BEAST2 executable (that is, using ",
      "'beast2_path = get_default_beast2_bin_path()')"
    )
  }
}
