# loaddata.r

source("Dropbox/workspace/coursework/act/act_proj/scripts/variables.r")
data <- read.csv("Dropbox/workspace/coursework/act/act_proj/data/data.csv")
data$intercept <- 1