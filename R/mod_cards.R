#' cards UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_cards_ui <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("cards"))
  )
}

#' cards Server Functions
#'
#' @noRd
mod_cards_server <- function(id, cards) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    fahrzeug_pl <- get_golem_config("fahrzeug_pl")
    stopifnot(is.reactive(cards))

    # remove and rename with new zuericssstyle version
    ssz_icons <- function() {
      icons::icon_set(system.file("icons", package = "zuericssstyle"))
    }

    output$cards <- renderUI({
      # only render cards if we have data
      if (nrow(cards()$sum_latest_days) > 0) {
        layout_column_wrap(
          width = 1 / 2,
          create_card(cards()$sum_latest_days, type_card = "day", type_fz = fahrzeug_pl),
          create_card(cards()$sum_current_year, type_card = "year", type_fz = fahrzeug_pl)
        )
      } else {
        sszInfoBox(
          title = "Keine Daten verfügbar",
          text = "An dieser Zählstelle sind momentan keine aktuellen Daten verfügbar.",
          icon = ssz_icons()("info-help-filled")
        )
      }
    })
  })
}

## To be copied in the UI
# mod_cards_ui("cards_1")

## To be copied in the server
# mod_cards_server("cards_1")
