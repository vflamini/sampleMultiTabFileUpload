library(shinyjs)
library(shiny)
library(R.utils)

jscode <- paste(readLines("./www/customInitialImport.js"), collapse = "\n")
# jscode <- "
# shinyjs.init = function() {
#   $(document).keypress(function(e) { alert('Key pressed: ' + e.which); });
# }"
print(jscode)

sampletab1 <- tabPanel(
  title = "Sample 1",
  sidebarLayout(
    sidebarPanel(
      
    ),
    mainPanel(
      div("test")
    )
  )
)

sampletab2 <- tabPanel(
  title = "Sample 2",
  sidebarLayout(
    sidebarPanel(
      
    ),
    mainPanel(
      div("test2")
    )
  ))