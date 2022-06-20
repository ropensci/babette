test_that("use", {

  expect_equal(
    get_alignment_ids_from_xml(get_babette_path("2_4.xml")),
    c("test_output_0")
  )
  expect_equal(
    get_alignment_ids_from_xml(get_babette_path("anthus_2_4.xml")),
    c("Anthus_nd2", "Anthus_aco")
  )

})

test_that("use", {
  expect_error(get_alignment_ids_from_xml("abs.ent"), "File '.*' not found")

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
})
