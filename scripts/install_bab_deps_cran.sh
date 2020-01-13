#!/bin/bash
#
# Script to install babette and its dependencies,
# using the latest CRAN versions
#
# Usage, locally:
#
#   ./install_bab_deps_cran.sh
#
Rscript -e 'remotes::install_version("nLTT", version = "1.4.3", repos = "http://cran.r-project.org")'
Rscript -e 'remotes::install_version("beautier", version = "2.3.2", repos = "http://cran.r-project.org")'
Rscript -e 'remotes::install_version("tracerer", version = "2.0.2", repos = "http://cran.r-project.org")'
Rscript -e 'remotes::install_version("beastier", version = "2.1.1", repos = "http://cran.r-project.org")'
Rscript -e 'remotes::install_version("mauricer", version = "2.0.5", repos = "http://cran.r-project.org")'
Rscript -e 'remotes::install_version("babette", version = "2.1.1", repos = "http://cran.r-project.org")'
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
Rscript -e 'if (!mauricer::is_beast2_pkg_installed("NS")) mauricer::install_beast2_pkg("NS")'
