# Establish user interface
ui <- navbarPage(
  
  # Title 
  title = "LTER Animal Data Explorer",
  
  # (Page 1) Intro tabPanel
  tabPanel(title = "About this app"
  ),# END (page 1) intro tab panel
  
  # (Page 2) Data tabPanel
  tabPanel(title = "Explore the Data", 
           
           tabsetPanel(
             
             # trout tab 
             tabPanel(
               title = "Trout", 
               
               # sidebarLauout fr trout
               sidebarLayout(
                 
                 # trout sidebarPanel
                 sidebarPanel(
                   # channel type pickerInput
                   pickerInput(inputId = "channel_type_input", 
                               label = "Seect channel type(s):", 
                               choices = unique(clean_trout$channel_type), 
                               selected = c("cascade", "pool"), 
                               multiple = TRUE, 
                               options = pickerOptions(actionsBox = T)) # END 
                   
                 ), # End trout sidebarPanel
                 
                 # main panel for trout
                 mainPanel(
                   
                   # Plot out goes here
                   plotOutput(outputId = "trout_scatterplot_output")
                   
                 ) # END trout mainPanel
                 
               )
               
             ), # END trout panel
             
             
             # Pengiuns panel
             tabPanel( 
               title = "Penguins", 
               
               
               # set sidepanel for penguins 
               sidebarLayout(
                 
                 # sidebarPanel
                 sidebarPanel(
                   
                   "penguin input widgets here"
                   
                 ), # END penguins sidebar panel 
                 
                 # Create main panel for results (viz)
                 mainPanel(
                   
                   "penguins data viz here"
                   
                 )
                 
                 
               )
               
               
               
             )
             
           )       
           
           
           
           
           
  ) # END (page 2) data tabPanel
) # END navbarPage









