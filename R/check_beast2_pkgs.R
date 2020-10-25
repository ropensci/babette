#' Checks if \code{\link{bbt_run}} has the 'BEAST2' packages needed to process
#' its arguments. Will \link{stop} if not.
#'
#' For example, to use a Nested Sampling MCMC, the 'BEAST2' 'NS' package
#' needs to be installed.
#' @inheritParams default_params_doc
#' @examples
#' if (is_beast2_installed()) {
#'   # Minimal BEAST2 setup
#'   check_beast2_pkgs(mcmc = create_mcmc())
#'
#'   # BEAST2 with NS package installed
#'   if (is_beast2_ns_pkg_installed()) {
#'     check_beast2_pkgs(mcmc = create_ns_mcmc())
#'   }
#' }
#' @export
check_beast2_pkgs <- function(
  mcmc,
  beast2_path = get_default_beast2_bin_path()
) {
  beast2_folder  <- dirname(dirname(dirname(beast2_path)))
  if (beautier::is_mcmc_nested_sampling(mcmc) &&
    isFALSE(mauricer::is_beast2_ns_pkg_installed(beast2_folder = beast2_folder))
  ) {
    stop(
      "Must install 'NS' to use 'create_ns_mcmc'. ",
      "Cannot find BEAST2 'NS' package at BEAST2 folder '",
      beast2_folder, "'. ",
      "Tip: use 'mauricer::install_beast2_pkg(\"NS\")'"
    )
  }
  if (beautier::is_mcmc_nested_sampling(mcmc) &&
      !beastier::is_bin_path(beast2_path)
  ) {
    stop(
      "When using nested sampling (that is, ",
      "using 'create_ns_mcmc'), ",
      "one must use the binary 'BEAST2' executable (that is, using ",
      "'beast2_path = get_default_beast2_bin_path()')"
    )
  }
}
