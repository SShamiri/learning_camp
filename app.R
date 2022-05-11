library(tidyverse)
library(bs4Dash)

# data 
anzsco3_code = c(111,121,131,132,133,134,135,139,141)
supply = c(0.460,0.030,0.971,0.353,0.872,0.181,0.926,0.552,0.364)
demand = c(0.540,0.970,0.029,0.647,0.128,0.819,0.074,0.448,0.636)
df <- data.frame(anzsco3_code = anzsco3_code, supply = supply *100, demand = demand *100)

# UI
HEADER  <- bs4DashNavbar()
SIDEBAR <- bs4DashSidebar(disable = TRUE)

BODY <-  bs4DashBody(
  # this is for use tooltips in the bs4dash package
  tags$script(HTML("setInterval(function(){ $('[title]').tooltip(); }, 1000)")),
  # filter
  fluidRow(
  selectInput(
    inputId = "anzsco3_filter",
    label = "Search/select occupation",
    choices = sort(unique(df$anzsco3_code)),
    width = '30%'
  )
  ),
  # row tiles
  fluidRow(
    box(
      id = "mkt_bx",
      tabName = "occ_tab",
      title = "test",
      width = 12,
      status = "primary",
      closable = FALSE,
      maximizable = FALSE,
      collapsible = TRUE,
      valueBoxOutput("vbox")
      
    )
  )
) 
# Title
TITLE <- "National Skills Commission"

# =============================================================================
# Build page
# =============================================================================

ui <- bs4DashPage(
  header = HEADER,
  sidebar = SIDEBAR,
  body = BODY,
  title = TITLE,
  dark = NULL,
  scrollToTop = TRUE
)

server <- function(input, output) {
  
  # react data
  compare_df <- reactive({
    df %>% filter(anzsco3_code == input$anzsco3_filter) %>% 
      mutate(shortage = ifelse(supply > demand, 'supply', 'demand'),
             value = abs(supply - demand),
             bg = 'bg') %>% 
      select(shortage, value, bg)
  })
  
  
  output$vbox <- renderValueBox({
    hc <- compare_df() %>%  
      hchart(type ='bar', 
             hcaes(x = bg, y = value, group = shortage),
             dataLabels = list(
               enabled= T,
               #align = 'left',
               inside = T,
               format = '{y} %'
             ) ,
             pointWidth = 20,
             color = "red" 
             )  
    
    hc2 <-  hc %>% 
      hc_add_series( data.frame(bg = rep('bg',2), shortage = rep('measure',2), value = c(-100, 100)),
                     type ='bar', 
                     hcaes(x = bg, y = value, group = shortage),
                     grouping = FALSE,
                     pointWidth =  40, # controls the width of each group
                     showInLegend = FALSE,
                     borderWidth = 0,
                     dataLabels = list(
                       enabled= T,
                       inside = F,
                       formatter = JS("function() { return Math.abs(this.y) + ' %'}")
                     ),
                     color = "rgb(0, 255, 0, 0.2)")  %>% 
      hc_xAxis( visible = FALSE ) %>% 
      hc_yAxis( visible = FALSE ) %>% 
      hc_size(height = 80) %>% 
      hc_add_theme(hc_theme_sparkline_vb())
    
    vb_nsc(
      title = 'shortage in',
      value = '',
      subtitle = '',
      sparkobj = hc2,
      info = NULL,
      icon = NULL,
      color = 'blue',
      width = 3,
      gradient = FALSE,
      elevation = 2
    )
    
    
    
  })
  
}

shiny::shinyApp(ui, server)
