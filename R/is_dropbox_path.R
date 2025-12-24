#' Detect if a path is inside a Dropbox-backed folder
#'
#' @param path A character string representing a file or directory path
#' @return TRUE if path appears to be in Dropbox, FALSE otherwise
#' @details This function uses simple path string matching to detect
#'   Dropbox folders. Returns FALSE for invalid inputs (NA, NULL, etc.)
#'   rather than erroring.
#' @noRd
is_dropbox_path <- function(path) {
  # Return FALSE for invalid inputs instead of crashing
  if (is.null(path)) return(FALSE)
  if (!is.character(path)) return(FALSE)
  if (length(path) != 1) return(FALSE)
  if (is.na(path)) return(FALSE)
  if (nchar(path) == 0) return(FALSE)  # Empty string

  # Now we know path is a single valid string
  # Normalize path to handle relative paths, ~, etc.
  normalized_path <- tryCatch(
    normalizePath(path, winslash = "/", mustWork = FALSE),
    error = function(e) return(path)  # If normalizePath fails, use original
  )

  # Check for Dropbox in path (case-insensitive)
  grepl("Dropbox", normalized_path, ignore.case = TRUE)
}
