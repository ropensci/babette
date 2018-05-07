## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

## ------------------------------------------------------------------------
sample_interval <- 1000
mcmc <- create_mcmc(
  chain_length = 10000, 
  store_every = sample_interval
)

## ------------------------------------------------------------------------
beast2_input_file <- tempfile(fileext = ".xml")
create_beast2_input_file(
  get_babette_path("anthus_aco.fas"),
  output_filename = beast2_input_file,
  mcmc = mcmc
)
testit::assert(file.exists(beast2_input_file))

## ------------------------------------------------------------------------
print(head(readLines(beast2_input_file)))

## ------------------------------------------------------------------------
testit::assert(is_beast2_input_file(beast2_input_file))

## ------------------------------------------------------------------------
log_filename <- tempfile(fileext = ".log")
trees_filename <- tempfile(fileext = "trees")
state_filename <- tempfile(fileext = ".xml.state")
run_beast2(
  input_filename = beast2_input_file,
  output_log_filename = log_filename,
  output_trees_filenames = trees_filename,
  output_state_filename = state_filename
)
testit::assert(file.exists(log_filename))
testit::assert(file.exists(trees_filename))
testit::assert(file.exists(state_filename))


## ------------------------------------------------------------------------
print(head(readLines(log_filename)))
print(tail(readLines(log_filename)))

## ------------------------------------------------------------------------
print(head(readLines(trees_filename)))
print(tail(readLines(trees_filename)))

## ------------------------------------------------------------------------
print(head(readLines(state_filename)))
print(tail(readLines(state_filename)))

## ------------------------------------------------------------------------
knitr::kable(head(parse_beast_log(log_filename)))

## ----fig.width = 7, fig.height = 7---------------------------------------
plot_densitree(parse_beast_trees(trees_filename))

## ------------------------------------------------------------------------
knitr::kable(head(parse_beast_state_operators(state_filename)))

