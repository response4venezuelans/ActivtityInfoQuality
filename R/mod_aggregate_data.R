# Module UI
 
#' @title mod_aggregate_data_ui and mod_aggregate_data_server
#' @description A shiny module.module.
#' @import shiny
#' @import shinydashboard
#' @importFrom DT dataTableOutput
#' @noRd 
#' @keywords internal
 
mod_aggregate_data_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "aggregate_data",
		
		fluidRow(
		  column(
		    width = 12,
		    shinydashboard::box(
		      id = "box_5",
		      title = "Data Aggregation ",
		      solidHeader = FALSE,
		      collapsible = T,
		      collapsed = F,
		      width = 12,
		      status = "primary",
		      fluidRow(
		        column(
		          width = 4,
		          radioButtons(
    		        inline = TRUE,
    		        inputId = ns("totalmodel_agg"),
    		        label = "Define Aggregation Model",
    		        choices = c("sum", "maxsector", "southernconemodel"))
		        ),
		        column(
		          width = 4,
		          selectInput(
		            inputId = ns("country_name_agg"),
		            label = "Filter Country ",
		            choices = c("NULL"))
		        ),
		        column(
		          width = 4,
		          actionButton(
		            inputId = ns("run_aggregation"),
		            label = " Apply Assumption ",
		            icon = icon("gears")  ),
		            br(),
		            downloadButton(outputId = ns("downloadData"),
		                     label = "Download consolidated report")
		          )
		      ) # end row
		    ) # end box
		  ) # end colum
		), # End row
		fluidRow(
		  column(
		    12,
		    shinydashboard::box(
		      id = "box_6",
		      title = "Preview consolidated report",
		      solidHeader = FALSE,
		      collapsible = T,
		      collapsed = F,
		      width = 12,
		      status = "primary",
		      DT::dataTableOutput(outputId = ns("Preview_consolidated"))
		    )
		  )
		) # end row
		
	)
}
 
#' Module Server
#' @import shiny
#' @importFrom DT renderDataTable
#' @importFrom writexl write_xlsx
#' @noRd 
#' @keywords internal
 
mod_aggregate_data_server <- function(input, output, session, AppReactiveValue) {
	ns <- session$ns
	
	## Run on button!
	observeEvent(input$run_aggregation,{
	  AppReactiveValue$result <- fct_error_report( 
	                                  result = AppReactiveValue$result,
	                                  countryname = input$countryname_agg,
	                                  totalmodel = input$totalmodel_agg)
	   #showNotification("Successful",duration = 10, type = "error")
	  })
	  
	 ## Preview consolidated
	 output$Preview_consolidated <- DT::renderDataTable( 
	  expr = as.data.frame( AppReactiveValue$result[["ConsolidatedReport"]]),
	  #extensions = c("Buttons"),
	  options = list(
	    dom = 'lfrtip',
	    paging = TRUE,
	    ordering = TRUE,
	    lengthChange = TRUE,
	    pageLength = 10,
	    scrollX = TRUE,
	    autowidth = TRUE,
	    rownames = TRUE
	  ))
	  
	  ## Download Consolidated
	  output$downloadData <- downloadHandler(
	    filename = function() {
	      paste("Consolidated_Report", ".xlsx", sep = "")
	    },
	    content = function(file) {
	      writexl::write_xlsx(AppReactiveValue$result[["ConsolidatedReport"]], file)
	    }
	  )
	  
}
 
## copy to body.R
# mod_aggregate_data_ui("aggregate_data_ui_1")
 
## copy to app_server.R
# callModule(mod_aggregate_data_server, "aggregate_data_ui_1")
 
## copy to sidebar.R
# menuItem("displayName",tabName = "aggregate_data",icon = icon("user"))
 
