library(shinyjs)
library(shiny)
library(R.utils)

jscode <- paste(readLines("./www/customInitialImport.js"), collapse = "\n")
# jscode <- "
# shinyjs.init = function() {
#   $(document).keypress(function(e) { alert('Key pressed: ' + e.which); });
# }"

sampletab1 <- tabPanel(
  value = "sample1",
  title = "Sample 1",
  sidebarLayout(
    sidebarPanel(
      id = "file1sidebar"
    ),
    mainPanel(
      div("test")
    )
  )
)

sampletab2 <- tabPanel(
  value = "sample2",
  title = "Sample 2",
  sidebarLayout(
    sidebarPanel(
      id = "file2sidebar"
    ),
    mainPanel(
      div("test2")
    )
  ))