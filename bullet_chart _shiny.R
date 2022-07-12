library(shiny)
library(bs4Dash)
library(shinyWidgets)

shinyApp(
  ui = dashboardPage(
    header =  dashboardHeader(title = "test", titleWidth = 950, disable = FALSE),
    sidebar = dashboardSidebar(),
    body = dashboardBody(
      fluidRow(
        box(title = "box1", status = "primary",
            highchartOutput("eff",height = "100px"), 
            #br(),
            highchartOutput("ci",height = "100px")
            ),
        box(title = "box2", status = "primary",
            p("holder")
        )
      ),
      fluidRow(
        box(title = "box1", status = "primary",
            div(p('holder'), style = "height:50%"), 
            br(),
            div(p('holder'), style = "height:50%")
        ),
        box(title = "box2", status = "primary",
            p("holder")
        )
      )
    ),
    controlbar = dashboardControlbar(),
    title = "DashboardPage"
  ),
  server = function(input, output) { 
    
    nat = 15
    occ = 8
    ind = (8*10)/15
    
    d = data.frame(low = 0, high = 10, ind = ind)
    
    output$eff <- renderHighchart({
      
      d %>% 
        hchart( "bullet", hcaes(x = low, y = ind, target = ind), 
                #color = "rgba(204,204,204,0.6)"
                color = '#3D3DDD') %>%
        hc_chart(inverted = TRUE) %>%
        hc_yAxis(
          min = 0,
          max = 10,
          gridLineWidth = 0,
          plotBands = list(
            list(from = 0, to = 3, color = "#D21F3C",
                 label = list(text = 'Worse', y = 40, align = 'left')),
            list(from = 3, to = 6, color = "#999",
                 label = list(text = 'Same', y = 40)),
            list(from = 6, to = 10, color = "#4fb443",
                 label = list(text = 'Better', y = 40, align = 'right'))
          )
        ) %>%
        hc_xAxis(
          gridLineWidth = 5,
          gridLineColor = "white",
          labels = list(enabled = FALSE),
          title = list(text= '')
        ) %>% 
        hc_plotOptions(
          series = list(
            pointPadding = 0.25,
            pointWidth = 10,
            borderWidth = 0,
            targetOptions = list(width = '200%')
          )
        ) %>% 
        hc_size(height = 83) %>%
        hc_yAxis(
          labels = list(enabled = FALSE),
          title = list(text= '')
        ) %>%
        hc_subtitle(
          text = "Efficiency",
          align = "left",
          style = list(
            #color = "#2b908f", 
            fontWeight = "bold")
        )
    })
    
    output$ci <- renderHighchart({
      
      d %>% 
        hchart( "bullet", hcaes(x = low, y = ind, target = ind), 
                #color = "rgba(204,204,204,0.6)"
                color = '#3D3DDD') %>%
        hc_chart(inverted = TRUE) %>%
        hc_yAxis(
          min = 0,
          max = 10,
          gridLineWidth = 0,
          plotBands = list(
            list(from = 0, to = 5, 
                 color = "#ffffff",
                 label = list(text = 'Low', y = 40, align = 'left')),
            list(from = 5, to = 10, color = "#ffffff",
                 label = list(text = 'High', y = 40, align = 'right'))
          )
        ) %>%
        hc_xAxis(
          gridLineWidth = 5,
          gridLineColor = "#574b4b",
          labels = list(enabled = FALSE),
          title = list(text= '')
        ) %>% 
        hc_plotOptions(
          series = list(
            pointPadding = 0.25,
            pointWidth = 10,
            borderWidth = 0,
            targetOptions = list(width = '200%')
          )
        ) %>% 
        hc_size(height = 90) %>%
        hc_yAxis(
          labels = list(enabled = FALSE),
          title = list(text= '')
        ) %>%
        hc_subtitle(
          text = "Confidence",
          align = "left",
          style = list(
            #color = "#2b908f", 
            fontWeight = "bold")
        )
    })
    
    } # server
)