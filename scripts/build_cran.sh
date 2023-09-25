#!/bin/bash

rm -rf build
mkdir build

cp -r ../inst build
cp -r ../man build
# cp -r ../Meta build
cp -r ../R build
# cp -r ../src build
cp -r ../vignettes build
cp ../DESCRIPTION build
cp ../NAMESPACE build

cd build || exit 42
R CMD build .
gz_files=$(ls ./*.tar.gz)
R CMD check --as-cran "${gz_files}"
