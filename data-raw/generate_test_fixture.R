## code to prepare data to be used in tests, so some data is available at all
devtools::load_all()
velo_all <- read_velo_data()
data_ready <- prep_velo_data(velo_all)
data_ready$common_shapes <- read_common_shapes()
data_ready$date_update <- stamp("31.03.2026")(today())
saveRDS(data_ready, here::here("tests", "testthat", "fixtures", "velo_ready.rds"))
