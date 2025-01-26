test_that("issue 108", {
  fasta_filename <- get_beautier_path("babette_issue_108.fasta")
  output_filename <- get_beautier_tempfilename()
  tipdates_filename <- get_beautier_path("babette_issue_108_tipdates.txt")
  expected_output_filename <- get_beautier_path("babette_issue_108_expected.xml")
  tipdates_table <- readr::read_tsv(
    tipdates_filename,
    col_names = c("A", "year"),
    show_col_types = FALSE
  )
  expect_silent(
    create_beast2_input_file(
      input_filename = fasta_filename,
      output_filename,
      tipdates_filename = tipdates_filename,
      clock_model = create_rln_clock_model(),
      site_model = create_gtr_site_model(),
      mcmc = create_mcmc(chain_length = 10000000),
      tree_prior = create_cbs_tree_prior(),
      beauti_options = create_beauti_options_v2_6(nucleotides_uppercase = TRUE)
    )
  )

  # Works?
  beastier::is_beast2_input_file(output_filename)

  # Really really Works?
  beast2_xml_lines <- readr::read_lines(output_filename)
  beastier::are_beast2_input_lines_deep(beast2_xml_lines)

  remove_beautier_folder()
})
