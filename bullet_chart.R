library(highcharter)
library(tidyverse)

# data 
nat = 15
occ = 8
ind = (8*10)/15
d = data.frame(low = 0, high = 10, ind = ind)

# bullet chart with 3 segments

d %>% 
  hchart( "bullet", hcaes(x = low, y = ind, target = ind), 
          color = '#3D3DDD') %>%
  hc_chart(inverted = TRUE) %>%
  hc_yAxis(
    min = 0,
    max = 10,
    gridLineWidth = 0,
    plotBands = list(
      list(from = 0, to = 3, color = "#D21F3C",
           label = list(text = 'Worse', y = 40)),
      list(from = 3, to = 6, color = "#999",
           label = list(text = 'Same', y = 40)),
      list(from = 6, to = 10, 
           color = "#4fb443",
           label = list(text = 'Better', y = 40))
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
  hc_size(height = 90) %>%
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

# bullet chart with linear-gradient

d %>% 
  hchart( "bullet", hcaes(x = low, y = ind, target = ind), 
          color = '#3D3DDD') %>%
  hc_chart(inverted = TRUE) %>%
  hc_yAxis(
    min = 0,
    max = 10,
    gridLineWidth = 0,
    plotBands = list(
      list(from = 0, to = 5, 
           color = list(
             linearGradient = list( x1= 0, y1= 1, x2= 1, y2= 1 ),
             stops= list(
               c(0, '#D21F3C'),
               c(0.9, '#43b4ac'),
               c(1, '#4fb443')
             )
           ),
           #color = "#D21F3C",
           label = list(text = 'Low', y = 40, align = 'left')),
      list(from = 5, to = 10, color = "#4fb443",
           label = list(text = 'High', y = 40, align = 'right'))
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

## bullet chart with a slider-look
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

