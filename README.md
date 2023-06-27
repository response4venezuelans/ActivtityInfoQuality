#  Data Quality Control & Aggregation from ActivityInfo

## Objectives

Control the quality of the data to avoid erroneous values, blanks…

Although Activity Info permit to put restrictions and validation rules, some of those can be overwritten, especially when doing bulk import of data, which is the most convenient form of importing data in Activity Info

Be able to flag the errors and apply automatic corrections or manual revisions, as desired by the data owner

This package enable a scripted process so that:

 * Check are consistent with Activity Info  
 
 * Different scenario of aggregation models can be evaluated 
 
 * Time and energy are saved 
 
 * Reproducibility is enforced
 
 The package was built from [{graveler}](https://edouard-legoupil.github.io/graveler/).

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


### Automatic Cleaning

16 automatic cleanings are performed, all of them being optional and can be turned off. We can group them in various categories:

 * Automatic Yes or No for missing values  
 
 * Automatic assignment of values between Quantity and beneficiary when erroneous  
 
 * Automatic apportioning for empty fields  
 
 * Automatic apportioning when discrepancies (overwrites values and need to be used with care)  
 
 * Erase of extra data 

### Limitations in the cleaning 

 * Remaining mistakes that cannot be self-cleaned: 
 
 * Missing categorical values that cannot be automatically assigned
 
 * Activities with empty values:    
 
 * Apportioning of Age and Gender breakdown for People indicators
 
 
### Review for the cleaning 

 * Review apportioning document by country and sector and possibility of more accurate breakdowns (by Admin1, by indicator,…)
 
 * Resolve the empty values issues  

### Data Aggregation 

Aggregation models differ from a country to another and thus it is important to register the model you are applying for us to understand how they are processed. 

## Next Steps

 * Update the Aggregation model for every country

 * Agree on Age and Gender breakdowns proportions for each sector, for PiN and People indicators

 * Help the development of local scripts for analysis, outliers detections,…

 * Send further development to the Script and App to help you more through GitHub

 




