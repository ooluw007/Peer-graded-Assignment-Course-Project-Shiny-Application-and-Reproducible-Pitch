library(shiny)
library(tidyverse)

u <- shinyUI(fluidPage(
    titlePanel(h1("Distribution of Simulated Sample Means")),
    sidebarLayout(position = "left",
                  sidebarPanel(h3("Original Population"),
                               h4("1. Exponential distribution"),
                               h4("2. Population mean = 50"),
                               h4("3. Rate parameter = 0.02"),
                               br(),
                               h3("Panel Sliders"),
                               
                               sliderInput("nsim","Number of simulations",
                                           min=1000,max=10000,value=1000),
                               sliderInput("n","Sample size",
                                           min=10,max=1000,value=100),
                               submitButton("Submit")
                               
                  ),
                  mainPanel(
                      
                      h3("Means of simulated samples drawn from an original 
                         population with exponential distribution are normally 
                         distributed."),
                      plotOutput("plot")
                      
                  )
    )
))
