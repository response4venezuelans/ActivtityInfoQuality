# WARNING - Generated by {fusen} from dev/function_documentation.Rmd: do not edit by hand

#' fct_read_data
#' 
#' Pull Data From ActivityInfo
#' 
#' Note that this function is specific to a specific DB schema -
#' the form to query as well as the columns variabl name are hard coded and 
#' would need to be adjusted if the DB change
#' 
#' Note also that the function is based on a token stored as an environment 
#' variable
#' 
#'  # Credentials set up as environment variables - 
#'  
#'  # token <- "activityinfotoken.."
#'  # print(Sys.setenv(ACTIVITYINFOTOKEN = token))   
#'  # Sys.getenv("ACTIVITYINFOTOKEN")
#'  # rm(token)
#'  
#' @param filter what to filter on (country or partner) so that we do not need to load everything
#' @param value value to filter from
#' 
#' @return  df5W  response tracking potentially filtered
#' 
#' 
#' @importFrom activityinfo activityInfoToken queryTable
#' @importFrom dplyr  arrange mutate_at rowwise ungroup
#' 
#' @export
#' @examples
#'
#' ## Pulling everything... can be long..
#' df5W <- fct_read_data()
#' head( df5W, 10)
#'
#' ## testing the filters
#' df5Wctr <- fct_read_data(filter = "country",
#'                          value = "Colombia")
#' head( df5Wctr, 10)
#'
#' df5Wpart <- fct_read_data(filter = "partner",
#'                          value = "United Nations High Commissioner for Refugees (UNHCR)")
#' head( df5Wpart , 10)
#'
#' df5Wpart2 <- fct_read_data(filter = "partner",
#'                          value = "CCEFIRO Association")
#'
fct_read_data <- function(filter = NULL ,
                          value = NULL){

  activityinfo::activityInfoToken(Sys.getenv("ACTIVITYINFOTOKEN"),
                                prompt = FALSE)

    # Get data from different sources
    if( all(!(is.null(filter)) & filter == "country") ) {
    df5W <-  activityinfo::queryTable(
      form ="cwp64n0lo79a2de8",
                        "Country" = "cezj1rqkxeqrsy57.c8u26b8kxeqpy0k4",
                        "Admin1" = "cezj1rqkxeqrsy57.c3ns3zikxeqq4h95",
                        "Admin2" = "c89klrbkx6hp4j58.cs2esadkx6hkt7j6",
                        "Appealing_org" = "c5648gjkx69ra2v9.ckj5zamkumvyysv9",
                        "Implementation" = "ckjtet4kx69smeog",
                        "Implementing_partner" = "cdocy6flctaah8c4.ckj5zamkumvyysv9",
                        "Month" = "clqgqrqkyueahma8",
                        "Subsector" = "cco8s7klctg5i192q.cagw22hlctcp2vu5",
                        "Indicator" = "cco8s7klctg5i192q.c1oo0eclctcqtjp8",
                        "Activity_Name" = "c3p669wkx6a7oyo4",
                        "Activity_Description" = "c8hxf50kx6a7vp65",
                        "RMRPActivity" = "cuf3og8kx6amylmf",
                        "CVA" = "cbvqg4jkx6b1kii7",
                        "Value" = "clwkfmckx6b2msu9",
                        "Delivery_mechanism" = "cg3rikqkx6b3z1kf",
                        "Quantity_output" = "cm6no26kx6b8fqoh",
                        "Total_monthly" = "cto1biukx6kwvnj4k",
                        "New_beneficiaries" = "c43j49ikx6kxyyc4l",
                        "IN_DESTINATION" = "cz3yof2kx6l024p4m",
                        "IN_TRANSIT" = "c8kl5o2kx6l0jip4n",
                        "Host_Communities" = "c5z8bvakx6l10d84o",
                        "PENDULARS" = "c72dmskkx6l1hl04p",
                        "Returnees" = "cmoqhuckx6l4q9z4q",
                        "Girls" = "cwrxeaekx6l63na4s",
                        "Boys" = "ccx7xhekx6l6jnk4t",
                        "Women" = "c3l36n2kx6l70kp4u",
                        "Men" = "ctd27ackx6l7g814v",
                        "Other_under" = "ckjcuiokx6l9a504w",
                        "Other_above" = "cq4hs3skx6lggpj4x",
                        "Platform" = "cuhb8obl0wjzz9r3",
       filter = sprintf('cezj1rqkxeqrsy57.c8u26b8kxeqpy0k4 == "%s" ', value),
       truncateStrings = FALSE)
      } else  if(  all(!(is.null(filter)) &  filter == "partner") ) {
       df5W <-  activityinfo::queryTable(
              form ="cwp64n0lo79a2de8",
                        "Country" = "cezj1rqkxeqrsy57.c8u26b8kxeqpy0k4",
                        "Admin1" = "cezj1rqkxeqrsy57.c3ns3zikxeqq4h95",
                        "Admin2" = "c89klrbkx6hp4j58.cs2esadkx6hkt7j6",
                        "Appealing_org" = "c5648gjkx69ra2v9.ckj5zamkumvyysv9",
                        "Implementation" = "ckjtet4kx69smeog",
                        "Implementing_partner" = "cdocy6flctaah8c4.ckj5zamkumvyysv9",
                        "Month" = "clqgqrqkyueahma8",
                        "Subsector" = "cco8s7klctg5i192q.cagw22hlctcp2vu5",
                        "Indicator" = "cco8s7klctg5i192q.c1oo0eclctcqtjp8",
                        "Activity_Name" = "c3p669wkx6a7oyo4",
                        "Activity_Description" = "c8hxf50kx6a7vp65",
                        "RMRPActivity" = "cuf3og8kx6amylmf",
                        "CVA" = "cbvqg4jkx6b1kii7",
                        "Value" = "clwkfmckx6b2msu9",
                        "Delivery_mechanism" = "cg3rikqkx6b3z1kf",
                        "Quantity_output" = "cm6no26kx6b8fqoh",
                        "Total_monthly" = "cto1biukx6kwvnj4k",
                        "New_beneficiaries" = "c43j49ikx6kxyyc4l",
                        "IN_DESTINATION" = "cz3yof2kx6l024p4m",
                        "IN_TRANSIT" = "c8kl5o2kx6l0jip4n",
                        "Host_Communities" = "c5z8bvakx6l10d84o",
                        "PENDULARS" = "c72dmskkx6l1hl04p",
                        "Returnees" = "cmoqhuckx6l4q9z4q",
                        "Girls" = "cwrxeaekx6l63na4s",
                        "Boys" = "ccx7xhekx6l6jnk4t",
                        "Women" = "c3l36n2kx6l70kp4u",
                        "Men" = "ctd27ackx6l7g814v",
                        "Other_under" = "ckjcuiokx6l9a504w",
                        "Other_above" = "cq4hs3skx6lggpj4x",
                        "Platform" = "cuhb8obl0wjzz9r3",
       filter = sprintf('c5648gjkx69ra2v9.ckj5zamkumvyysv9 == "%s" ', value),
       truncateStrings = FALSE)
      } else  {
      df5W <-  activityinfo::queryTable(
         form ="cwp64n0lo79a2de8",
                        "Country" = "cezj1rqkxeqrsy57.c8u26b8kxeqpy0k4",
                        "Admin1" = "cezj1rqkxeqrsy57.c3ns3zikxeqq4h95",
                        "Admin2" = "c89klrbkx6hp4j58.cs2esadkx6hkt7j6",
                        "Appealing_org" = "c5648gjkx69ra2v9.ckj5zamkumvyysv9",
                        "Implementation" = "ckjtet4kx69smeog",
                        "Implementing_partner" = "cdocy6flctaah8c4.ckj5zamkumvyysv9",
                        "Month" = "clqgqrqkyueahma8",
                        "Subsector" = "cco8s7klctg5i192q.cagw22hlctcp2vu5",
                        "Indicator" = "cco8s7klctg5i192q.c1oo0eclctcqtjp8",
                        "Activity_Name" = "c3p669wkx6a7oyo4",
                        "Activity_Description" = "c8hxf50kx6a7vp65",
                        "RMRPActivity" = "cuf3og8kx6amylmf",
                        "CVA" = "cbvqg4jkx6b1kii7",
                        "Value" = "clwkfmckx6b2msu9",
                        "Delivery_mechanism" = "cg3rikqkx6b3z1kf",
                        "Quantity_output" = "cm6no26kx6b8fqoh",
                        "Total_monthly" = "cto1biukx6kwvnj4k",
                        "New_beneficiaries" = "c43j49ikx6kxyyc4l",
                        "IN_DESTINATION" = "cz3yof2kx6l024p4m",
                        "IN_TRANSIT" = "c8kl5o2kx6l0jip4n",
                        "Host_Communities" = "c5z8bvakx6l10d84o",
                        "PENDULARS" = "c72dmskkx6l1hl04p",
                        "Returnees" = "cmoqhuckx6l4q9z4q",
                        "Girls" = "cwrxeaekx6l63na4s",
                        "Boys" = "ccx7xhekx6l6jnk4t",
                        "Women" = "c3l36n2kx6l70kp4u",
                        "Men" = "ctd27ackx6l7g814v",
                        "Other_under" = "ckjcuiokx6l9a504w",
                        "Other_above" = "cq4hs3skx6lggpj4x",
                        "Platform" = "cuhb8obl0wjzz9r3",
      truncateStrings = FALSE)
      }
  
  # Short data wrangling for integer values
  df5W <- df5W |>
    dplyr::mutate_at(c("Value",
                "Quantity_output",
                "Total_monthly",
                "New_beneficiaries",
                "IN_DESTINATION",
                "IN_TRANSIT",
                "Host_Communities",
                "PENDULARS",
                "Returnees",
                "Girls",
                "Boys",
                "Women",
                "Men",
                "Other_under",
                "Other_above"), as.numeric) |>
    dplyr::arrange(Country, Month)

   return(df5W)
}
