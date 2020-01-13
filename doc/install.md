# Install

This package describes the `babette` installation and installation problems.

## Install `rJava`

If you have problems installing rJava, [Duck](http://www.duckduckgo.com) 
or [view my rJava notes](rjava.md).

## `babette` installation

There are two types of `babette` installations:

 * Stable (recommended)
 * Bleeding edge

`babette` assumes that BEAST2 is installed. 
See below at `Install BEAST2` how to install BEAST2.

### Stable

`babette` is on CRAN. 

```
install.packages("babette")
```

### Bleeding endge

 * Video how to install `babette`: [download (.mkv)](http://richelbilderbeek.nl/babette_install_windows.mkv) [YouTube](https://youtu.be/SiJlssZeeaM)

`babette` is installed most easily using the `remotes` package:

```
remotes::install_github("ropensci/beautier", dependencies = TRUE)
remotes::install_github("ropensci/tracerer", dependencies = TRUE)
remotes::install_github("ropensci/beastier", dependencies = TRUE)
remotes::install_github("ropensci/mauricer", dependencies = TRUE)
remotes::install_github("ropensci/babette", dependencies = TRUE)
```

## Install BEAST2

`babette` assumes that BEAST2 is installed. 
If not, one can install BEAST2 from R using `babette`:

```{r}
library(babette); install_beast2()
```

This will download and extract BEAST2 to:

OS     |Full path
-------|----------------------------------
Linux  |`~/.local/share/beast`
Windows|`C:/Users/<username>/Local/beast`

## `babette` installation problems

Here I list some `babette` installation problems:

 * package ‘babette’ is not available (for R version x.y.z)
 * [more to come?]

### package ‘babette’ is not available (for R version x.y.z)

Because `babette` is not yet on CRAN, installing it with `install.packages`, this will fail:

```
Warning in install.packages :
package ‘babette’ is not available (for R version 3.4.2)
```

Solution: use the `babette` installation as decribed above.
