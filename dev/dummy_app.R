library(shiny)
library(mapgl)
library(jsonlite)
library(sf)
devtools::load_all()

sf_use_s2(FALSE)
bbox <- st_as_sfc(st_bbox(c(xmin = 5, xmax = 15, ymin = 44, ymax = 50), crs = 4326))
stadtgrenze <- data_ready$common_shapes$kreise |>
  st_make_valid() |>
  st_transform(2056) |>
  st_union() |>
  st_transform(4326)
neg_stadtgrenze <- st_difference(bbox, stadtgrenze)
bbox_stadt <- st_bbox(stadtgrenze)
buffer <- 0.05
zueriblau <- get_zuericolors("qual6", 1)
hover_color <- get_zuericolors("qual6", 5)
# velo can have same loc_id with slightly different coordinates --> only plot the latest one
velo_locations <- data_ready$df_location |>
  arrange(von) |>
  group_by(loc_id) |>
  slice_tail(n = 1)


wms_base <- "https://www.ogc.stadt-zuerich.ch/mapproxy/service?"

wms_tile_template <- paste0(
  wms_base,
  "SERVICE=WMS",
  "&REQUEST=GetMap",
  "&VERSION=1.1.1",
  "&LAYERS=basiskarte_zuerich_grau",
  "&STYLES=",
  "&FORMAT=image/png",
  "&TRANSPARENT=FALSE",
  "&SRS=EPSG:3857",
  "&BBOX={bbox-epsg-3857}",
  "&WIDTH=256",
  "&HEIGHT=256"
)

# IMPORTANT: sources must be {} not []
empty_style <- fromJSON(
  '{
    "version": 8,
    "sources": {},
    "layers": [
      { "id": "background", "type": "background",
        "paint": { "background-color": "#ffffff" } }
    ]
  }',
  simplifyVector = FALSE
)

ui <- fluidPage(
  maplibreOutput("map", height = "700px"),
  verbatimTextOutput("clicked_feature")
)

server <- function(input, output, session) {
  output$map <- renderMaplibre({
    maplibre(
      style  = empty_style,
      center = c(8.5417, 47.3769),
      zoom   = 11,
      minZoom = 10,
      maxZoom = 22,
      maxBounds = list(
    c(bbox_stadt[["xmin"]] - buffer, bbox_stadt[["ymin"]] - buffer),
    c(bbox_stadt[["xmax"]] + buffer, bbox_stadt[["ymax"]] + buffer)
  )  
    ) |>
      add_raster_source(
        id = "zh_basemap",
        tiles = wms_tile_template,
        tileSize = 256,
        maxZoom = 22
      ) |>
      add_raster_layer(
        id = "zh_basemap_layer",
        source = "zh_basemap"
      ) |>
  add_source(
    id = "mask",
    data = st_sf(neg_stadtgrenze) 
  ) |>
  add_fill_layer(
    id = "mask-fill",
    source = "mask",
    fill_color = "#ffffff",
    fill_opacity = 1
    ) |> 
      add_circle_layer(
        id = "locations",
        source = velo_locations,
        circle_color = zueriblau,
        circle_radius = 10,
        circle_opacity = 0.9,
        tooltip = "tooltip",
        hover_options = list(
            circle_radius = 12,
            circle_color = hover_color
        ),
        cluster_options = cluster_options(
          max_zoom = 15
        )
      ) |> 
      add_scale_control() |> 
      add_navigation_control(show_compass = FALSE) 
  }) 

  output$clicked_feature <- renderPrint({
  req(input$map_feature_click$properties$loc_id)
  input$map_feature_click$properties$loc_id
})

  observe({
    req(input$map_feature_click$properties$loc_id)
    props <- input$map_feature_click$properties
    print(input$map_feature_click$properties$loc_id)
  })
}

# todo 
# zoom naja, min und max nicht klar?
# styling --> mit sszpage

shinyApp(ui, server)
