#' input UI Function
#'
#' @description A shiny Module with all the inputs, returning the filtered data from the server
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_input_ui <- function(id) {
  ns <- NS(id)

  tagList(
    h1(paste0("Aktive ", get_golem_config("fahrzeug_sg"), "-Zählstellen in der Stadt Zürich")),
    p("Wählen Sie eine Zählstelle aus für mehr Informationen."), 
    maplibreOutput(ns("map"), height = 600),
    br(),
    conditionalPanel(
      condition = "input.map_feature_click &&
               typeof input.map_feature_click.properties.loc_id !== 'undefined'
",
      ns = ns,
      h2("Wählen Sie eine Richtung", style = "text-align:center;"),
      div(
        class = "ssz-chart-buttons",
        sszRadioGroupButtons(
          label = NULL,
          inputId = ns("direction"),
          choices = c("")
        )
      )
    )
  )
}

#' input Server Functions
#'
#' @description A shiny Module server
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_input_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # observe click to update available directions
    observeEvent(input$map_feature_click$properties$loc_id, {
      req(input$map_feature_click$properties$loc_id)
      available_dirs <- data_ready$loc_dir |>
        filter(loc_id == input$map_feature_click$properties$loc_id) |>
        select(dir_id, dir_name)
      shinyWidgets::updateRadioGroupButtons(
        session = session,
        inputId = "direction",
        choiceNames = available_dirs$dir_name,
        choiceValues = available_dirs$dir_id
      )
    })

    # filter data based on inputs
    filtered_data <- reactive({
      req(input$map_feature_click$properties$loc_id, input$direction)
      filter_data_with_inputs(input$map_feature_click$properties$loc_id, input$direction)
    })

    app_type <- get_golem_config("app_type")
    if (app_type == "velo") {
      duplicates_possible <- TRUE
    } else {
      duplicates_possible <- FALSE
    }

    output$map <- renderMaplibre({
      plot_locations_stadtkarte(data_ready$df_location, data_ready$common_shapes$kreise, duplicates_possible = duplicates_possible)
    })

    # create and update reactive value to indicate whether all inputs are currently valid
    inputs_valid <- reactiveVal(value = FALSE)
    observeEvent(
      eventExpr = list(
        input$map_feature_click$properties$loc_id, input$direction
      ),
      handlerExpr = {
        if (is.null(input$map_feature_click$properties$loc_id) | is.null(input$direction)) {
          inputs_valid(FALSE)
        } else {
          inputs_valid(TRUE)
        }
      },
      ignoreNULL = FALSE
    )

    return(list(
      "filtered_data" = filtered_data,
      "inputs_valid" = inputs_valid
    ))
  })
}

## To be copied in the UI
# mod_input_ui("input_1")

## To be copied in the server
# mod_input_server("input_1")
