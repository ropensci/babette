.onLoad <- function(libname, pkgname){

  suppressPackageStartupMessages(
    lapply(
      c("beautier", "beastier", "tracerer"),
      library,
      character.only = TRUE,
      warn.conflicts = FALSE
    )
  )
  #requireNamespace(beautier) # nolint
  #loadNamespace(beautier) # nolint
  #require(beautier) # nolint
  #loadNamespace(beautier) # nolint
  #create_beast2_input_file <- beautier::create_beast2_input_file # nolint
  #create_mcmc <- beautier::create_mcmc # nolint
  # library(beautier) # nolint
  # library(beastier) # nolint
  # library(tracerer) # nolint
  invisible()
}
