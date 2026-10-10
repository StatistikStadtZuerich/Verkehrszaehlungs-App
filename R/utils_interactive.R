#' girafe_with_options
#'
#' standard version: add girafe options to ggplot
#'
#' @param ggplot_obj ggplot object
#'
#' @return girafe object
#' @keywords internal
#' @noRd
#' @examples
#' girafe_with_options(p)
girafe_with_options <- function(ggplot_obj) {
  girafe(
    ggobj = ggplot_obj,
    canvas_id = "zzz", # to make shinytest behaviour consistent, see https://github.com/davidgohel/ggiraph/issues/276
    options = list(
      # specify styling of tooltip (as placeholder: css in inst/app/www/mpe.css)
      # placeholder is required as otherwise the border appears thick black
      opts_tooltip(css = ""),
      # deal with default toolbar (save as png etc)
      opts_toolbar(
        saveaspng = FALSE,
        hidden = c("selection")
      ),
      opts_zoom(min = 1, max = 3, default_on = TRUE),
      # specify styling of element one hovers over
      opts_hover(
        css = "fill:#23C3F1;stroke:#23C3F1;",
        reactive = TRUE,
        nearest_distance = 80
      ),
      # selection
      opts_selection(
        type = "single",
        css = "r:3pt;fill:#23C3F1;stroke:#23C3F1;", # fill:#DB247D;stroke:#DB247D;",
        only_shiny = TRUE
      ),
      opts_sizing(rescale = TRUE)
    )
  )
}


#' girafe_with_options_point
#'
#' version for line/point plot, add girafe options to ggplot
#'
#' @param ggplot_obj ggplot object
#' @param canvas_id basically a ggiraph ID for the plot, string
#' @param hover_alpha brightness css value, default 85%
#'
#' @return girafe object
#' @keywords internal
#' @noRd
#' @examples
#' girafe_with_options_point(p)
girafe_with_options_point <- function(ggplot_obj, canvas_id, hover_alpha = "85%") {
  girafe(
    ggobj = ggplot_obj,
    canvas_id = canvas_id, # to make shinytest behaviour consistent, see https://github.com/davidgohel/ggiraph/issues/276
    options = list(
      # specify styling of tooltip (as placeholder: css in inst/app/www/mpe.css)
      # placeholder is required as otherwise the border appears thick black
      opts_tooltip(css = ""),
      # deal with default toolbar (save as png etc)
      opts_toolbar(
        saveaspng = FALSE,
        hidden = c("selection")
      ),
      opts_zoom(max = 1),
      # specify styling of element one hovers over
      opts_hover(
        css = "r:1.5pt;stroke:white;stroke-width:1;",
        nearest_distance = 80
      ),
      # opts_hover_inv(css = "stroke-width:8;"),
      # prevent selection (only applicable for mobile)
      opts_selection(
        type = "none",
        css = "r:15pt;"
      ),
      opts_sizing(rescale = TRUE)
    )
  )
}
