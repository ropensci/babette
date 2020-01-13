#!/bin/bash
#
# Script to install babette and its dependencies,
# using the bleeding-edge versions on GitHub
#
# Usage, locally:
#
#   ./install_bab_deps_github.sh
#
Rscript -e 'remotes::install_github("thijsjanzen/nLTT")'
Rscript -e 'remotes::install_github("ropensci/beautier")'
Rscript -e 'remotes::install_github("ropensci/tracerer")'
Rscript -e 'remotes::install_github("ropensci/beastier")'
Rscript -e 'remotes::install_github("ropensci/mauricer")'
Rscript -e 'remotes::install_github("ropensci/babette")'
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
Rscript -e 'if (!mauricer::is_beast2_pkg_installed("NS")) mauricer::install_beast2_pkg("NS")'
