# babette

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![AppVeyor logo](pics/AppVeyor.png)](https://www.appveyor.com)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---|---
master|[![Build Status](https://travis-ci.org/richelbilderbeek/babette.svg?branch=master)](https://travis-ci.org/richelbilderbeek/babette)|[![Build status](https://ci.appveyor.com/api/projects/status/wy43dnx199ir3n2h/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/babette/branch/master)|[![codecov.io](https://codecov.io/github/richelbilderbeek/babette/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/babette/branch/master)
develop|[![Build Status](https://travis-ci.org/richelbilderbeek/babette.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/babette)|[![Build status](https://ci.appveyor.com/api/projects/status/wy43dnx199ir3n2h/branch/develop?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/babette/branch/develop)|[![codecov.io](https://codecov.io/github/richelbilderbeek/babette/coverage.svg?branch=develop)](https://codecov.io/github/richelbilderbeek/babette/branch/develop)

[![DOI](https://zenodo.org/badge/118616108.svg)](https://zenodo.org/badge/latestdoi/118616108)

`babette` is an R package that combines:

 * [beautier](https://github.com/richelbilderbeek/beautier) creates BEAST2 input (`.xml`) files.
 * [beastier](https://github.com/richelbilderbeek/beastier) runs BEAST2
 * [mauricer](https://github.com/richelbilderbeek/mauricer) install BEAST2 packages
 * [tracerer](https://github.com/richelbilderbeek/tracerer) parses BEAST2 output (`.log`, `.trees`, etc) files.

![babette logo](pics/babette_logo.png)

Related R packages:

 * [lumier](https://github.com/richelbilderbeek/lumier): Shiny app to help create the function call needed

## Examples

See:

 * [lumier](https://github.com/richelbilderbeek/lumier): R Shiny app to help create the R function call needed
 * [examples](doc/examples.md)
 * [article](https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.13032), in 'Methods in Ecology and Evolution'
 * [blog post](https://methodsblog.wordpress.com/2018/06/25/babette-beast2/) in Methods.Blog
 * [pre-print article](https://doi.org/10.1101/271866), in bioRxiv
 * ['babette' YouTube channel](https://www.youtube.com/watch?v=nA-0-Fc95xY&list=PLu8_ZyzXyRDFIRx-kdDI5Q6xVr-HnY7TB)

## Installation

See [doc/install.md](doc/install.md) (or just click [here](doc/install.md))

## FAQ

See [FAQ](doc/faq.md).

## Missing features/unsupported

`babette` cannot do everything `BEAUti` and `BEAST2` and `Tracer` can.

See [beautier](https://github.com/richelbilderbeek/beautier) 
for missing features in creating a BEAST2 input (`.xml`) file.

See [beastier](https://github.com/richelbilderbeek/beastier) for missing
features in running BEAST2

See [mauricer](https://github.com/richelbilderbeek/mauricer) for missing
features in installing BEAST2 packages.

See [tracerer](https://github.com/richelbilderbeek/tracerer) 
for missing features in parsing BEAST2 output (`.log`, `.trees`, etc) files.

## There is a feature I miss

See [CONTRIBUTING](CONTRIBUTING.md), at `Submitting use cases`

## I want to collaborate

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting code'

## I think I have found a bug

See [CONTRIBUTING](CONTRIBUTING.md), at 'Submitting bugs' 

## There's something else I want to say

Sure, just add an Issue. Or send an email.

## Package dependencies

Package|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![AppVeyor logo](pics/AppVeyor.png)](https://www.appveyor.com)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---|---
[beautier](https://github.com/richelbilderbeek/beautier)|[![Build Status](https://travis-ci.org/richelbilderbeek/beautier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/beautier)|[![Build status](https://ci.appveyor.com/api/projects/status/qlahq0nofnpg3i8j/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beautier/branch/master)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beautier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beautier/branch/master)
[beastier](https://github.com/richelbilderbeek/beastier)|[![Build Status](https://travis-ci.org/richelbilderbeek/beastier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/beastier)|[![Build status](https://ci.appveyor.com/api/projects/status/tny9jb7jkwbfamm2/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/beastier/branch/master)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beastier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beastier/branch/master)
[mauricer](https://github.com/richelbilderbeek/mauricer)|[![Build Status](https://travis-ci.org/richelbilderbeek/mauricer.svg?branch=master)](https://travis-ci.org/richelbilderbeek/mauricer)|[![Build status](https://ci.appveyor.com/api/projects/status/1jf90vxixax0qd7y/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/mauricer/branch/master)|[![codecov.io](https://codecov.io/github/richelbilderbeek/mauricer/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/mauricer/branch/master)
[phangorn](https://github.com/KlausVigo/phangorn)|[![Build Status](https://travis-ci.org/KlausVigo/phangorn.svg?branch=master)](https://travis-ci.org/KlausVigo/phangorn)|.|[![codecov.io](https://codecov.io/github/KlausVigo/phangorn/coverage.svg?branch=master)](https://codecov.io/github/KlausVigo/phangorn/branch/master)
[tracerer](https://github.com/richelbilderbeek/tracerer)|[![Build Status](https://travis-ci.org/richelbilderbeek/tracerer.svg?branch=master)](https://travis-ci.org/richelbilderbeek/tracerer)|[![Build status](https://ci.appveyor.com/api/projects/status/6ulxqop64tgbujch/branch/master?svg=true)](https://ci.appveyor.com/project/richelbilderbeek/tracerer/branch/master)|[![codecov.io](https://codecov.io/github/richelbilderbeek/tracerer/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/tracerer/branch/master)

## Related packages

Package|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---
[lumier](https://github.com/richelbilderbeek/lumier)|[![Build Status](https://travis-ci.org/richelbilderbeek/lumier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/lumier)|[![codecov.io](https://codecov.io/github/richelbilderbeek/lumier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/lumier/branch/master)

## External links

 * [BEAST2 GitHub](https://github.com/CompEvol/beast2)

## References

Article about `babette`:

 * Bilderbeek, Richel JC, and Rampal S. Etienne. "babette: BEAUti 2, BEAST 2 and Tracer for R." Methods in Ecology and Evolution (2018). https://doi.org/10.1111/2041-210X.13032

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.
