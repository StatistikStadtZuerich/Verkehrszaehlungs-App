#' create bslib card
#'
#' create card for showing the number of vehicles in current year or on latest day
#'
#' @param row_prepped single row of data prepared for the card
#' @param type_card type of card, "day" or "year"
#' @param type_fz string, used in label, "Velos" or "Autos"
#'
#' @return bslib card
create_card <- function(row_prepped, type_card = c("day", "year"), type_fz = c("Velos", "Autos")) {
  if (type_card == "day") {
    number_description <- glue("{type_fz} am {format(row_prepped$last_valid_date, '%d.%m.%Y')}")
  } else if (type_card == "year") {
    number_description <- glue("{type_fz} im {row_prepped$jahr} bisher")
  }
  card(
    card_body(
      p(number_description),
      h1(format(round(row_prepped$n_vehicles, digits = 0), big.mark = " "), style = "font-size: 2.5rem;"),
      p(glue("{row_prepped$loc_name} Richtung {row_prepped$dir_name}"))
    )
  )
}
