inference_model <- beautier::create_inference_model(
  site_model = beautier::create_jc69_site_model(),
  clock_model = beautier::create_strict_clock_model(),
  tree_prior = beautier::create_yule_tree_prior(),
  mcmc = beautier::create_mcmc(chain_length = 3e3, store_every = 1000)
)

babette::bbt_run_from_model(
  fasta_filename = beautier::get_fasta_filename(),
  inference_model = inference_model,
  beast2_options = beastier::create_beast2_options(
    input_filename = "for_richel.xml",
    verbose = TRUE
  )
)

