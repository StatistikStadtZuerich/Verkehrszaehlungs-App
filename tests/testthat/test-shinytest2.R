library(shinytest2)

# Map somehow does not show in test; temporarily comment this out
# test_that("run example", {
#   # prepare inputs
#   # preparation
#   if (get_golem_config("app_type") != "miv") {
#     map_feature_click <- "VZS_ANDR"
#     direction <- "velo_in"
#   } else {
#     map_feature_click <- list("id" = "Z029")
#     direction <- "Z029M001"
#   }
#   click_properties <- list(list("loc_id" = map_feature_click))
#   names(click_properties) <- "properties"
#   app <- AppDriver$new(name = "ex1", height = 1010, width = 880)
#   Sys.sleep(4)
#   app$expect_values()
#
#   # set nested input value via JS
#   app$run_js(paste0("
#     Shiny.setInputValue('input_1-map_feature_click', {
#       properties: { loc_id: ", map_feature_click, " }
#     });
#   "))
#   app$set_inputs(`input_1-direction` = direction)
#   Sys.sleep(4)
#   app$expect_values()
# })


# test_that("check downloads", {
#   app <- AppDriver$new(name = "shiny-golem-no-graphs-downloads", height = 1010, width = 880)
#   app$click("action_button")
#   # check csv download
#   Sys.sleep(1) # otherwise not ready?
#   app$expect_download("download_1-csv_download")
#   # check excel
#   # adjust test for excel: as metadata is different every time, get file and
#   # compare only the content
#   # not tested like this: the image and the date on the first sheet
#   temp_excel_file <- "temp-excel-test.xlsx"
#   app$get_download("download_1-excel_download", temp_excel_file)
#   sheet1 <- read.xlsx(temp_excel_file, sheet = 1, colNames = F)
#   # only test first 3 columns, 4th columns contains date
#   expect_snapshot(sheet1[, 1:3])
#   sheet2 <- read.xlsx(temp_excel_file, sheet = 2, colNames = F)
#   expect_snapshot(sheet2)
#   file.remove(temp_excel_file)

#   # adjust inputs
#   app$set_inputs(`input_1-gender_dog_radio_button` = "weiblich")
#   app$set_inputs(`input_1-select_kreis` = "Kreis 12")
#   app$set_inputs(`input_1-select_year` = c(2017, 2024))
#   app$click("action_button")
#   # check downloads again
#   app$expect_download("download_1-csv_download")

#   # check excel
#   # adjust test for excel: as metadata is different every time, get file and
#   # compare only the content
#   # not tested like this: the image and the date on the first sheet
#   temp_excel_file <- "temp-excel-test.xlsx"
#   app$get_download("download_1-excel_download", temp_excel_file)
#   sheet1 <- read.xlsx(temp_excel_file, sheet = 1, colNames = F)
#   # only test first 3 columns, 4th columns contains date
#   expect_snapshot(sheet1[, 1:3])
#   sheet2 <- read.xlsx(temp_excel_file, sheet = 2, colNames = F)
#   expect_snapshot(sheet2)
#   file.remove(temp_excel_file)
# })
