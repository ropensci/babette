#' Detect if a path is inside a Dropbox-backed folder
#'
#' @param path A character string, usually a directory path
#' @return TRUE if path looks Dropbox-backed, FALSE otherwise
#' @noRd
is_dropbox_path <- function(path) {
  stopifnot(is.character(path), length(path) == 1)
  grepl("Dropbox", path, fixed = TRUE)
}
