# Establish user interface
ui <- navbarPage(
  
  # Title 
  title = "LTER Animal Data Explorer",
  
  # (Page 1) Intro tabPanel
  tabPanel(title = "About this app", 
           
           "background info here"
           
  ), # END (page 1) intro tab panel
  
  # (Page 2) Data tabPanel
  tabPanel(title = "Explore the Data", 
           
           "inputs and outputs here") # END (page 2) data tabPanel
) # END navbarPage
