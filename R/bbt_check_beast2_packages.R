#' Checks if \code{bbt_run} has the BEAST packages needed to process
#' its arguments. Will throw if not.
#' @inheritParams bbt_default_params_doc
bbt_check_beast2_packages <- function(
  mcmc,
  beast2_path = get_default_beast2_bin_path()
) {
  if (beautier:::is_mcmc_nested_sampling(mcmc) &&
    !mauricer::is_beast2_pkg_installed("NS")
  ) {
    stop(
      "Must install 'NS' to use 'create_mcmc_nested_sampling'. ",
      "Tip: use 'mauricer::install_beast2_pkg(\"NS\")'"
    )
  }
  if (beautier::is_mcmc_nested_sampling(mcmc) &&
      !beastier::is_bin_path(beast2_path)
  ) {
    stop(
      "When using nested sampling (that is, ",
      "using 'create_mcmc_nested_sampling'), ",
      "one must use the binary BEAST2 executable (that is, using ",
      "'beast2_path = get_default_beast2_bin_path()')"
    )
  }
}
