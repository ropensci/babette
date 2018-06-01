context("spell_check")

test_that("use", {
  ignore <- c(
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
    "uk",
    "www"
  )
  errors <- devtools::spell_check(ignore = ignore)
  expect_equal(0, length(errors))
})
