library(tidyverse)
library(highcharter)


# overlapping bars by groups

# data structure
df <- data.frame(cat = c("bg1", "bg2"), 
                 val1 =c(30, -25),
                 val2 = c(20, -30)) %>% 
  pivot_longer(-cat, names_to = 'g', values_to = 'val')

# plot 
df %>% 
  hchart(type ='bar', 
         hcaes(x = cat, y = val, group = g),
         grouping = FALSE,
         pointWidth =  c(60,30), # controls the width of each group
         showInLegend = FALSE,
         borderWidth = 0
         ) %>% 
  hc_colors(colors = c('rgb(255, 0, 0, 0.2)', 'rgb(0, 255, 0, 0.2)')) 
 
# Note hc_plotOptions not for bar charts. series option are part of hchart
 # hc_plotOptions(
  #   borderWidth = 0
  # ) 


# overlapping bars (slide bar)
df2 <- data.frame(bg = c("bg", "bg"), 
                  val1 =c(100, # measure scale form -100 to 100
                          -100),
                  val2 = c(54, # supply value
                           0 # demand value
                  )
) %>% 
  pivot_longer(-bg, names_to = 'g', values_to = 'val')

# plot

hc <- df2 %>% filter(val == 54) %>%  
  hchart(type ='bar', 
         hcaes(x = bg, y = val),
         dataLabels = list(
           enabled= T,
           #align = 'left',
           inside = T,
           format = '{y} %'
         ) ,
         pointWidth = 20,
         color = "red"
         
  )  

hc3 <- hc %>% 
  hc_add_series(df2 %>% filter(val != 54 & val != 0), type ='bar', 
                hcaes(x = bg, y = val, group = g),
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


##
df2 %>% filter(val != 54) %>%  
  hchart(type ='bar', 
         hcaes(x = bg, y = val),
         dataLabels = list(
           enabled= T,
           inside = F,
           formatter = JS("function() { return Math.abs(this.y) + ' %'}")
         ) ,
         pointWidth = 20,
         color = "rgb(0, 255, 0, 0.2)"
  )  
