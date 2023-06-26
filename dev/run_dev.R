# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
rm(list = ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()


## For deployment use the app.R file at the root of your project and then use 
# the deployment button in blue to publish your project http://rstudio.unhcr.org 