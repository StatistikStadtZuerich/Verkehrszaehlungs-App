#' filter_data_with_inputs
#'
#' @param selected_loc string, selected loc_id for filtering
#' @param selected_dir string, selected dir_id for filtering
#' @param data_list list of input data, defaults to data_ready (name of package data)
#'
#' @description Function to filter the main data according to the selected inputs (location and direction)
#' @return filtered data.frame
#'
#' @noRd
filter_data_with_inputs <- function(selected_loc, selected_dir, data_list = data_ready) {
  return(list(
    df_jahre = data_list$df_jahresentwicklung |>
      filter(
        loc_id == selected_loc,
        dir_id == selected_dir
      ),
    df_tagesgang = data_list$df_tagesgang |>
      filter(
        loc_id == selected_loc,
        dir_id == selected_dir
      ),
    cards = list(
      sum_current_year = data_list$cards_info$sum_current_year |>
        filter(
          loc_id == selected_loc,
          dir_id == selected_dir
        ),
      sum_latest_days = data_list$cards_info$sum_latest_days |>
        filter(
          loc_id == selected_loc,
          dir_id == selected_dir
        )
    )
  ))
}
