context("get_alignment_ids")

test_that("use", {

  testthat::expect_equal(
    rbeast2:::get_alignment_ids(get_path("2_4.xml")),
    c("test_output_0")
  )
  testthat::expect_equal(
    rbeast2:::get_alignment_ids(xml_filename = get_path("anthus_2_4.xml")),
    c("Anthus_nd2", "Anthus_aco")
  )

})

test_that("use", {

  testthat::expect_error(
    rbeast2:::get_alignment_ids("abs.ent"),
    "'xml_filename' must be the name of an existing file"
  )

})
