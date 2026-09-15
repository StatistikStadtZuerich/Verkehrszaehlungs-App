# currently no module server tets
# testServer(
#   mod_results_server,
#   # Add here your module params
#   args = list(reactive({
#     filter_data_with_inputs("VZS_ANDR", "velo_out")$cards
#   })),
#   {
#     ns <- session$ns
#   }
# )

# module needs data_ready, which is not necessarily available in pipeline for tests
# test_that("module ui works", {
#   ui <- mod_results_ui(id = "test")
#   golem::expect_shinytaglist(ui)
#   # Check that formals have not been removed
#   fmls <- formals(mod_results_ui)
#   for (i in c("id")) {
#     expect_true(i %in% names(fmls))
#   }
# })
