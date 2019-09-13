#' Update all babette dependencies
#' @noRd
update_babette <- function() {
  if (!require("roxygen2")) {
    suppressMessages(install.packages("roxygen2"))
    library(roxygen2)
  }
  if (!require("ape")) {
    suppressMessages(install.packages("ape"))
    library(ape)
  }
  if (!require("testit")) {
    suppressMessages(install.packages("testit"))
    library(testit)
  }
  if (!require("phangorn")) {
    suppressMessages(install.packages("phangorn"))
    library(phangorn)
  }
  if (!require("devtools")) {
    suppressMessages(install.packages("devtools"))
    library(devtools)
  }
  if (!require("Rcpp")) {
    suppressMessages(install.packages("Rcpp"))
    library(Rcpp)
  }

  devtools::install_github("ropensci/beautier", quiet = TRUE, dependencies = TRUE, upgrade = "always")
  devtools::install_github("ropensci/beastier", quiet = TRUE, dependencies = TRUE, upgrade = "always")
  devtools::install_github("ropensci/mauricer", quiet = TRUE, dependencies = TRUE, upgrade = "always")
  devtools::install_github("ropensci/tracerer", quiet = TRUE, dependencies = TRUE, upgrade = "always")
}
