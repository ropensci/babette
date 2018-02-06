.onLoad <- function(libname, pkgname){

  suppressPackageStartupMessages(
    lapply(
      c("beautier", "beastier", "tracerer"),
      library,
      character.only = TRUE,
      warn.conflicts = FALSE
    )
  )
  invisible()
}
