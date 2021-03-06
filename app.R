# library imports
library(shiny)
library(httr)
library(jsonlite)




# UI frontend elements
ui <- fluidPage(
  # Header
  headerPanel('Shiny Shodan'),
  # Define layout type
  sidebarLayout(
    # sidebarLayout needs two panels, sidebar and main
    sidebarPanel(
      # Text box - contains search query
      textInput("searchQuery","Search Query",placeholder = "192.168.1.0/24"),
      # Radio buttons - selection of what function to run
      radioButtons("funcSelect","Choose an option:",
                   c("None Selected" = "none",
                     "Shodan Search" = "ssearch",
                     "Shodan Scan" = "sscan",
                     "DNS Lookup" = "dns",
                     "Reverse DNS Lookup" = "rdns",
                     "API Key" = "apikey"
                   )),
      # Checkbox - selects whether to output results somewhere. Results will be displayed on screen and then discarded if not checked
      checkboxInput("outputToFile", "Output result to file?", FALSE),
      # Disables reactively unless pressed. good for not running a scan every time something is clicked, bad for displaying tooltips
      submitButton("Submit Request")
    ),
    
    # Panel 2 of sidebarLayout - displays output of option selected and query ran.
    mainPanel(
        # Output description of whichever option is selected
        textOutput("selection"),
        tags$hr(),
        # Display result of query
        uiOutput("results")
        #uiOutput("fileOutput")
              )
      )
 )

# Server-side processing
server <- function(input, output) {

  # Variable setup
  apiKey <- paste0(readLines("api.key"),collapse = "\n")
  urlBase <- "https://api.shodan.io/shodan/host/"
  keySlug <- "?key="
  
  # Shodan Search function
  ssearch <- function(ip){
    full <- fromJSON(paste0(urlBase,ip,keySlug,apiKey))
  }
  
  # Reactively set up which description to display based off which radio button is selection
  output$selection <- reactive({
    switch(input$funcSelect,
           "none" = "No option selected.",
           "ssearch" = "Search Shodan. This can be a text string, an IP address, a hostname, a port number, or anything else.",
           "sscan" = "Trigger an on-demand scan of an IP or range.",
           "dns" = "Look up the IP address for the provided list of hostnames.",
           "rdns" = "Look up the hostnames that have been defined for the given list of IP addresses.",
           "apiinfo" = "Returns information about the API plan belonging to the given API key",
           "apikey" = paste(apiKey)
    )
  })
  # Run the selected function
  output$results <- renderUI({
    switch(input$funcSelect,
           "ssearch" = {
             ssearch(input$searchQuery)
             },
           "sscan" = ,
           "dns" = ,
           "rdns" = 
           )
  })

}

# Run the app
shinyApp(ui,server)