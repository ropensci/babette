# Issue #101
if (!beastier::is_beast2_installed()) {
  stop("Beast2 must be installed.")
}

zip_filename_url <- "https://github.com/ropensci/babette/files/7802540/airCommunitiesMM_1.zip"
zip_filename <- tempfile(fileext = ".zip")
download.file(url = zip_filename_url, destfile = zip_filename)
beast2_input_file <- unzip(zipfile = zip_filename, exdir = tempfile())
beast2_input_file

beastier::run_beast2_from_options(
  beast2_options = beastier::create_beast2_options(
    input_filename = beast2_input_file,
    verbose = TRUE
  )
)
