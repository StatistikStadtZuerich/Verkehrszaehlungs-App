#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  input_returns <- mod_input_server("input_1")

  # call modules
  mod_results_server(
    "results_1",
    input_returns$filtered_data
  )

  # observer to check whether all inputs are currently valid and show or
  # hide the div for the results module accordingly (otherwise empty cards
  # would still be shown)
  observeEvent(input_returns$inputs_valid(), {
    # req(input_returns())
    if (input_returns$inputs_valid()) {
      shinyjs::show("results_container")
    } else {
      shinyjs::hide("results_container")
    }
  })
}
