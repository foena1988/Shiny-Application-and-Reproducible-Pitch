rm(list=ls(all=TRUE))
library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Plot inhabitants development for Austria"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dataset1",
                  label = "Which provincial states do you want to look at?",
                  choices = c("","Burgenland", "Carinthia", "Lower Austria","Upper Austria","Salzburg" ,"Styria","Tyrol","Vorarlberg","Vienna")),
                  selected = "",
      sliderInput("slider2", label = "Which period do you want to look at?",
                  min = 1988, max = 2017, value = c(1988, 2017),sep=""),

      checkboxInput("show_xlab","Show X Axis Label", value=TRUE),
      checkboxInput("show_ylab","Show Y Axis Label", value=TRUE),
      checkboxInput("show_title","Show Title",value=TRUE),
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
     tabPanel("plot", plotOutput("plot1")),
    tabPanel("Help and Documentation",textOutput("help"))
             
      
    ))
  )
))
