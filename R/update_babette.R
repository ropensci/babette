#' Update all babette dependencies
#' @noRd
update_babette <- function() {
  devtools::install_github("ropensci/beautier", quiet = TRUE, dependencies = TRUE, upgrade = "always")
  devtools::install_github("ropensci/beastier", quiet = TRUE, dependencies = TRUE, upgrade = "always")
  devtools::install_github("ropensci/mauricer", quiet = TRUE, dependencies = TRUE, upgrade = "always")
  devtools::install_github("ropensci/tracerer", quiet = TRUE, dependencies = TRUE, upgrade = "always")
}
