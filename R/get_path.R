#' Get the full path of a file in the \code{inst/extdata} folder
#' @param filename the file's name, without the path
#' @return the full path of the filename
#' @author Richel J.C. Bilderbeek
#' @seealso for more files, use \code{\link{get_babette_paths}}
#' @examples
#'   testit::assert(is.character(get_babette_path("anthus_aco.fas")))
#'   testit::assert(is.character(get_babette_path("anthus_nd2.fas")))
#' @export
get_babette_path <- function(filename) {

  full <- system.file("extdata", filename, package = "babette")
  if (!file.exists(full)) {
    stop("'filename' must be the name of a file in 'inst/extdata'")
  }
  full
}
