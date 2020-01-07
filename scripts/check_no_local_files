#!/bin/bash

# For testing
# files=$(ls)

files=$(egrep -R "\"~" --include={*.R,*.Rmd} | egrep -v "doc/xtableGallery.R")

if [[ ! -z $files ]]; then 
  echo "Local file created:" 
  echo "$files"
  exit 1
fi

