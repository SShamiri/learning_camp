# Value Box with title and without footer
vb_nsc <- function(
  title,
  value,
  subtitle,
  sparkobj = NULL,
  info = NULL,
  icon = NULL,
  color = NULL,
  width = 3,
  gradient = FALSE,
  elevation = NULL
) {
  
  if (is.null(color) && gradient) {
    stop("color cannot be NULL when gradient is TRUE. \n
          fill cannot be TRUE when color is NULL.")
  }
  
  if (!is.null(width)) {
    stopifnot(is.numeric(width))
    stopifnot(width <= 12)
    stopifnot(width >= 0)
  }
  
  if (!is.null(elevation)) {
    stopifnot(is.numeric(elevation))
    stopifnot(elevation < 6)
    stopifnot(elevation >= 0)
  }
  
  valueBoxCl <- "small-box"
  
  if (!is.null(color)) {
    if (gradient) {
      valueBoxCl <- paste0(valueBoxCl, " bg-gradient-", color)
    } else {
      valueBoxCl <- paste0(valueBoxCl, " bg-", color)
    }
  }
  
  if (!is.null(elevation))
    valueBoxCl <- paste0(valueBoxCl, " elevation-", elevation)
  
  innerTag <- shiny::tags$div(
    class = "inner",
    shiny::tags$p(class = "small-box-subtitle", title),
    value,
    shiny::tags$p(class = "small-box-subtitle", subtitle),
    shiny::tags$small(
      tags$i(
        class = "fa fa-info-circle fa-lg",
        title = info,
        `data-toggle` = "tooltip",
        style = "color: rgba(255, 255, 255, 0.75);"
      ),
      # bs3 pull-right 
      # bs4 float-right
      class = "pull-right float-right"
    ),
    
    # if (!is.null(sparkobj)) info_icon,
    if (!is.null(sparkobj)) sparkobj
  )
  
  iconTag <- if (!is.null(icon)) {
    shiny::tags$div(class = "icon", icon)
  } else {
    NULL
  }
  
  valueBoxTag <- shiny::tags$div(class = valueBoxCl)
  
  valueBoxTag <- shiny::tagAppendChildren(
    valueBoxTag,
    innerTag,
    iconTag
  )
  
  shiny::tags$div(
    class = if (!is.null(width)) paste0("col-sm-", width), valueBoxTag
  )
}
