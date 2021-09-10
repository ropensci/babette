#!/bin/bash
#
# Check if the package builds cleanly under CRAN guidelines
#
# Usage:
#
#   ./build_cran
#
rm -rf build
mkdir build

cp -r ../R build
cp -r ../inst build
cp -r ../man build
cp -r ../vignettes build
cp ../DESCRIPTION build
cp ../NAMESPACE build

cd build
R CMD build .
R CMD check --as-cran $(ls *.tar.gz)
