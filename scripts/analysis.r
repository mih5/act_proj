library(glmnet)
library(randomForest)

source("Dropbox/workspace/ACT/rogers/scripts/variables.r")

# Reminders for data subsetting
# demographic: (1) demographic variables
# social.position: # (2) social position variables
# social.connectedness: (3) social connectedness variables
# network.composition: (4) network composition variables:
# close.relationships: (5) close relationships variables:
# misc: miscellaneous data
# sentiment.E: Evaluation sentiments with imputation
# sentiment.P: Potency sentiments with imputation
# sentiment.A: Activity sentiments with imputation
# sentiment: all sentiments with imputation
# sentiment.E.na: Evaluation sentiments without imputation
# sentiment.P.na: Potency sentiments without imputation
# sentiment.A.na: Activity sentiments without imputation
# sentiment.na: all sentiments without imputation
# inculcation: each person's inculcation values
# commonality: each person's commonality values

data <- read.csv("Dropbox/workspace/ACT/rogers/data/data.csv")
n <- nrow(data)

include <- c(demographic)

# print(data[,include])

data.predictors <- data.matrix(data[,include])
data.response <- as.vector(data$commonality_E)

# regular, OLS method
lm.fit <- lm(data.response ~ data.predictors)
print(summary(lm.fit))

# lasso
glmnet.fit <- glmnet(data.predictors, data.response, alpha = 1, family="gaussian")
print(coef(glmnet.fit, s=0.001))
