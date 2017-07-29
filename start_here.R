#Purpose: The purpose of this file is to load the project template library and load the project.
#     This will load Project template. It will run all scripts in the data and munge folders.

if(!require(ProjectTemplate)){
  install.packages("ProjectTemplate")
  library(ProjectTemplate)
}
  
load.project()


#Run all of the analysis
(filenames <- list.files("src", pattern="*.R", full.names=TRUE))

for( a in 1:length(filenames)){
  on.exit(filenames[a])
  source(paste0(filenames[a]))
}
