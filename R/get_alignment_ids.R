#' Get the alignment ID from a file with one alignment
#' @param xml_filename name of a BEAST2 XML input filename
#' @author Richel J.C. Bilderbeek
get_alignment_ids <- function(
  xml_filename
) {

  if (!file.exists(xml_filename)) {
    stop("'xml_filename' must be the name of an existing file")
  }

  xml <- xml2::read_xml(xml_filename)
  xml_data <- xml2::xml_find_all(xml, ".//data")
  ids <- xml2::xml_attr(xml_data, "id")
  ids
}
