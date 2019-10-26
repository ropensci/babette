#' Prepare for BEAST2 creating files
#'
#' The inference model and BEAST2 options contain paths that may point
#' to sub-sub-sub folders. Create those folders and test
#' if thes folders can be written to
#' @export
prepare_file_creation <- function(
  inference_model,
  beast2_options
) {
  # These are the files that need to be created
  filenames <- c(
    inference_model$mcmc$tracelog$filename,
    inference_model$mcmc$screenlog$filename,
    inference_model$mcmc$treelog$filename,
    beast2_options$output_state_filename
  )
  # Create the folders, do not warn if these already exist
  for (filename in filenames) {
    dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)
  }
  # Create and delete the files
  for (filename in filename) {
    file.create(filename, showWarnings = FALSE)
    if (!file.exists(filename)) {
      stop(
        "Cannot create file '", filename, "'. \n",
        "Maybe no permissions to write there?"
      )
    }
    file.remove(filename)
    testit::assert(!file.exists(filename))
  }
}
