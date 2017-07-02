# Wine

Welcome to the Wine analysis. This will be used to assess the Red Wine data set from UCI to comply with the requirements of ST563 at NC State.

I have built this project structure using ProjectTemplate which is a handy way of organizing projects and preloading data.

## A reminder of the project requirements
You will first divide the data randomly into two sets, a training set that you will use to fit your
models and a test set that will be used to evaluate the methods. Your group should use both regression and classification methods on the data. For the classification methods, you should collapse the ratings into a smaller number of levels, such as low/medium/high, or low/high. If relevant, you can also examine potential unsupervised methods. Your group report should be between 7-10 pages long: describing the data, your methods of analysis, any relevant comparisons between the methods, your findings, and any issues that came up. You should include any plots, graphs, or tables that support your statements, but these should be referenced in the text, and placed at the relevant locations. You may include a separate appendix with relevant R-code that you may deem necessary.

## Project Template Details

To load your new project, you'll first need to `setwd()` into the directory
where this README file is located. Then you need to run the following two
lines of R code:

	library('ProjectTemplate')
	load.project()

After you enter the second line of code, you'll see a series of automated
messages as ProjectTemplate goes about doing its work. This work involves:
* Reading in the global configuration file contained in `config`.
* Loading any R packages you listed in he configuration file.
* Reading in any datasets stored in `data` or `cache`.
* Preprocessing your data using the files in the `munge` directory.

Once that's done, you can execute any code you'd like. For every analysis
you create, we'd recommend putting a separate file in the `src` directory.
If the files start with the two lines mentioned above:

	library('ProjectTemplate')
	load.project()

You'll have access to all of your data, already fully preprocessed, and
all of the libraries you want to use.

For more details about ProjectTemplate, see http://projecttemplate.net
