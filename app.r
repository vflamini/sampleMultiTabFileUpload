library(shiny)
library(shinyjs)

# jscode <- "
# shinyjs.init = function() {
#   $(document).keypress(function(e) { alert('Key pressed: ' + e.which); });
# }"
jscode <- paste(readLines("./www/customInitialImport.js"), collapse = "\n")

shinyApp(
  ui = fluidPage(
  # theme = bs_theme() is required for theme.r to work
    theme = bslib::bs_theme(),
    title = "FloJo Import",
    titlePanel(
      tagList(
        title = integral_logo, "96-well to 384-well FloJo Import"
      )
    ),
    navbarPage(
      id = "navbar",
    # theme = bs_theme() is required for theme.r to work
      theme = bslib::bs_theme(),
      # since we have a title panel the title on nav can be blank
      title = "",
    # Sidebar panel for inputs ----
      useShinyjs(),
      extendShinyjs(text = jscode, functions = c("buildImport")),
      sampletab1,
      sampletab2,
      navbarMenu(title = "Help",
        tabPanel(darkCheckboxUI("theme")),
        bug_report,
        tutorial(
          "https://web.microsoftstream.com/video/10c3556e-0258-408c-bc51-4f45d9ccf568" # nolint
        )
      )
    )
  ),

  server = function(input, output) {
    observeEvent(input$navbar, {
      js$buildImport("file1")
      js$buildImport("file2")
    })
    observeEvent(input$file1, {
      shinyjs::logjs(input$file1)
    })
    observeEvent(input$file2, {
      shinyjs::logjs(input$file2)
    })
  }
)