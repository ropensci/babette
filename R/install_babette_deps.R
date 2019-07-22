#' Install the babette dependencies, including BEAST2
#'
#' Newer code of \code{babette} are not on CRAN yet,
#' but still on GitHub only. This function installs the GitHub's
#' master/stable branch.
#'
#' This function also installs BEAST2 if absent and installs the
#' \code{NS} BEAST2 package.
#' @author Richèl J.C. Bilderbeek
#' @export
install_babette_deps <- function() {
  repo_names <- c("beautier", "tracerer", "beastier", "mauricer")
  for (repo_name in repo_names) {
    remotes::install_github(
      paste0("ropensci/", repo_name),
      dependencies = TRUE
    )
  }
  if (!beastier::is_beast2_installed()) {
    beastier::install_beast2()
  }
  if (!mauricer::is_beast2_plg_installed("NS")) {
    mauricer::install_beast2_pkg("NS")
  }
}
