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
remotes::install_github("ropensci/beautier")
remotes::install_github("ropensci/tracerer")
remotes::install_github("ropensci/beastier")
remotes::install_github("ropensci/mauricer")
remotes::install_github("ropensci/babette")

```

## Install BEAST2

`babette` assumes that BEAST2 is installed. 

If not, one can install BEAST2 from R using `beastierinstall`:

To install BEAST2:

```
remotes::install_github("richelbilderbeek/beastierinstall")
beastierinstall::install_beast2()
```

To install a BEAST2 package, for example, the `NS` package:

```
remotes::install_github("richelbilderbeek/mauricerinstall")
mauricerinstall::install_beast2_pkg("NS")
```

