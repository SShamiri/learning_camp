library(highcharter)
library(tidyverse)


nat = 15
occ = 8
ind = (8*10)/15

d = data.frame(low = 0, high = 10, ind = ind)
d %>% 
  hchart( "bullet", hcaes(x = low, y = ind, target = ind), color = "rgba(204,204,204,0.6)") %>%
  hc_chart(inverted = TRUE) %>%
  hc_yAxis(
    min = 0,
    max = 10,
    gridLineWidth = 0,
    plotBands = list(
      list(from = 0, to = 3, color = "#D21F3C"),
      list(from = 3, to = 6, color = "#999"),
      list(from = 6, to = 10, color = "#4fb443")
    )
  ) %>%
  hc_xAxis(
    gridLineWidth = 15,
    gridLineColor = "white",
    labels = list(enabled = FALSE),
    title = list(text= '')
  ) %>% 
  hc_plotOptions(
    series = list(
      pointPadding = 0.25,
      pointWidth = 15,
      borderWidth = 0,
      targetOptions = list(width = '200%')
    )
  ) %>% 
  hc_size(height = 60) %>%
  hc_yAxis(
    labels = list(enabled = FALSE),
    title = list(text= '')
  )
