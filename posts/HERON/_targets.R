library(targets)
library(dplyr)
library(ggplot2)
library(heron)
library(tarchetypes)




# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(summary) to view the results.
# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
tar_source("posts/HERON/R/fonctions.R")
# if you keep your functions in external scripts.


# Set target-specific options such as packages.

triangle <- matrix(c(0, 0, 1, 0, 0.5, sqrt(3)/2), nrow = 3, ncol = 2)


list(
  tar_target("Iteration1", divide_triangle(triangle)),
  tar_target("plot1", plot_triangles(Iteration1)),
  tar_target("aire1", aire_triangles(Iteration1)),
  tar_target("Iteration2", divide_list_triangle(Iteration1)),
  tar_target("plot2", plot_triangles(Iteration2)),
  tar_target("aire2", aire_triangles(Iteration2)),
  tar_target("Iteration3", divide_list_triangle(Iteration2)),
  tar_target("plot3", plot_triangles(Iteration3)),
  tar_target("aire3", aire_triangles(Iteration3)),
  tar_target("Iteration4", divide_list_triangle(Iteration3)),
  tar_target("plot4", plot_triangles(Iteration4)),
  tar_target("aire4", aire_triangles(Iteration4)),
  tar_target("render", tar_quarto(index.qmd, "posts/HERON/index.qmd")))
