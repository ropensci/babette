#' Internal function to prepare for 'BEAST2' creating files
#'
#' The inference model and 'BEAST2' options contain paths that may point
#' to sub-sub-sub folders. Create those folders and test
#' if these folders can be written to
#' @inheritParams default_params_doc
#' @examples
#' # This example will fail on the CRAN
#' # r-oldrel-macos-x86_64 platform
#' if (rappdirs::app_dir()$os != "mac") {
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#'
#'   # For a test inference model, the files can be prepared
#'   inference_model <- create_test_inference_model()
#'   beast2_options <- create_beast2_options()
#'   prepare_file_creation(inference_model, beast2_options)
#'
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#' }
#' @export
prepare_file_creation <- function(
  inference_model,
  beast2_options
) {
  # These are the files that need to be created
  filenames <- c(
    beautier::get_inference_model_filenames(inference_model),
    beastier::get_beast2_options_filenames(beast2_options)
  )
  # Create the folders, do not warn if these already exist
  for (filename in filenames) {
    dir.create(dirname(filename), showWarnings = FALSE, recursive = TRUE)
  }
  # Create and delete the files
  for (filename in filename) {
    file.create(filename, showWarnings = FALSE)
    if (!file.exists(filename)) {
      message(
        "Cannot create file '", filename, "'",
        ", will try to gather some diagnostic info..."
      )
      message(
        "Warnings when creating the folder '", dirname(filename), "'"
      )
      dir.create(dirname(filename), showWarnings = TRUE, recursive = TRUE)
      message(
        "Warnings when creating the file '", filename, "'"
      )
      file.create(filename, showWarnings = FALSE)
      stop(
        "Cannot create file '", filename, "'. \n",
        "Maybe no permissions to write there?"
      )
    }
    file.remove(filename)
    testthat::expect_true(!file.exists(filename))
  }
  invisible(inference_model)
}
