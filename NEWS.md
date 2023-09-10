# News

Newest versions at top.

## babette v2.3.2 (2022-08-12)

### NEW FEATURES

  * None
  
### MINOR IMPROVEMENTS

 * Did `usethis::use_package_doc()`

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.3.1 (2022-06-21)

### NEW FEATURES

  * None
  
### MINOR IMPROVEMENTS

  * Fix newer CRAN warnings

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.3 (2021-05-14)

### NEW FEATURES

  * Use GitHub Actions as a continuous integration service
  
### MINOR IMPROVEMENTS

  * Add URL to DESCRIPTION

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.2 (2020-11-06)

### NEW FEATURES

  * None
  
### MINOR IMPROVEMENTS

  * Do not run example code of internal function 'prepare_file_creation'
    on CRAN flavor `r-oldrel-macos-x86_64`

### BUG FIXES

  * Can run BEAST2 and BEAST2 packages when these are installed at
    a custom location

### DEPRECATED AND DEFUNCT

  * None

## babette 2.1.4 (2020-08-11)

### NEW FEATURES

  * CRAN version
  
### MINOR IMPROVEMENTS

  * None

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.1.3 (2020-08-05)

### NEW FEATURES

  * None
  
### MINOR IMPROVEMENTS

  * No testthat usage in documentation examples

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.1.2 (2020-02-01)

### NEW FEATURES

  * None
  
### MINOR IMPROVEMENTS

  * Use https of BEAST2 website
  * Building the package does not create temporary files in `~/.cache`, fix #85

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.1.1 (2019-12-30)

### NEW FEATURES

  * None
  
### MINOR IMPROVEMENTS

  * Process feedback CRAN (Issue 81)
  * Renamed internal function names to be more descriptive

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * Remove arguments that are deprecated, as there is no CRAN
    version yet

## babette 2.1 (2019-10-27)

### NEW FEATURES

  * Follow the `beastier` v2.3 new interface, in which the log filenames
    are part of the MCMC (as created by `create_mcmc`)
  
### MINOR IMPROVEMENTS

  * None

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * In `create_beast2_options`, 
    `output_log_filename` and `output_trees_filenames` are removed
    as arguments. These values are set by the BEAST2 XML

## babette 2.0.3 (2019-08-26)

### NEW FEATURES

  * babette can run when the BEAST2 options request temporary files
    in sub-sub-subfolders

### MINOR IMPROVEMENTS

  * Builds on Travis CI's Bionic distribution

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.0.2 (2019-03-26)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Fix spelling error

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.0.1 (2019-03-26)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Travis CI uses `phangorn`s binary R package  

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 2.0 (2019-01-06)

### NEW FEATURES

  * Transferred GitHub repository ownership to `ropensci`
  * CRAN and rOpenSci release candidate

### MINOR IMPROVEMENTS

  * Tagged for [the academic article about babette](https://github.com/ropensci/babette_article)

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None


## babette 1.2.5 (2018-10-25)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * BEAST2 package management using `mauricer` works under Windows as well
  * `babette` indicates that BEAST2.exe cannot be run under Windows
  * Simplified interface for parameters:

```
# Old
distr <- create_distr_poisson(id = 1, lambda = create_lambda_param(value = 1.2))
# Added
distr <- create_distr_poisson(id = 1, lambda = 1.2)
```

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * Cannot use hyper parameters

```
# Deprecated: create a hyper parameter
create_lambda_param(value = 1.2, estimate = TRUE)
```

## babette 1.2.4 (2018-05-17)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Tagged for [the academic article about babette](https://github.com/ropensci/babette_article)

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 1.2.3 (2018-05-04)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Renamed `run` to `bbt_run` to reduce conflicts with other packages

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

## babette 1.2.2 (2018-04-05)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

  * Follow all [rOpenSci packaging guidelines](https://github.com/ropensci/onboarding/blob/master/packaging_guide.md)

### BUG FIXES

  * None

### DEPRECATED AND DEFUNCT

  * None

