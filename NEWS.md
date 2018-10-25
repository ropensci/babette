# News

Newest versions at top.

## babette 1.2.5 (2018-10-25)

### NEW FEATURES

  * None

### MINOR IMPROVEMENTS

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

  * Tagged for [the academic article about babette](https://github.com/richelbilderbeek/babette_article)

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

