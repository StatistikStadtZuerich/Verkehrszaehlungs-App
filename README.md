# Verkehrszählungen Shiny App(s)

Golem-basierte Shiny Applikation(en) um die Verkehrszählungen auf der Website darzustellen.

## Datenaufbereitung

Die Datenaufbereitung erfolgt unter Verwendung des [sszvz-Verkehrszählungs-Packages](https://github.com/StatistikStadtZuerich/sszvz-Verkehrszaehlungen), das dezidierte Funktionen zur Verfügung stellt, um die App nicht noch komplizierter zu machen.

## Config für MIV/Velo

Die Applikation verwendet das File unter `inst/golem-config.yml` (Aufbau wie ein "normales" config). Indem lokal die Umgebungsvariable geändert wird, z.B. mit `Sys.setenv("GOLEM_CONFIG_ACTIVE" = "miv")` oder `Sys.setenv("GOLEM_CONFIG_ACTIVE" = "velo")` kann zwischen den zwei Varianten der App gewechselt werden. Beim Entwickeln sollten immer beide Varianten (miv, velo) getestet werden! Neben der Anpassung des Configs müssen danach auch die richtigen Daten verwendet werden, das passiert, indem man `data-raw/create_latest_data.R` einmal ausführt. In der GitLab Pipeline passiert dies automatisch, für die Entwicklung muss dies lokal händisch gemacht werden.

Fürs Deployment funktioniert der Wechsel basierend auf der Umgebungsvariable nicht (man kann shinyapps.io keine Umgebunsvariablen mitgeben), daher wird in der Pipeline das File überschrieben mit einem der beiden YAML-Files im dev-Ordner. Wenn man die Konfiguration anpasst, muss das daher jeweils immer an beiden Orten parallel angepasst werden!

## Daten für Tests

Für die Tests werden die Velo-Daten gespeichert und verwendet. Das wird generiert mit data-raw/generate_test_fixture.R und unter tests/testthat/fixtures gespeichert und in den Tests wo nötig geladen.

## Known Issues

Die Tests sind erfolgreich mit `devtools::test()` aber scheitern mit `devtools::check()`. 