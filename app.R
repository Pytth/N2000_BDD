#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
SPECIES = read.csv2("DATA/SPECIES.csv",h=T)
library(shiny)
library(tidyverse)
# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Site N2000"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput("siteN2000","Code site natura 2000",""),
            submitButton("Search")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            dataTableOutput("tabResult"),
            downloadButton("downloadData","Download")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$tabResult <- renderDataTable({
        SPECIES=SPECIES[SPECIES$SITECODE %in% input$siteN2000,]
        SPECIES
    })
    output$downloadData <- downloadHandler(
        filename = function() {
            paste("data-", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
            write.csv(SPECIES[SPECIES$SITECODE %in% input$siteN2000,], file)
        }
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)


# rsconnect::deployApp('C:/Users/Augustin Soulard/Documents/R/Workflow/N2000/N2000_BDD')

