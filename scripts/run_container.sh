#!/bin/bash
#
# Run the Singularity container on a demo R script
#
# Usage
#
# ./scripts/run_container.sh
#
# --cleanenv: recommened by tsnowlan at https://stackoverflow.com/a/71252619
# --bind $PWD/scripts/ : bind the folder, so that it works on GitHub Actions as well

echo "Demo the container"

# SC2086: Double quote to prevent globbing and word splitting
singularity run --cleanenv --bind "$PWD"/scripts/ babette.sif Rscript scripts/demo_container.R
