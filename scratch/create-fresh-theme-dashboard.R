library(fresh)

create_theme(
  
  adminlte_color(
    
    light_blue = "midnightblue", 
  ), 
  
  adminlte_global(
    content_bg = "lightpink"
  ), 
  
  adminlte_sidebar(
    width = "400x", 
    dark_bg = "lightblue", 
    dark_hover_bg = "magenta", 
    dark_color = "red"
  ),
 
  output_file = here::here("shinydashboard", "www", "dashboard-fresh-theme.css")
   
)


