# babette

[![Peer Review Status](https://badges.ropensci.org/209_status.svg)](https://github.com/ropensci/onboarding/issues/209)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/babette)](https://cran.r-project.org/package=babette)
[![](http://cranlogs.r-pkg.org/badges/grand-total/babette)]( https://CRAN.R-project.org/package=babette)
[![](http://cranlogs.r-pkg.org/badges/babette)](https://CRAN.R-project.org/package=babette)

Branch   |[GitHub Actions](https://github.com/ropensci/babette/actions)                                     |[![Travis CI logo](man/figures/TravisCI.png)](https://travis-ci.org)                                                |[![AppVeyor logo](man/figures/AppVeyor.png)](https://www.appveyor.com)                                                                                                                   |[![Codecov logo](man/figures/Codecov.png)](https://www.codecov.io)
---------|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------
`master` |![R-CMD-check](https://github.com/ropensci/babette/workflows/R-CMD-check/badge.svg?branch=master) |[![Build Status](https://travis-ci.org/ropensci/babette.svg?branch=master)](https://travis-ci.org/ropensci/babette) |[![Build status](https://ci.appveyor.com/api/projects/status/jv76errjocm5d5yq/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/babette-on-windows/branch/master)|[![codecov.io](https://codecov.io/github/ropensci/babette/coverage.svg?branch=master)](https://codecov.io/github/ropensci/babette/branch/master)
`develop`|![R-CMD-check](https://github.com/ropensci/babette/workflows/R-CMD-check/badge.svg?branch=develop)|[![Build Status](https://travis-ci.org/ropensci/babette.svg?branch=develop)](https://travis-ci.org/ropensci/babette)| .                                                                                                                                                                                       |[![codecov.io](https://codecov.io/github/ropensci/babette/coverage.svg?branch=develop)](https://codecov.io/github/ropensci/babette/branch/develop)

[![DOI](https://zenodo.org/badge/118616108.svg)](https://zenodo.org/badge/latestdoi/118616108)

`babette` is an R package that combines:

 * [beautier](https://github.com/ropensci/beautier) creates a BEAST2 input (`.xml`) file from an inference model
 * [tiebeaur](https://github.com/richelbilderbeek/tiebeaur) creates an inference model from a BEAST2 input (`.xml`) file :warning: experimental :warning:
 * [beastier](https://github.com/ropensci/beastier) runs BEAST2
 * [mauricer](https://github.com/ropensci/mauricer) install BEAST2 packages
 * [tracerer](https://github.com/ropensci/tracerer) parses BEAST2 output (`.log`, `.trees`, etc) files.

![babette logo](man/figures/babette_logo.png)

Related R packages:

 * [lumier](https://github.com/ropensci/lumier): Shiny app to help create the function call needed

Related R functions:

Related function                                                      |`babette` function
----------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------
`[ips::rbeauti](https://github.com/heibl/ips/blob/master/R/rbeauti.R)`|`[beautier::create_beast2_input_from_model](https://github.com/ropensci/beautier/blob/master/R/create_beast2_input_from_model.R)`

Related software:

 * [BEASTifier](https://github.com/josephwb/BEASTifier): command-line tool to generate BEAST2 XML input files

## Examples

See:

 * [lumier](https://github.com/ropensci/lumier): R Shiny app to help create the R function call needed
 * [examples](https://github.com/richelbilderbeek/babette_examples): examples tested by Travis CI and AppVeyor
 * [article](https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.13032), in 'Methods in Ecology and Evolution'
 * [Methods.blog post: The babette R Package: How to Sooth the Phylogenetic BEAST2](https://methodsblog.wordpress.com/2018/06/25/babette-beast2/)
 * [rOpenSci blog post: Call BEAST2 for Bayesian evolutionary analysis from R](https://ropensci.org/blog/2020/01/28/babette/)
 * [pre-print article](https://doi.org/10.1101/271866), in bioRxiv
 * ['babette' YouTube channel](https://www.youtube.com/watch?v=nA-0-Fc95xY&list=PLu8_ZyzXyRDFIRx-kdDI5Q6xVr-HnY7TB)

## Installation

See [doc/install.md](doc/install.md) (or just click [here](doc/install.md))

## FAQ

See [FAQ](doc/faq.md).

## Missing features/unsupported

`babette` cannot do everything `BEAUti` and `BEAST2` and `Tracer` can.

See [beautier](https://github.com/ropensci/beautier) 
for missing features in creating a BEAST2 input (`.xml`) file.

See [beastier](https://github.com/ropensci/beastier) for missing
features in running BEAST2

See [mauricer](https://github.com/ropensci/mauricer) for missing
features in installing BEAST2 packages.

See [tracerer](https://github.com/ropensci/tracerer) 
for missing features in parsing BEAST2 output (`.log`, `.trees`, etc) files.

## There is a feature I miss

See [CONTRIBUTING](CONTRIBUTING.md), at `Submitting use cases`

## I want to collaborate

See [CONTRIBUTING](CONTRIBUTING.md), at `Submitting code`

## I think I have found a bug

See [CONTRIBUTING](CONTRIBUTING.md), at `Submitting bugs` 

## There's something else I want to say

Sure, just add an Issue. Or send an email.

## Dependencies

Package                                          |[![Travis CI logo](man/figures/TravisCI.png)](https://travis-ci.org)                                                   |[![Codecov logo](man/figures/Codecov.png)](https://www.codecov.io)
-------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------
[beautier](https://github.com/ropensci/beautier) |[![Build Status](https://travis-ci.org/ropensci/beautier.svg?branch=master)](https://travis-ci.org/ropensci/beautier)  |[![codecov.io](https://codecov.io/github/ropensci/beautier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/beautier/branch/master)
[beastier](https://github.com/ropensci/beastier) |[![Build Status](https://travis-ci.org/ropensci/beastier.svg?branch=master)](https://travis-ci.org/ropensci/beastier)  |[![codecov.io](https://codecov.io/github/ropensci/beastier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/beastier/branch/master)
[mauricer](https://github.com/ropensci/mauricer) |[![Build Status](https://travis-ci.org/ropensci/mauricer.svg?branch=master)](https://travis-ci.org/ropensci/mauricer)  |[![codecov.io](https://codecov.io/github/ropensci/mauricer/coverage.svg?branch=master)](https://codecov.io/github/ropensci/mauricer/branch/master)
[phangorn](https://github.com/KlausVigo/phangorn)|[![Build Status](https://travis-ci.org/KlausVigo/phangorn.svg?branch=master)](https://travis-ci.org/KlausVigo/phangorn)|[![codecov.io](https://codecov.io/github/KlausVigo/phangorn/coverage.svg?branch=master)](https://codecov.io/github/KlausVigo/phangorn/branch/master)
[tracerer](https://github.com/ropensci/tracerer) |[![Build Status](https://travis-ci.org/ropensci/tracerer.svg?branch=master)](https://travis-ci.org/ropensci/tracerer)  |[![codecov.io](https://codecov.io/github/ropensci/tracerer/coverage.svg?branch=master)](https://codecov.io/github/ropensci/tracerer/branch/master)

## Windows

Package                                                                       | Status
------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[babette_on_windows](https://github.com/richelbilderbeek/babette_on_windows)  |[![Build status](https://ci.appveyor.com/api/projects/status/jv76errjocm5d5yq/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/babette-on-windows/branch/master)
[beastier_on_windows](https://github.com/richelbilderbeek/beastier_on_windows)|[![Build status](https://ci.appveyor.com/api/projects/status/ralex9sdnnxlwbgx/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beastier-on-windows/branch/master)
[beautier_on_windows](https://github.com/richelbilderbeek/beautier_on_windows)|[![Build status](https://ci.appveyor.com/api/projects/status/blvjo5pulbkqxrhb/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beautier-on-windows/branch/master)
[mauricer_on_windows](https://github.com/richelbilderbeek/mauricer_on_windows)|[![Build status](https://ci.appveyor.com/api/projects/status/bc43iwp68xo2dduh/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/mauricer-on-windows/branch/master)
[tracerer_on_windows](https://github.com/richelbilderbeek/tracerer_on_windows)|[![Build status](https://ci.appveyor.com/api/projects/status/jyhck66d6yrbr12h/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/tracerer-on-windows/branch/master)

## Related packages

Package                                     |[![Travis CI logo](man/figures/TravisCI.png)](https://travis-ci.org)                                             |[![Codecov logo](man/figures/Codecov.png)](https://www.codecov.io)
--------------------------------------------|-----------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------
[lumier](https://github.com/ropensci/lumier)|[![Build Status](https://travis-ci.org/ropensci/lumier.svg?branch=master)](https://travis-ci.org/ropensci/lumier)|[![codecov.io](https://codecov.io/github/ropensci/lumier/coverage.svg?branch=master)](https://codecov.io/github/ropensci/lumier/branch/master)

## External links

 * [BEAST2 GitHub](https://github.com/CompEvol/beast2)

## References

Article about `babette`:

 * Bilderbeek, Richèl JC, and Rampal S. Etienne. "babette: BEAUti 2, BEAST 2 and Tracer for R." Methods in Ecology and Evolution (2018). https://doi.org/10.1111/2041-210X.13032

```
@article{bilderbeek2018babette,
  title={babette: BEAUti 2, BEAST 2 and Tracer for R},
  author={Bilderbeek, Richèl JC and Etienne, Rampal S},
  journal={Methods in Ecology and Evolution},
  year={2018},
  publisher={Wiley Online Library}
}
```

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.

[![ropensci_footer](https://ropensci.org/public_images/ropensci_footer.png)](https://ropensci.org)
