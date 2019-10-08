# Install

This package describes the `babette` installation and installation problems.

## `babette` installation

`babette` is not on CRAN yet. Up until then, this is how to install `babette`.

`babette` is installed most easily using the `devtools` package:

```
remotes::install_github("ropensci/beautier")
remotes::install_github("ropensci/tracerer")
remotes::install_github("ropensci/beastier")
remotes::install_github("ropensci/mauricer")
remotes::install_github("ropensci/babette")
```

Because `babette` is not on CRAN yet, its dependencies need also be installed.

`babette` assumes that BEAST2 is installed. If not, one can install BEAST2 from R using `beastier`:

```{r}
beastier::install_beast2()
```

This will download and extract BEAST2 to:

OS|Full path
---|---
Linux|`~/.local/share/beast`
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
