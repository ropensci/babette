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
