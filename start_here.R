#Purpose: The purpose of this file is to load the project template library and load the project.
#     This will load Project template. It will run all scripts in the data and munge folders.

if(!require(ProjectTemplate)){
  install.packages("somepackage")
  library(ProjectTemplate)
}
  
load.project()


#Run all of the analysis
(filenames <- list.files("src", pattern="*.R", full.names=TRUE))

for( file in 2:length(filenames)){
  source(filenames[file()])
}

