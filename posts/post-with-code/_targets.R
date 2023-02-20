library(targets)
library(dplyr)
library(ggplot2)
library(heron)


# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(summary) to view the results.
# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
tar_source()
# if you keep your functions in external scripts.


# Set target-specific options such as packages.

triangle <- rbind(c(0,0), c(1,0), c(0.5, sqrt(3)/2))
triangle <- divide_triangle(triangle)

list(
  tar_target("Iteration_1", divide_list_triangle(triangle)),
  tar_target("plot1", plot_triangles(Iteration_1)),
  tar_target("heron1", heron2(Iteration_1)),
  tar_target("Iteration_2", divide_list_triangle(Iteration_1)),
  tar_target("plot2", plot_triangles(Iteration_2)),
  tar_target("heron2", heron2(Iteration_2)),
  tar_target("Iteration_3", divide_list_triangle(Iteration_2)),
  tar_target("plot3", plot_triangles(Iteration_3)),
  tar_target("heron3", heron2(Iteration_3)),
  tar_target("Iteration_4", divide_list_triangle(Iteration_3)),
  tar_target("plot4", plot_triangles(Iteration_4)),
  tar_target("heron4", heron2(Iteration_4))
)
