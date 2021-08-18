library(beastier)

# Folder that contains BEAST2
beast2_folder <- "/opt/beastier"

# Report
beastier_report(beast2_folder = beast2_folder)

# Path to the BEAST2 binary/jar file
beast2_path <- get_default_beast2_path(
  beast2_folder = beast2_folder
)

# Setup a default BEAST2 run, using the BEAST2 XML file 2_4.xml
beast2_options <- create_beast2_options(
  input_filename = get_beastier_path("2_4.xml"),
  beast2_path = beast2_path
)

# Run BEAST2
# run_beast2_from_options(beast2_options)
