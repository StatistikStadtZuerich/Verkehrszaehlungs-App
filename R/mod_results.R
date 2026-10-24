#' results UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_results_ui <- function(id) {
  ns <- NS(id)
  tagList(
    mod_cards_ui(ns("cards_1")),
    br(),
    br(),
    mod_plots_ui(ns("plots_1")),
    br(),
    br(),
    div(
      # Schriftgrösse überschreiben und kleiner machen
      style = "font-size:0.875rem;",
      tags$p(
        "Die Rohdaten für diese Auswertungen finden Sie auf unserm OGD-Portal bei den ",
        tags$a(
          href = get_golem_config("link_ogd_count"),
          target = "_blank",
          "Zähldaten"
        ),
        " und den ",
        tags$a(
          href = get_golem_config("link_ogd_location"),
          target = "_blank",
          "Zählstellen"
        ),
        br(),
        br(),
        "Stand der letzten Datenaktualisierung: ",
        data_ready$date_update
      )
    )
  )
}

#' results Server Functions
#' @description A shiny Module server
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param filtered_data a static data.frame with the filtered data to be shown
#'
#' @noRd
mod_results_server <- function(id, filtered_data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    mod_cards_server("cards_1", reactive({
      # pass cards as reactive value as only then the cards disappear when
      # no location is selected
      filtered_data()$cards
    }))

    mod_plots_server("plots_1", filtered_data)
  })
}

## To be copied in the UI
# mod_results_ui("results_1")

## To be copied in the server
# mod_results_server("results_1")
