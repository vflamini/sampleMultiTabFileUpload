###########################################################
# Sets up dark and light mode
light_theme <- bslib::bs_theme(primary = "#027bbf", success = "#316238",
    info = "#07417b", warning = "#f44a1d", danger = "#9e270a",
    bootswatch = "united")
dark_theme <- bslib::bs_theme(primary = "#027bbf", success = "#316238",
    info = "#07417b", warning = "#f44a1d", danger = "#9e270a",
    bootswatch = "darkly")

darkCheckboxUI <- function(id) {
  ns <- NS(id)
  tagList(actionLink(ns("dark"), "Dark Mode"))
}

darkServer <- function(id) {
  moduleServer(id,
    function(input, output, session) {
      observe({
    # Each press of the Dark Mode button ups input$dark by 1
        if (input$dark %% 2 == 1) {
        session$setCurrentTheme(dark_theme)
        updateActionLink(session, "dark", label = "Light Mode")
        } else {
        session$setCurrentTheme(light_theme)
        updateActionLink(session, "dark", label = "Dark Mode")
        }
      })
    }
  )
}
###########################################################
bug_report <- tabPanel(tags$a(
  href = "https://forms.office.com/r/t7BNGFgTCq", target = "_blank",
  list(icon("bug", verify_fa = FALSE), "Report Bug")
))

tutorial <- function(link) {
  tabPanel(tags$a(
    href = link, target = "_blank",
    list(icon("video", verify_fa = FALSE), "Tutorial")
  ))
}

integral_logo <- tags$a(
  href = "https://integralmolecular.com", target = "_blank",
  img(src = "Logo.png", width = "7%"))
