#' Get the alignment IDs from one or more 'BEAST2' XML input files.
#' @param xml_filename name of a 'BEAST2' XML input file.
#' @return a character vector with one or more alignment IDs.
#' @author Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' alignment_id <- get_alignment_ids_from_xml(
#'   get_babette_path("2_4.xml")
#' )
#' expect_equal(alignment_id, "test_output_0")
#'
#' alignment_ids <- get_alignment_ids_from_xml(
#'   get_babette_path("anthus_2_4.xml")
#' )
#' expect_equal(alignment_ids, c("Anthus_nd2", "Anthus_aco"))
#' @export
get_alignment_ids_from_xml <- function(
  xml_filename
) {
  beautier::check_file_exists(xml_filename, "xml_filename")

  xml <- xml2::read_xml(xml_filename)
  xml_data <- xml2::xml_find_all(xml, ".//data")
  ids <- xml2::xml_attr(xml_data, "id")
  ids
}
