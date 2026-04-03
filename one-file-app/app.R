#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)
library(palmerpenguins)

# Create user interface
ui <- fluidPage(
  
  # App title
  tags$h1("My App Title"), 
  
  
  # App subtitle 
  h2(strong("Exploring Antarctic Penguin Data")), # bold 
  
  # Body mass slider input 
  sliderInput(inputId = "body_mass_input", 
              label = "Select a range of body masses (g)", # text above slider to know what to do with it
              min = 2700, max = 6300, value = c(3000,4000)),
  
  # Body mass plot output
  plotOutput(outputId = "body_mass_scatterplot_output")
  
  )
              

# Server _______________________
server <- function(input, output){
  
  # Create new data frame to filter body masses to feed into plot... call values from UI slides
  body_mass_df <-  reactive({
    
    body_mass_df <- penguins |> 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
    
    
    
  })# Need to tell shiny that is reactive 
  
  
  # Place plot in position defined by slider
  output$body_mass_scatterplot_output <- renderPlot(
    { 
      # Code to generate plot goes here, wrapped in curly braces 
      ggplot(na.omit(body_mass_df()), 
             aes(x = flipper_length_mm, y = bill_length_mm, 
                 color = species, shape = species)) +
        geom_point() +
        scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
        scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
        labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
             color = "Penguin species", shape = "Penguin species") +
        guides(color = guide_legend(position = "inside"),
               size = guide_legend(position = "inside")) +
        theme_minimal() +
        theme(legend.position.inside = c(0.85, 0.2), 
              legend.background = element_rect(color = "white"))
      }
  )
  
  
  
}

# Combine ui and server into an app 
shinyApp(ui = ui, server = server)







