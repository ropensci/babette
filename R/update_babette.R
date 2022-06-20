#' Update all babette dependencies, by installing their
#' latest versions
#' @inheritParams remotes::install_github
#' @author Giovanni Laudanno, Richèl J.C. Bilderbeek
#' @examples
#' \dontrun{
#'   # Updates the babette dependencies without asking
#' }
#' beastier::remove_beaustier_folders()
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
