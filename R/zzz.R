.onLoad <- function(libname, pkgname){

  suppressPackageStartupMessages(
    lapply(
      c("beautier", "beastier", "tracerer", "mauricer"),
      library,
      character.only = TRUE,
      warn.conflicts = FALSE
    )
  )
  invisible()
}
