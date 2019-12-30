#' Checks if \link{\code{bbt_run}} has the 'BEAST2' packages needed to process
#' its arguments. Will \link{stop} if not.
#'
#' For example, to use a Nested Sampling MCMC, the 'BEAST2' 'NS' package
#' needs to be installed.
#' @inheritParams default_params_doc
#' @examples
#' library(testthat)
#'
#' # This test uninstalls the NS 'BEAST2' package.
#' # Only do that on CI services, else a user without internet
#' # suddenly finds the NS 'BEAST2' package installed and unable
#' # to reinstall it
#' if (is_beast2_installed() && is_on_ci()) {
#'
#'   # Check to need to install NS later
#'   was_ns_installed <- is_beast2_ns_pkg_installed()
#'
#'   if (is_beast2_ns_pkg_installed()) {
#'     uninstall_beast2_pkg("NS")
#'   }
#'
#'   # Without the NS 'BEAST2' package installed,
#'   # a Nested Sampling MCMC cannot be created.
#'   expect_false(is_beast2_ns_pkg_installed())
#'   expect_error(
#'     check_beast2_pkgs(
#'       mcmc = create_ns_mcmc()
#'     ),
#'     "Must install 'NS' to use 'create_ns_mcmc'."
#'   )
#'
#'   install_beast2_pkg("NS")
#'
#'   expect_silent(
#'     check_beast2_pkgs(
#'       mcmc = create_ns_mcmc()
#'     )
#'   )
#'
#'   if (!was_ns_installed) {
#'     uninstall_beast2_pkg("BS")
#'   }
#' }
#' @export
check_beast2_pkgs <- function(
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
      "one must use the binary 'BEAST2' executable (that is, using ",
      "'beast2_path = get_default_beast2_bin_path()')"
    )
  }
}
