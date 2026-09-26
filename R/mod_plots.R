#' plots UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plots_ui <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      id = ns("tagesplot"),
      div(
        class = "button-div",
        h2("Tagesgang"),
        sszDownloadButton(ns("download_tagesgang"), "CSV", icons_stzh()("download"))
      ),
      shinycssloaders::withSpinner(
        girafeOutput(ns("tagesgang")),
        type = 7,
        color = "#0F05A0"
      ),
    ),
    br(),
    br(),
    div(
      id = ns("jahresplot"),
      div(
        class = "button-div",
        h2("Entwicklung über die Jahre"),
        sszDownloadButton(ns("download_jahre"), "CSV", icons_stzh()("download"))
      ),
      shinycssloaders::withSpinner(
        girafeOutput(ns("jahresentwicklung")),
        type = 7,
        color = "#0F05A0"
      )
    )
  )
}

#' plots Server Functions
#' @description A shiny Module server
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_plots_server <- function(id, filtered_data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # fonts
    font_name <- deal_with_fonts()

    # type of vehicle
    vehicle_type <- get_golem_config("fahrzeug_pl")

    # do not show if there are no data
    observe({
      # Jahresentwicklung: only show if there are more than 1 years' worth of data
      # shinyjs handles the namespacing
      shinyjs::toggle(id = "jahresplot", condition = nrow(filtered_data()$df_jahre) > 3)
      shinyjs::toggle(id = "tagesplot", condition = nrow(filtered_data()$df_tagesgang) > 3)
    }) |>
      bindEvent(filtered_data())

    # Plots
    output$tagesgang <- renderGirafe({
      q <- plot_tagesgang(filtered_data()$df_tagesgang, font_name, vehicle_type) +
        labs(title = "") +
        theme(legend.position = "bottom")

      girafe_with_options_point(q, "tagesgang")
    })

    output$jahresentwicklung <- renderGirafe({
      p <- plot_jahresentwicklung(filtered_data()$df_jahre, font_name, vehicle_type) +
        labs(title = "") +
        theme(legend.position = "bottom")

      girafe_with_options_point(p, "jahre")
    })

    # Downloads
    output$download_tagesgang <- downloadHandler(
      filename = function() {
        paste0(
          dmy(data_ready$date_update), "_",
          unique(filtered_data()$df_tagesgang$loc_id), "_",
          unique(filtered_data()$df_tagesgang$dir_id), "_tagesgang.csv"
        )
      },
      content = function(file) {
        write.csv(filtered_data()$df_tagesgang |> select(-data_id, -tooltip), file, row.names = FALSE)
      }
    )

    output$download_jahre <- downloadHandler(
      filename = function() {
        paste0(
          dmy(data_ready$date_update), "_",
          unique(filtered_data()$df_jahre$loc_id), "_",
          unique(filtered_data()$df_jahre$dir_id), "_jahresentwicklung.csv"
        )
      },
      content = function(file) {
        write.csv(filtered_data()$df_jahre |> select(-data_id, -tooltip), file, row.names = FALSE)
      }
    )
  })
}

## To be copied in the UI
# mod_plots_ui("plots_1")

## To be copied in the server
# mod_plots_server("plots_1")
