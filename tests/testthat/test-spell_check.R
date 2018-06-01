context("spell_check")

test_that("no spelling errors", {
  ignore <- c(
    "beastier",
    "BEAUti",
    "beautier",
    "Bilderbeek",
    "DensiTree",
    "extdata",
    "FASTA",
    "http",
    "phylogenies",
    "phylogeny",
    "reproducibly",
    "Richel",
    "tracerer",
    "uk",
    "www"
  )
  errors <- devtools::spell_check(ignore = ignore)
  expect_equal(0, length(errors))
})
