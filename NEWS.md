# News

Newest versions at top.

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

