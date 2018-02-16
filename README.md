# rbeast2

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)|[![Codecov logo](pics/Codecov.png)](https://www.codecov.io)
---|---|---
master|[![Build Status](https://travis-ci.org/richelbilderbeek/rbeast2.svg?branch=master)](https://travis-ci.org/richelbilderbeek/rbeast2)|[![codecov.io](https://codecov.io/github/richelbilderbeek/rbeast2/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/rbeast2/branch/master)
develop|[![Build Status](https://travis-ci.org/richelbilderbeek/rbeast2.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/rbeast2)|[![codecov.io](https://codecov.io/github/richelbilderbeek/rbeast2/coverage.svg?branch=develop)](https://codecov.io/github/richelbilderbeek/rbeast2/branch/develop)

`rbeast2` is an R package that combines:

 * [beautier](https://github.com/richelbilderbeek/beautier) creates BEAST2 input (`.xml`) files.
 * [beastier](https://github.com/richelbilderbeek/beastier) runs BEAST2
 * [tracerer](https://github.com/richelbilderbeek/tracerer) parses BEAST2 output (`.log`, `.trees`, etc) files.

![rbeast2 logo](pics/rbeast2_logo.png)

## Examples

See [examples](examples.md).

## Installation

If you use the `devtools` R package, this is easy:

```
devtools::install_github("richelbilderbeek/rbeast2")
```

## FAQ

See [FAQ](faq.md)

## Missing features/unsupported

`rbeast2` cannot do everything `BEAUti` and `BEAST2` and `Tracer` can.

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

Article about `beautier`:

 * Bilderbeek, Richel J.C., Etienne, Rampal S., "beautier: BEAUti from R" *In preparation*.

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.
