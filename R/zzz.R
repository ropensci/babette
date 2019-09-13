.onLoad <- function(libname, pkgname) { # nolint .onLoad cannot be snake_case

  update_babette()

  suppressPackageStartupMessages(
    lapply(
      c("beautier", "beastier", "mauricer", "tracerer"),
      library,
      character.only = TRUE,
      warn.conflicts = FALSE
    )
  )
  invisible()
}
