#' Get the full paths of files in the \code{inst/extdata} folder
#' @param filenames the files' names, without the path
#' @return the filenames' full paths, if and only if
#'   all files are present. Will stop otherwise.
#' @author Richèl J.C. Bilderbeek
#' @seealso for one file, use \code{\link{get_babette_path}}
#' @examples
#' library(testthat)
#'
#' filenames <- c("anthus_aco.fas", "anthus_nd2.fas")
#' full_paths <- get_babette_paths(filenames)
#' expect_equal(length(full_paths), 2)
#' expect_true(all(file.exists(full_paths)))
#' @export
get_babette_paths <- function(filenames) {

  for (i in seq_along(filenames)) {
    filenames[i] <- babette::get_babette_path(filenames[i])
  }

  filenames
}
