#Purpose: The purpose of this file is to load the project template library and load the project.

if(!require(ProjectTemplate)){
  install.packages("somepackage")
  library(ProjectTemplate)
}
  
load.project()

