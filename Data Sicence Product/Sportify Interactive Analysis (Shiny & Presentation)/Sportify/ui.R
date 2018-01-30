#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Adds support for graphical tooltips and popovers, in order to enrich de UI.
library(shinyBS) 
# Adds Bootstrap themes to a Shiny app.
library(shinythemes)


# read in data and delete useless column
sportify <- read.csv("data.csv")
sportify <- sportify[, c(-1,-16,-17)]
sportify[sportify$target == 1, ]$target = "Like"
sportify[sportify$target == 0, ]$target = "Dislike"
sportify$target <- as.factor(sportify$target)

minacousticness = min(sportify$acousticness)
maxacousticness = max(sportify$acousticness)

mindanceability = min(sportify$danceability)
maxdanceability = max(sportify$danceability)

minduration_ms = min(sportify$duration_ms)
maxduration_ms = max(sportify$duration_ms)

minenergy = min(sportify$energy)
maxenergy = max(sportify$energy)

mininstrumentalness = min(sportify$instrumentalness)
maxinstrumentalness = max(sportify$instrumentalness)

minkey = min(sportify$key)
maxkey = max(sportify$key)

minliveness = min(sportify$liveness)
maxliveness = max(sportify$liveness)

minloudness = min(sportify$loudness)
maxloudness = max(sportify$loudness)

minspeechiness = min(sportify$speechiness)
maxspeechiness = max(sportify$speechiness)

mintempo = min(sportify$tempo)
maxtempo = max(sportify$tempo)

mintime_signature = min(sportify$time_signature)
maxtime_signature = max(sportify$time_signature)

minvalence = min(sportify$valence)
maxvalence = max(sportify$valence)

# Default hypothetical car, in order to initialize th UI widgets.
defaultSong <- data.frame(
    acousticness = 0.01020, 
    danceability = 0.833 ,
    duration_ms = 204600, 
    energy = 0.434, 
    instrumentalness = 0.021900, 
    key = 2, 
    liveness = 0.1650, 
    loudness = -8.795, 
    mode = 1, 
    speechiness = 0.4310,
    tempo =  150.062,
    time_signature = 4,
    valence = 0.286
    )

shinyUI(
    navbarPage(
        "Sportify Like or Not Prediction",
        theme = shinytheme("cerulean"),
        tabPanel(
            "Prediction",
            sidebarPanel(
                width = 4,
                sliderInput("acousticness", "Acousticness", min = minacousticness, max = maxacousticness, value = defaultSong$acousticness, step = 0.00001),
                bsTooltip(id = "acousticness", title = "Acousticness Level", placement = "right", options = list(container = "body")),
                
                sliderInput("danceability", "Danceability", min = mindanceability, max = maxdanceability, value = defaultSong$danceability, step = 0.001),
                bsTooltip(id = "danceability", title = "Danceability Level", placement = "right", options = list(container = "body")),

                sliderInput("duration_ms", "Duration_ms", min = minduration_ms, max = maxduration_ms, value = defaultSong$duration_ms, step = 1),
                bsTooltip(id = "duration_ms", title = "Duration in millisecond", placement = "right", options = list(container = "body")),

                sliderInput("energy", "Energy", min = minenergy, max = maxenergy, value = defaultSong$energy, step = 0.001),
                bsTooltip(id = "energy", title = "Energy Level", placement = "right", options = list(container = "body")),

                sliderInput("instrumentalness", "Instrumentalness", min = mininstrumentalness, max = maxinstrumentalness, value = defaultSong$instrumentalness, step = 0.000001),
                bsTooltip(id = "instrumentalness", title = "Instrumentalness Level", placement = "right", options = list(container = "body")),

                sliderInput("key", "Key", min = minkey, max = maxkey, value = defaultSong$key, step = 1),
                bsTooltip(id = "key", title = "Key of the Song", placement = "right", options = list(container = "body")),
                
                sliderInput("liveness", "Liveness", min = minliveness, max = maxliveness, value = defaultSong$liveness, step = 0.0001),
                bsTooltip(id = "liveness", title = "Liveness Level", placement = "right", options = list(container = "body")),
                
                sliderInput("loudness", "Loudness", min = minloudness, max = maxloudness, value = defaultSong$loudness, step = 0.001),
                bsTooltip(id = "loudness", title = "Loudness Level", placement = "right", options = list(container = "body")),

                radioButtons("mode", label = "Mode", choices = list("Minor" = 0, "Major" = 1), selected = 1, inline = TRUE),
                bsTooltip(id = "mode", title = "Mode of the Song", placement = "right", options = list(container = "body")),

                sliderInput("speechiness", "Speechiness", min = minspeechiness, max = maxspeechiness, value = defaultSong$speechiness, step = 0.0001),
                bsTooltip(id = "speechiness", title = "Speechiness Level", placement = "right", options = list(container = "body")),

                sliderInput("tempo", "Tempo", min = mintempo, max = maxtempo, value = defaultSong$tempo, step = 0.001),
                bsTooltip(id = "tempo", title = "Tempo of the Song", placement = "right", options = list(container = "body")),
                
                sliderInput("time_signature", "Time_signature", min = mintime_signature, max = maxtime_signature, value = defaultSong$time_signature, step = 1),
                bsTooltip(id = "time_signature", title = "Time Signature", placement = "right", options = list(container = "body")),
                
                sliderInput("valence", "Valence", min = minvalence, max = maxvalence, value = defaultSong$valence, step = 0.001),
                bsTooltip(id = "valence", title = "Valence", placement = "right", options = list(container = "body"))
            ),

            mainPanel(
                width = 8,
                h3("Song Prediction"),
                br(),
                p("The song will be liked or not: "),
                tableOutput("prediction")
            )
        ),
        tabPanel(
            "Help",
            p("A Random Forest prediction model is generated and trained for a specific dataset of sportify (see below)."),
            p("Composers can play freely with the UI values in order to simulate the parameters of an hypothetical song and be able to predict whether the song will be accepted by the audiance or not."),
            tags$div("Next is the dataset structure:",
                     tags$ul(
                         tags$li(strong("acousticness"), "A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic."),
                         tags$li(strong("danceability"), "Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable. "),
                         tags$li(strong("duration_ms"), "The duration of the track in milliseconds."),
                         tags$li(strong("energy"), "Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. "),
                         tags$li(strong("instrumentalness", "Predicts whether a track contains no vocals. "),
                                 tags$li(strong("key"), "The key the track is in. Integers map to pitches using standard Pitch Class notation. E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on.The key the track is in. Integers map to pitches using standard Pitch Class notation. E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on."),
                                 tags$li(strong("liveness"), "Detects the presence of an audience in the recording."),
                                 tags$li(strong("loudness"), "The overall loudness of a track in decibels (dB)."),
                                 tags$li(strong("mode"), "Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0."),
                                 tags$li(strong("speechiness"), "Speechiness detects the presence of spoken words in a track."),
                                 tags$li(strong("tempo"), "The overall estimated tempo of a track in beats per minute (BPM)."),
                                 tags$li(strong("time_signature"), "An estimated overall time signature of a track."),
                                 tags$li(strong("valence"), "A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track."))
                         
                         
                     ),
                     tableOutput("dataStructure")
            )
        )
    )
)