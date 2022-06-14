#' Get the alignment IDs from one or more 'BEAST2' XML input files.
#' @param xml_filename name of a 'BEAST2' XML input file.
#' @return a character vector with one or more alignment IDs.
#' @author Richèl J.C. Bilderbeek
#' @examples
#' beastier::remove_beaustier_folder()
#' beastier::check_empty_beaustier_folders()
#'
#' alignment_ids <- get_alignment_ids_from_xml(
#'   get_babette_path("anthus_2_4.xml")
#' )
#'
#' beastier::remove_beaustier_folder()
#' beastier::check_empty_beaustier_folders()
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
