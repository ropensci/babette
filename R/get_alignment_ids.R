#' Get the alignment IDs from a file with one alignment
#' @param xml_filename name of a BEAST2 XML input filename
#' @return a character vector with one or more alignment IDs
#' @author Richèl J.C. Bilderbeek
#' @examples
#'   alignment_id <- babette::get_alignment_ids(
#'     get_babette_path("2_4.xml")
#'   )
#'   testit::assert(alignment_id == "test_output_0")
#'
#'   alignment_ids <- babette::get_alignment_ids(
#'     get_babette_path("anthus_2_4.xml")
#'   )
#'   testit::assert(alignment_ids
#'     == c("Anthus_nd2", "Anthus_aco")
#'   )
#' @noRd
get_alignment_ids <- function(
  xml_filename
) {
  beautier::check_file_exists(xml_filename, "xml_filename")

  xml <- xml2::read_xml(xml_filename)
  xml_data <- xml2::xml_find_all(xml, ".//data")
  ids <- xml2::xml_attr(xml_data, "id")
  ids
}
