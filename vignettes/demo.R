## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

## ------------------------------------------------------------------------
sample_interval <- 1000
mcmc = create_mcmc(
  chain_length = 10000, 
  store_every = sample_interval
)

## ------------------------------------------------------------------------
library(ggplot2)
p <- ggplot(
  data = out$estimates,
  aes(x = Sample)
) 
p + geom_line(aes(y = TreeHeight), color = "green")
p + geom_line(aes(y = YuleModel), color = "red")
p + geom_line(aes(y = birthRate), color = "blue")


## ------------------------------------------------------------------------
traces <- remove_burn_ins(
  traces = out$estimates, 
  burn_in_fraction = 0.2
)
esses <- t(calc_esses(traces, sample_interval = sample_interval))
colnames(esses) <- "ESS"
knitr::kable(esses)

## ------------------------------------------------------------------------
sum_stats <- t(calc_summary_stats(traces$posterior, sample_interval = sample_interval))
colnames(sum_stats) <- "Statistic"
knitr::kable(sum_stats)

## ----fig.width=7, fig.height=7-------------------------------------------
plot_densitree(out$anthus_aco_trees, width = 2)

## ------------------------------------------------------------------------
p <- ggplot(
  data = out$estimates,
  aes(x = Sample)
) 
p + geom_line(aes(y = TreeHeight.aco), color = "green") +
   geom_line(aes(y = TreeHeight.nd2), color = "lightgreen")
p + geom_line(aes(y = YuleModel.aco), color = "red") +
  geom_line(aes(y = YuleModel.nd2), color = "pink")
p + geom_line(aes(y = birthRate.aco), color = "blue") + 
  geom_line(aes(y = birthRate.nd2), color = "cyan")


## ------------------------------------------------------------------------
traces <- remove_burn_ins(traces = out$estimates, burn_in_fraction = 0.2)
esses <- t(calc_esses(traces, sample_interval = sample_interval))
colnames(esses) <- "ESS"
knitr::kable(esses)

## ----fig.width=7, fig.height=7-------------------------------------------
plot_densitree(out$anthus_aco_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
plot_densitree(out$anthus_nd2_trees, width = 2)

## ------------------------------------------------------------------------
p <- ggplot(
  data = out$estimates,
  aes(x = Sample)
) 
p + geom_line(aes(y = TreeHeight.aco), color = "green") +
   geom_line(aes(y = TreeHeight.nd2), color = "lightgreen")
p + geom_line(aes(y = YuleModel.aco), color = "red") +
  geom_line(aes(y = YuleModel.nd2), color = "pink")
p + geom_line(aes(y = birthRate.aco), color = "blue") + 
  geom_line(aes(y = birthRate.nd2), color = "cyan")


## ------------------------------------------------------------------------
traces <- remove_burn_ins(traces = out$estimates, burn_in_fraction = 0.2)
esses <- t(calc_esses(traces, sample_interval = sample_interval))
colnames(esses) <- "ESS"
knitr::kable(esses)

## ----fig.width=7, fig.height=7-------------------------------------------
plot_densitree(out$anthus_aco_trees, width = 2)

## ----fig.width=7, fig.height=7-------------------------------------------
plot_densitree(out$anthus_nd2_trees, width = 2)

