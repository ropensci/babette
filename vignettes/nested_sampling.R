## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(babette)

## ------------------------------------------------------------------------

if (!beastier::is_beast2_installed())
{
  print("Installing BEAST2 to default location")
  beastier::install_beast2()
}
testthat::expect_true(beastier::is_beast2_installed())

## ------------------------------------------------------------------------
if (!mauricer::mrc_is_installed("NS"))
{
  print("Installing BEAST2 package 'NS'")
  mauricer::mrc_install("NS")
}
testthat::expect_true(mauricer::mrc_is_installed("NS"))

## ------------------------------------------------------------------------
interpret_bayes_factor <- function(bayes_factor) {
  if (bayes_factor < 10^-2.0) {
    "decisive for GTR"
  } else if (bayes_factor < 10^-1.5) {
    "very strong for GTR"
  } else if (bayes_factor < 10^-1.0) {
    "strong for GTR"
  } else if (bayes_factor < 10^-0.5) {
    "substantial for GTR"
  } else if (bayes_factor < 10^0.0) {
    "barely worth mentioning for GTR"
  } else if (bayes_factor < 10^0.5) {
    "barely worth mentioning for JC69"
  } else if (bayes_factor < 10^1.0) {
    "substantial for JC69"
  } else if (bayes_factor < 10^1.5) {
    "strong for JC69"
  } else if (bayes_factor < 10^2.0) {
    "very strong for JC69"
  } else {
    "decisive for JC69"
  }
}
testit::assert(interpret_bayes_factor(1 / 123.0) == "decisive for GTR")
testit::assert(interpret_bayes_factor(1 / 85.0) == "very strong for GTR")
testit::assert(interpret_bayes_factor(1 / 12.5) == "strong for GTR")
testit::assert(interpret_bayes_factor(1 / 8.5) == "substantial for GTR")
testit::assert(interpret_bayes_factor(1 / 1.5) == "barely worth mentioning for GTR")
testit::assert(interpret_bayes_factor(0.99) == "barely worth mentioning for GTR")
testit::assert(interpret_bayes_factor(1.01) == "barely worth mentioning for JC69")
testit::assert(interpret_bayes_factor(1.5) == "barely worth mentioning for JC69")
testit::assert(interpret_bayes_factor(8.5) == "substantial for JC69")
testit::assert(interpret_bayes_factor(12.5) == "strong for JC69")
testit::assert(interpret_bayes_factor(85.0) == "very strong for JC69")
testit::assert(interpret_bayes_factor(123.0) == "decisive for JC69")

## ------------------------------------------------------------------------
fasta_filename <- get_babette_path("anthus_aco_sub.fas")
image(ape::read.FASTA(fasta_filename))

## ------------------------------------------------------------------------
mcmc <- beautier::create_mcmc_nested_sampling(
  chain_length = 10000, 
  store_every = -1,
  particle_count = 1,
  sub_chain_length = 500
)

## ------------------------------------------------------------------------
out_jc69 <- bbt_run(
  fasta_filename = fasta_filename,
  site_model = beautier::create_jc69_site_model(),
  mcmc = mcmc,
  beast2_path = beastier::get_default_beast2_bin_path()
)
out_gtr <- bbt_run(
  fasta_filename = fasta_filename,
  site_model = beautier::create_gtr_site_model(),
  mcmc = mcmc,
  beast2_path = beastier::get_default_beast2_bin_path()
)

## ------------------------------------------------------------------------
df <- data.frame(
  model = c("JC69", "GTR"),
  mar_log_lik = c(out_jc69$ns$marg_log_lik, out_gtr$ns$marg_log_lik),
  mar_log_lik_sd = c(out_jc69$ns$marg_log_lik_sd, out_gtr$ns$marg_log_lik_sd)
)
knitr::kable(df)

## ------------------------------------------------------------------------
bayes_factor <- exp(out_jc69$ns$marg_log_lik) / exp(out_gtr$ns$marg_log_lik)
print(interpret_bayes_factor(bayes_factor))

