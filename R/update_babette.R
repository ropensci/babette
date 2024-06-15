#' Deprecated function.
#'
#' Update all babette dependencies, by installing their
#' latest versions.
#'
#' See \url{https://github.com/richelbilderbeek/babetteinstall}
#' how to do this.
#' @param upgrade Deprecated.
#' @return Nothing.
#' @author Giovanni Laudanno, Richèl J.C. Bilderbeek
#' @export
update_babette <- function(upgrade = "default") {
  stop(
    "'update_babette' is deprecated, ",
    "as it did not follow CRAN guidelines. ",
    "",
    "Tip: one can use 'babetteinstall::updateba_bette' ",
    "(from 'https://github.com/richelbilderbeek/babetteinstall')"
  )
}
