#  Data Quality Control & Aggregation from ActivityInfo

## Objectives

 1. Control the quality of the data to avoid erroneous values, blanks…

 2. Although Activity Info permit to put restrictions and validation rules, some of those can be overwritten, especially when doing bulk import of data, which is the most convenient form of importing data in Activity Info

 3. Be able to flag the errors and apply automatic corrections or manual revisions, as desired by the data owner

This package is the back office for a shny app visible here: [ActivityInfo_R4V/](https://rstudio.unhcr.org/ActivityInfo_R4V/) and enable a scripted process so that:

 * Check are consistent with Activity Info  
 
 * Different scenario of aggregation models can be evaluated 
 
 * Time and energy are saved 
 
 * Reproducibility is enforced
 

The consolidated report generation will only be working if the data is clean: errors in breakdowns in the activities will be in the consolidated report

## Background 

### Challenges with manual cleaning 

Filters and changes are applied manually, with no register of actions taken (which filter applied, which data name changed, deleted fields….) 

Hard to go back at the beginning of your analysis and change features or settings without having to do again the whole process

Risk of data loss, work with non-updated files,  back and forth with the versions


### Advantage of scripted approach 

Each step taken is registered and can be modified at any time if needed

Reproducibility of the analysis, test various scenarios…

The script can be consulted and amended by several persons, with a tracking of the different versions in case we need to go back

Variety of outputs possible

Tailored analysis and products for each country, partners, sector….


### Quality Check 

A series of errors are checked by the Data Quality check report. They can be divided in 3 categories:

 * __Completeness__: For instance, Missing values in mandatory fields i.e.: No Implementing partners

 * __Consistency__: Country and Admin1 not matching, Activities with transferred values registered but CVA = “No”

 * __Accuracy__: Incorrect or empty breakdown information


### Data Aggregation 

Aggregation models differ from a country to another and thus it is important to register the model you are applying for us to understand how they are processed. 


## For DEV

The project was built from the  [{activityinfo}](https://www.activityinfo.org/support/docs/R/) R package and [{graveler}](https://edouard-legoupil.github.io/graveler/) project template.

It includes a shiny app (`run_app()`) together with a few functions

 * `fct_read_lookup` allows to pull admin1, admin2, partner and country  from ActivityInfo api
 * `fct_read_data` pull the 5W info from ActivityInfo api potentially with filters
 * `fct_error_report` performs the QA on the data
 * `fct_aggregate_data` perform the data aggregation according to different scenario

## Next Steps

 * Update the Aggregation model for every country

 * Help the development of local scripts for analysis, outliers detections,…

 * Send further development to the Script and App to help you more through GitHub

 




