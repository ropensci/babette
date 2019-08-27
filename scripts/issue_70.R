# Can babette run on Peregrine?
# Issue 70, Issue #70
#
# R script to test if babette runs on peregrine

# Copied from peregrine
get_pff_tempdir <- function() {
  dirname <- file.path(
    rappdirs::user_cache_dir(),
    basename(tempfile())
  )
  dirname
}

# Copied from peregrine
get_pff_tempfile <- function(
  pattern = "pff_",
  pff_tmpdir = get_pff_tempdir(),
  fileext = ""
) {
  filename <- tempfile(
    pattern = pattern,
    tmpdir = pff_tmpdir,
    fileext = fileext
  )
  testit::assert(!file.exists(filename))
  filename
}

babette::bbt_run_from_model(
  fasta_filename = beautier::get_fasta_filename(),
  inference_model = beautier::create_inference_model(
    site_model = beautier::create_jc69_site_model(),
    clock_model = beautier::create_strict_clock_model(),
    tree_prior = beautier::create_yule_tree_prior(),
    mcmc = beautier::create_mcmc(chain_length = 3e3)
  ),
  beast2_options = beastier::create_beast2_options(
    input_filename = get_pff_tempfile(pattern = "in_", fileext = ".xml"),
    output_log_filename = get_pff_tempfile(pattern = "out_", fileext = ".log"),
    output_trees_filenames = get_pff_tempfile(pattern = "out_", fileext = ".trees"),
    output_state_filename = get_pff_tempfile(pattern = "out_", fileext = ".state.xml"),
    beast2_working_dir = get_pff_tempfile(),
    beast2_path = beastier::get_default_beast2_bin_path(),
    verbose = TRUE
  )
)
