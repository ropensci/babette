#' Detect if a path is inside a Dropbox-backed folder
#'
#' This helper function checks whether a given file or directory path
#' appears to be located inside a Dropbox-synced folder. It is used to
#' warn users about potential file-locking issues when running BEAST2
#' from Dropbox-backed locations.
#'
#' The detection is based on simple case-insensitive string matching
#' and is intended as a best-effort heuristic rather than a guarantee.
#'
#' @param path A character string representing a file or directory path.
#'
#' @return \code{TRUE} if the path appears to be in a Dropbox folder,
#'   \code{FALSE} otherwise.
#'
#' @examples
#' is_dropbox_path("~/Dropbox/myproject")
#' is_dropbox_path("/tmp/myproject")
#'
#' @export
is_dropbox_path <- function(path) {
  # Return FALSE for invalid inputs instead of crashing
  if (is.null(path)) return(FALSE)
  if (!is.character(path)) return(FALSE)
  if (length(path) != 1) return(FALSE)
  if (is.na(path)) return(FALSE)
  if (nchar(path) == 0) return(FALSE)

  normalized_path <- tryCatch(
    normalizePath(path, winslash = "/", mustWork = FALSE),
    error = function(e) path
  )

  grepl("Dropbox", normalized_path, ignore.case = TRUE)
}
