# Contributing

Awesome that you are reading this.

This GitHub follows the [Contributor Covenant Code of Conduct](doc/code_of_conduct.md).

 * For questions, you can create an Issue
 * Code changes go via Pull Requests

## Which package to contribute to?

`babette` is part of the `babette` package suite,
which consists out of five packages.
Here is how to determine which package is best suited for your contribution:

If you want to contribute to the creation of BEAST2 XML input file,
go to [beautier](https://github.com/ropensci/beautier/blob/master/CONTRIBUTING.md).

If you want to contribute to how BEAST2 is run,
go to [beautier](https://github.com/ropensci/beautier/blob/master/CONTRIBUTING.md).

If you want to contribute to how BEAST2 output is parsed,
go to [tracerer](https://github.com/ropensci/tracerer/blob/master/CONTRIBUTING.md)

If you want to contribute regarding the BEAST2 package management,
go to [mauricer](https://github.com/ropensci/mauricer/blob/master/CONTRIBUTING.md)

If you want to contribute with an overarching idea, you are at the right spot :-) 

## Submitting code

Submitted code should follow these quality guidelines:

 * All tests pass cleanly/silently
 * Code coverage must be 100%
 * Coding style should follow the default style by `lintr`

These are all checked by Travis CI when submitting
a Pull Request. 

Emails with code will not be accepted.

## Submitting bugs

Awesome that your are reading this!

First, know that `babette` is thouroughly tested. 
Most reported bugs are due to users' local settings,
caused by `babette`'s creation of temporary files.
This may cause a problem if:

 * (Linux) the home folder is encrypted
 * (Linux) [CentOS is used](https://github.com/ropensci/babette/issues/31).
 * (MacOS) if `babette` is run in a folder monitored by DropBox

If this is not the case, these are your options:

 * Add an Issue, with the test that fails
 * Submit a Pull Request, where the test is added to the `tests/testthat` folder
 * Send @richelbilderbeek an email (@richelbilderbeek will make an Issue of it)

Pull Requests should follow the same guidelines as 'Submitting code'.

## Branching policy

 * The `master` branch should always build successfully
 * The `development` branch is for developers

## git usage

To get started working on `babette` do:

```
git clone https://github.com/ropensci/babette
```

Development is done on the `develop` branch. 
To download and checkout the `develop` branch, 
first go into the `beautier` folder (`cd babette`), then do:

```
git checkout develop
```

Then the workflow is the common `git` workflow:

```
git pull
git add --all :/
git commit -m "Did something awesome"
git push
```
