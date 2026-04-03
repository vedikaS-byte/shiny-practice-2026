#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Create user interface
ui <- fluidPage(
  
  # App title
  tags$h1("My App Title"), 
  
  
  # App subtitle 
  h2(strong("Exploring Antarctic Penguin Data")) # bold 
  
)

# Server
server <- function(input, output){
  
  
}

# Combine ui and server into an app 
shinyApp(ui = ui, server = server)

