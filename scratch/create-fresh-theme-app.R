library(fresh)

create_theme(
  
  theme = "default",
  
  bs_vars_global(
    body_bg = "beige", 
    text_color = "blue", 
    link_color = "royalblue"

  ), 
  
  bs_vars_navbar(
    default_bg = "limegreen",
    default_color = "gray"
    
  ), 
  
  bs_vars_tabs(
    
    border_color = "violetred4", 
    
  ), 
  
  output_file = here::here("two-file-app", "www", "app-fresh-theme.css")
  
  
)




