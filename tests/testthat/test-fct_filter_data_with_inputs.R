# preparation
selected_loc <- "VZS_MUEH"
selected_dir <- "velo_in"
data_ready <- readRDS(test_path("fixtures", "velo_ready.rds"))

test_that("filter function returns appropriate named and typed content", {
  # expect named list
  expect_named(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready),
    c("df_jahre", "df_tagesgang", "cards")
  )

  # list should have 4 tibbles
  expect_s3_class(filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_jahre, c("tbl", "data.frame"))
  # expect_s3_class(filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_jahresgang, c("tbl", "data.frame"))
  expect_s3_class(filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_tagesgang, c("tbl", "data.frame"))
  expect_s3_class(filter_data_with_inputs(selected_loc, selected_dir, data_ready)$cards$sum_current_year, c("tbl", "data.frame"))
  expect_s3_class(filter_data_with_inputs(selected_loc, selected_dir, data_ready)$cards$sum_latest_days, c("tbl", "data.frame"))
})

test_that("filter function returns only one location", {
  # each tibble should only contain info about that one location
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_jahre |>
      pull(loc_id) |>
      unique(),
    selected_loc
  )
  # expect_equal(
  #   filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_jahresgang |>
  #     pull(loc_id) |>
  #     unique(),
  #   selected_loc
  # )
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_tagesgang |>
      pull(loc_id) |>
      unique(),
    selected_loc
  )
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$cards$sum_current_year |>
      pull(loc_id) |>
      unique(),
    selected_loc
  )
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$cards$sum_latest_days |>
      pull(loc_id) |>
      unique(),
    selected_loc
  )
})

test_that("filter function returns one direction", {
  # each tibble should only contain info about that one directtion
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_jahre |>
      pull(dir_id) |>
      unique(),
    selected_dir
  )
  # expect_equal(
  #  filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_jahre |>
  #   filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_jahresgang |>
  #     pull(dir_id) |>
  #     unique(),
  #   selected_dir
  # )
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$df_tagesgang |>
      pull(dir_id) |>
      unique(),
    selected_dir
  )
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$cards$sum_current_year |>
      pull(dir_id) |>
      unique(),
    selected_dir
  )
  expect_equal(
    filter_data_with_inputs(selected_loc, selected_dir, data_ready)$cards$sum_latest_days |>
      pull(dir_id) |>
      unique(),
    selected_dir
  )
})
