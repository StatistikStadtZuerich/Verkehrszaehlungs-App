# script to get the latest data from ogd and save it locally
# run locally, and will be run also in the deployment pipeline
#
# when running locally: load all as well
pkgload::load_all(attach_testthat = FALSE)

# assign appropriate reading and wrangling functions depending on the configuration
read_data <- match.fun(get_golem_config("read_fct"))
wrangle_data <- match.fun(get_golem_config("wrangle_fct"))

# call those functions to get the latest data
# the data-reading function already makes sure we have the following necessary columns:
# c("loc_id", "loc_name", "dir_id", "dir_name", "n_vehicles", "timestamp", "yday", "jahr")
latest_data <- read_data()
# make sure we have at least 2mio entries
stopifnot(nrow(latest_data) > 2000000)
# make sure we have at least 15 locations
stopifnot(length(unique(latest_data$loc_id)) > 15)
# we do not want any NAs
if (get_golem_config("app_type") == "velo") {
  # no NAs in velo data
  stopifnot(sum(is.na(latest_data)) == 0)
} else {
  # at this stage, MIV count can be missing --> only check selected columns
  stopifnot(sum(is.na(latest_data |> select(dir_id, dir_name, loc_id, loc_name, timestamp, jahr, timestamp_hours_only))) == 0)
}


# wrangle data: prepare for plotting
data_ready <- wrangle_data(latest_data)
stopifnot(names(data_ready) == c("loc_dir", "df_location", "df_tagesgang", "cards_info", "df_jahresentwicklung"))
# we want some locations, and they should be the same in the two location-related dfs
stopifnot(length(unique(data_ready$df_location$loc_id)) > 15)
stopifnot(sort(unique(data_ready$loc_dir$loc_id)) == sort(unique(data_ready$df_location$loc_id)))
# todo: adjust sszvz so that included locations are identical in all dfs
# check we have reasonable amount of content
stopifnot(nrow(data_ready$df_tagesgang) > 2000)
stopifnot(nrow(data_ready$cards_info$sum_current_year) > 25)
stopifnot(nrow(data_ready$cards_info$sum_current_year) == nrow(data_ready$cards_info$sum_latest_days))
stopifnot(nrow(data_ready$df_jahresentwicklung) > 600)

# also get common shapes ready for plotting
data_ready$common_shapes <- read_common_shapes()
stopifnot(nrow(data_ready$common_shapes$kreise) == 12)
stopifnot(nrow(data_ready$common_shapes$quartiere) == 34)
stopifnot(nrow(data_ready$common_shapes$see) == 1)

# and the time of the data update (31.03.2026 only provides the format)
data_ready$date_update <- stamp("31.03.2026")(today())

usethis::use_data(data_ready,
  overwrite = TRUE,
  internal = TRUE
)
