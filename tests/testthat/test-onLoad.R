context("onLoad")

test_that("use", {

  expect_silent(
    babette:::.onLoad(
      libname = "irrelevant",
      pkgname = "irrelevant"
    )
  )

})
