#' Checks if \code{bbt_run} has the BEAST packages needed to process
#' its arguments. Will throw if not.
#' @inheritParams bbt_default_params_doc
bbt_check_beast2_packages <- function(
  mcmc,
  beast2_path = get_default_beast2_bin_path()
) {
  if (beautier:::is_mcmc_nested_sampling(mcmc) &&
    !mauricer::mrc_is_installed("NS")
  ) {
    stop(
      "Must install 'NS' to use 'create_mcmc_nested_sampling'. ",
      "Tip: use 'mauricer::mrc_install(\"NS\")'"
    )
  }
}
