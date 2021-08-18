# The babette R package, with BEAST2 and the BEAST2 NS package installed

Bootstrap: docker
From: r-base

%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    apt-get -y install libssl-dev libcurl4-openssl-dev libxml2-dev r-cran-stringi libicu-dev r-cran-rjava
    apt-get clean
    Rscript -e 'install.packages(c("remotes", "devtools"))'
    Rscript -e 'remotes::install_github("ropensci/beastier")'
    Rscript -e 'remotes::install_github("richelbilderbeek/beastierinstall")'
    Rscript -e 'beastierinstall::install_beast2(folder_name = "/opt/beastier")'
    Rscript -e 'remotes::install_github("richelbilderbeek/mauricer")'
    Rscript -e 'remotes::install_github("richelbilderbeek/mauricerinstall")'
    Rscript -e 'mauricerinstall::install_beast2_pkg(name = "NS", beast2_folder = "/opt/beastier")'

%runscript
exec R --vanilla --silent --no-echo "$@"

%test
    Rscript -e 'beastier::beastier_report(beast2_folder = "/opt/beastier")'
    Rscript -e 'babette::beastier_report(beast2_folder = "/opt/beastier")'

%help

This container has the R package babette, the tool BEAST2 
and the BEAST2 package 'NS' installed.

When using this container, set `beast2_folder` to `/opt/beastier`.
To obtain the  `beast2_path` use `beastier::get_default_beast2_path`.

For example:

```
library(beastier)

# Folder that contains BEAST2
beast2_folder <- "/opt/beastier"

# Path to the BEAST2 binary/jar file
beast2_path <- get_default_beast2_path(
  beast2_folder = beast2_folder
)

# Setup a default BEAST2 run
beast2_options <- create_beast2_options(
  beast2_path = beast2_path
)

# Setup a default inference model
inference_model <- create_test_inference_model()

bbt_run_from_model(
  fasta_filename = get_babette_path("anthus_aco.fas"),
  inference_model = inference_model,
  beast2_options = beast2_options
)

# Clean up temporary files created by babette
bbt_delete_temp_files(
  inference_model = inference_model,
  beast2_options = beast2_options
)
```

%labels

    AUTHOR Richel J.C. Bilderbeek

    NAME babette
 
    DESCRIPTION The babette R package, with BEAST2 and the BEAST2 NS package installed

    USAGE send the text of an R script to the container

    URL https://github.com/ropensci/babette

    VERSION 2.3
