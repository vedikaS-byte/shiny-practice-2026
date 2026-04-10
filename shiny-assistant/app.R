library(shiny)
library(bslib)
library(leaflet)

# Sample data for the interactive map
# In a real application, this would come from your actual data source
sample_data <- data.frame(
  lat = c(39.7392, 39.7405, 39.7420, 39.7385, 39.7410),
  lng = c(-104.9903, -104.9915, -104.9890, -104.9920, -104.9880),
  site = paste("Site", 1:5),
  temperature = c(12.5, 13.2, 11.8, 12.9, 13.5),
  pH = c(7.2, 7.4, 7.1, 7.3, 7.5),
  dissolvedOxygen = c(8.5, 8.2, 8.8, 8.3, 8.6)
)

ui <- page_navbar(
  title = "Fish Creek Watershed Monitoring",
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  
  # Welcome tab
  nav_panel(
    title = "Welcome",
    layout_columns(
      card(
        card_header("Dataset Description"),
        card_body(
          p("This dashboard presents water quality monitoring data from the Fish Creek Watershed. 
            The dataset includes measurements of key water quality parameters collected at multiple 
            monitoring sites throughout the watershed."),
          p("Key variables include:"),
          tags$ul(
            tags$li("Temperature (°C): Water temperature measurements"),
            tags$li("pH: Measure of water acidity/alkalinity"),
            tags$li("Dissolved Oxygen (mg/L): Amount of oxygen dissolved in water")
          )
        )
      ),
      card(
        card_header("Data Source"),
        card_body(
          p("Data is collected from five permanent monitoring stations established along 
            Fish Creek. Measurements are taken monthly by trained volunteers and verified 
            by certified laboratory technicians."),
          p(strong("Monitoring Period:"), "January 2023 - Present"),
          p(strong("Collection Frequency:"), "Monthly"),
          p(strong("Quality Assurance:"), "All data undergoes quality control procedures 
            before publication")
        )
      ),
      card(
        card_header("Disclaimer"),
        card_body(
          p(strong("Important Notice:")),
          p("This application is intended for educational and informational purposes only. 
            While every effort has been made to ensure data accuracy, users should verify 
            critical information with official sources before making decisions based on 
            this data."),
          p("The data presented here represents point-in-time measurements and may not 
            reflect current conditions. For real-time water quality information or emergency 
            situations, please contact your local water quality authority."),
          p(em("Last Updated: ", format(Sys.Date(), "%B %d, %Y")))
        )
      ),
      col_widths = c(12, 6, 6)
    )
  ),
  
  # Dashboard tab
  nav_panel(
    title = "Dashboard",
    layout_sidebar(
      sidebar = sidebar(
        title = "Filter Data",
        card(
          card_header("Adjust Variable Ranges"),
          card_body(
            sliderInput(
              "temp_range",
              "Temperature (°C):",
              min = 0,
              max = 30,
              value = c(10, 15),
              step = 0.5
            ),
            sliderInput(
              "ph_range",
              "pH:",
              min = 6,
              max = 9,
              value = c(7, 8),
              step = 0.1
            ),
            sliderInput(
              "do_range",
              "Dissolved Oxygen (mg/L):",
              min = 0,
              max = 15,
              value = c(7, 10),
              step = 0.5
            )
          )
        )
      ),
      card(
        card_header("Monitoring Site Locations"),
        card_body(
          leafletOutput("map", height = "600px")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Reactive filtered data based on slider inputs
  filtered_data <- reactive({
    sample_data[
      sample_data$temperature >= input$temp_range[1] & 
        sample_data$temperature <= input$temp_range[2] &
        sample_data$pH >= input$ph_range[1] & 
        sample_data$pH <= input$ph_range[2] &
        sample_data$dissolvedOxygen >= input$do_range[1] & 
        sample_data$dissolvedOxygen <= input$do_range[2],
    ]
  })
  
  # Render the interactive map
  output$map <- renderLeaflet({
    data <- filtered_data()
    
    leaflet(data) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~lng,
        lat = ~lat,
        radius = 8,
        color = "#2c3e50",
        fillColor = "#3498db",
        fillOpacity = 0.7,
        popup = ~paste0(
          "<strong>", site, "</strong><br/>",
          "Temperature: ", temperature, "°C<br/>",
          "pH: ", pH, "<br/>",
          "Dissolved Oxygen: ", dissolvedOxygen, " mg/L"
        )
      ) %>%
      setView(lng = -104.9903, lat = 39.7392, zoom = 13)
  })
}

shinyApp(ui, server)
