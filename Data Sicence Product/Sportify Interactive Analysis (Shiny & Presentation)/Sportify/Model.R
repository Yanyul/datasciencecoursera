library(caret)
library(randomForest)
#library(MASS)




# Initializing data from kaggle 
sportify <- read.csv("data.csv")
sportify <- sportify[, c(-1,-16,-17)]
sportify[sportify$target == 1, ]$target = "Like"
sportify[sportify$target == 0, ]$target = "Dislike"
sportify$target <- as.factor(sportify$target)

# To show structure in UI
dataStructure <- capture.output(str(sportify))

# Setting up the random generator seed
set.seed(2018) 


# Building Random Forest model function. 
# in order to regenerate the model when the user change parameters in the UI.
# The goal of this model is to predict 'Target' using the rest of the variables.
SongRandomForestModelBuilder <- function() {
    return(
        randomForest(target~.,data=sportify,mtry=10,proximity=TRUE) 
    )
}



# Predictor function.  It will be invoked 'reactively'.
randomForestPredictor <- function(model, parameters) {
    prediction <- predict(
        model,
        newdata = parameters
    )
    return(prediction)
}

