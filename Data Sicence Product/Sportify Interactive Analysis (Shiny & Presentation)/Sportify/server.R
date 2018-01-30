#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(caret)
library(randomForest)
#library(MASS)


source(file = "Model.R")

# Setting up Shiny Server

shinyServer(
    function(input, output, session) {
        # To show new lines in the browser
        decoratedDataStructure <- paste0(dataStructure, collapse = "<br/>")
        output$dataStructure <- renderText({decoratedDataStructure})
        # Builds "reactively" the prediction.
        predictSong <- reactive({
            SongToPredict <- data.frame(
                acousticness = input$acousticness, 
                danceability = input$danceability, 
                duration_ms = input$duration_ms, 
                energy = input$energy, 
                instrumentalness = input$instrumentalness, 
                key = input$key, 
                liveness = input$liveness, 
                loudness = input$loudness, 
                mode = as.numeric(input$mode), 
                speechiness = input$speechiness,
                tempo = input$tempo, 
                time_signature = input$time_signature, 
                valence = input$valence)
            randomForestPredictor(SongRandomForestModelBuilder(), SongToPredict)
        })
        output$prediction <- renderTable({
            predictSong()
        })
    }
)
