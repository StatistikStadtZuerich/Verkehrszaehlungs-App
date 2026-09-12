test_that("girafe object is returned", {
  velo_ready <- readRDS(test_path("fixtures", "velo_ready.rds"))
  p1 <- plot_jahresentwicklung(velo_ready$df_jahresentwicklung |>
    filter(loc_id == "VZS_MUEH", dir_id == "velo_in"))
  expect_s3_class(girafe_with_options(p1), "girafe")
  expect_s3_class(girafe_with_options_point(p1, "jahre"), "girafe")
})
