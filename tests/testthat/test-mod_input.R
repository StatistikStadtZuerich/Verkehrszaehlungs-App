# currently no module server tests
# testServer(
#   mod_input_server,
#   # Add here your module params
#   args = list(),
#   {
#     ns <- session$ns
#     session$setInputs(
#       "map_feature_click" = list(properties = list(loc_id = list(id = "velo_in"))),
#       "direction" = "VZS_ANDR"
#     )
#     # Check returned
#     res <- session$returned

#     # make sure output assignment worked
#     expect_identical(res$filtered_data(), filtered_data())

#     # this is (initially) not true, as we intentionally do not use `req`
#     # and the observer updates immediately --> do not test this here
#     # expect_true(res$inputs_valid())
#   }
# )

test_that("module ui works", {
  ui <- mod_input_ui(id = "test")
  golem::expect_shinytaglist(ui)
  # Check that formals have not been removed
  fmls <- formals(mod_input_ui)
  for (i in c("id")) {
    expect_true(i %in% names(fmls))
  }
})
