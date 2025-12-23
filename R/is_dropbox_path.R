is_dropbox_path <- function(path) {
  stopifnot(is.character(path), length(path) == 1)
  grepl("Dropbox", path, fixed = TRUE)
}
