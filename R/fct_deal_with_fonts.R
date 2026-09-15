#' deal_with_fonts
#'
#' @description Function to register fonts for ggplot and ggiraph
#'
#' @details
#' if the font ordner with the proprietary font files is present, use those, otherwise use sans-serif
#'
#'
#' @return Returns a string with a font family name to be used in the ggplot theme (empty if proprietary font files not found)
#'
#' @noRd
deal_with_fonts <- function() {
  # these are the expected font files
  file_plain <- here("inst", "app", "www", "fonts", "HelveticaNeueLTPro-Roman.ttf")
  file_bold <- here("inst", "app", "www", "fonts", "HelveticaNeueLTPro-Hv.ttf")

  if (file.exists(file_plain) && file.exists(file_bold)) {
    # dealing with fonts and colors -------
    # register for ggiraph
    systemfonts::clear_registry()
    systemfonts::register_font(
      name = "SSZ",
      plain = file_plain,
      bold = file_bold
    )

    # register for ggplot
    sysfonts::font_add(
      family = "SSZ",
      regular = file_plain,
      bold = file_bold
    )

    # Plotting Resolution Parameters; this is necessary for the font to be found
    showtext::showtext_auto()
    showtext::showtext_opts(dpi = 300)

    return("SSZ")
  } else {
    return("")
  }
}
