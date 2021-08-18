#!/bin/bash
#
# Build the Singularity container called `babette.sif`
# from the Singularity recipe `Singularity` (which is a default
# name for a Singularity recipe)
#
# Usage:
#
# ./scripts/build_singularity_container.sh
#
#
sudo -E singularity build babette.sif Singularity
