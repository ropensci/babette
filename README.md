# babette

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---
master|[![Build Status](https://travis-ci.org/richelbilderbeek/babette.svg?branch=master)](https://travis-ci.org/richelbilderbeek/babette)|[![codecov.io](https://codecov.io/github/richelbilderbeek/babette/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/babette/branch/master)
develop|[![Build Status](https://travis-ci.org/richelbilderbeek/babette.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/babette)|[![codecov.io](https://codecov.io/github/richelbilderbeek/babette/coverage.svg?branch=develop)](https://codecov.io/github/richelbilderbeek/babette/branch/develop)

`babette` is an R package that combines:

 * [beautier](https://github.com/richelbilderbeek/beautier) creates BEAST2 input (`.xml`) files.
 * [beastier](https://github.com/richelbilderbeek/beastier) runs BEAST2
 * [tracerer](https://github.com/richelbilderbeek/tracerer) parses BEAST2 output (`.log`, `.trees`, etc) files.

![babette logo](pics/babette_logo.png)

## Examples

See:

 * [examples](doc/examples.md)
 * [bioRxiv article](https://doi.org/10.1101/271866)
 * ['babette' YouTube channel](https://www.youtube.com/watch?v=nA-0-Fc95xY&list=PLu8_ZyzXyRDFIRx-kdDI5Q6xVr-HnY7TB)

## Installation

If you use the `devtools` R package, this is easy:

```
devtools::install_github("richelbilderbeek/babette")
```

To install BEAST2, see [how to install BEAST2](https://github.com/richelbilderbeek/beastier/blob/master/install_beast2.md).

## FAQ

See [FAQ](doc/faq.md).

## Missing features/unsupported

`babette` cannot do everything `BEAUti` and `BEAST2` and `Tracer` can.

See [beautier](https://github.com/richelbilderbeek/beautier) 
for missing features in creating a BEAST2 input (`.xml`) file.

See [beastier](https://github.com/richelbilderbeek/beastier) for missing
features in running BEAST2

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

Package|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---
[beautier](https://github.com/richelbilderbeek/beautier)|[![Build Status](https://travis-ci.org/richelbilderbeek/beautier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/beautier)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beautier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beautier/branch/master)
[beastier](https://github.com/richelbilderbeek/beastier)|[![Build Status](https://travis-ci.org/richelbilderbeek/beastier.svg?branch=master)](https://travis-ci.org/richelbilderbeek/beastier)|[![codecov.io](https://codecov.io/github/richelbilderbeek/beastier/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/beastier/branch/master)
[phangorn](https://github.com/KlausVigo/phangorn)|[![Build Status](https://travis-ci.org/KlausVigo/phangorn.svg?branch=master)](https://travis-ci.org/KlausVigo/phangorn)|[![codecov.io](https://codecov.io/github/KlausVigo/phangorn/coverage.svg?branch=master)](https://codecov.io/github/KlausVigo/phangorn/branch/master)
[tracerer](https://github.com/richelbilderbeek/tracerer)|[![Build Status](https://travis-ci.org/richelbilderbeek/tracerer.svg?branch=master)](https://travis-ci.org/richelbilderbeek/tracerer)|[![codecov.io](https://codecov.io/github/richelbilderbeek/tracerer/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/tracerer/branch/master)

## External links

 * [BEAST2 GitHub](https://github.com/CompEvol/beast2)

## References

Article about `babette`:

 * Bilderbeek, Richel J.C., Etienne, Rampal S., "babette: BEAUti 2, BEAST2 and Tracer for R". bioRxiv 271866; doi: https://doi.org/10.1101/271866

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.
