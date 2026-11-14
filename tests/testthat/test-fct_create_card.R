test_that("function returns bslib cards", {
  # read data for tests
  print("about to get the data")
  velo_ready <- readRDS(test_path("fixtures", "velo_ready.rds"))
  print(head(velo_ready$cards_info$sum_current_year))
  # prepare inputs
  filtered_data <- filter_data_with_inputs("VZS_ANDR", "velo_out", velo_ready)

  expect_s3_class(
    create_card(filtered_data$cards$sum_latest_days[1, ],
      type_card = "day",
      type_fz = "Velos"
    ),
    "bslib_fragment"
  )

  expect_s3_class(
    create_card(filtered_data$cards$sum_current_year[1, ],
      type_card = "year",
      type_fz = "Velos"
    ),
    "bslib_fragment"
  )
})
