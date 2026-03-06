#' Warn when using files in a Dropbox-backed folder
#'
#' This helper function issues a warning if the supplied file or directory
#' path appears to be located inside a Dropbox-synced folder. Running BEAST2
#' from Dropbox-backed locations may cause file-locking issues while files
#' are being written.
#'
#' The function is intended as a non-blocking safeguard and does not prevent
#' execution.
#'
#' @param path A character string representing a file or directory path.
#'   Defaults to the current working directory.
#'
#' @return Invisibly returns the input \code{path}.
#'
#' @examples
#' warn_if_dropbox("~/Dropbox/myproject")
#' warn_if_dropbox(tempdir())
#'
#' @export
warn_if_dropbox <- function(path = getwd()) {
  if (is_dropbox_path(path)) {
    warning(
      "It looks like you are running babette with files in a Dropbox folder. ",
      "This may cause file-locking issues (see issue #65: ",
      "https://github.com/ropensci/babette/issues/65). ",
      "Consider moving your project to a non-Dropbox folder.",
      call. = FALSE
    )
  }
  invisible(path)
}
