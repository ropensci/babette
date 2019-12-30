#' Update all babette dependencies, by installing their
#' latest versions
#' @inheritParams remotes::install_github
#' @author Giovanni Laudanno, Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' if (is_on_travis()) {
#'
#'   # Updates the babette dependencies without asking
#'   update_babette(upgrade = "always")
#'
#'   # Updating again should produce no output, as there is no
#'   expect_silent(update_babette(upgrade = "always"))
#' }
#' @export
update_babette <- function(upgrade = "default") {
  repo_names <- c(
    "ropensci/beautier", "ropensci/tracerer", "ropensci/beastier",
    "ropensci/mauricer"
  )
  for (repo_name in repo_names) {
    remotes::install_github(
      repo_name,
      quiet = TRUE,
      dependencies = TRUE,
      upgrade = upgrade
    )
  }
}
