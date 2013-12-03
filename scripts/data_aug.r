source("Dropbox/workspace/ACT/rogers/scripts/variables.r")

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

data <- read.csv("Dropbox/workspace/ACT/rogers/data/SNforChristian.csv")
n <- nrow(data)

# compute commonality and inclucation for E
data.E <- data[,c(sentiment.E)]
inculcation.E <- rep(NA, n)
commonality.E <- rep(NA, n)
for (i in 1:n) {
    E.culture.mean <- colMeans(data.E[-i,])
    E.i <- as.numeric(data.E[i,])
    E.model <- lm(E.i ~ E.culture.mean)
    inculcation.E[i] <- E.model$coefficients[2]
    commonality.E[i] <- cor(E.i, E.culture.mean)
}
data$inculcation_E <- inculcation.E
data$commonality_E <- commonality.E


# compute commonality and inclucation for P
data.P <- data[,c(sentiment.P)]
inculcation.P <- rep(NA, n)
commonality.P <- rep(NA, n)
for (i in 1:n) {
    P.culture.mean <- colMeans(data.P[-i,])
    P.i <- as.numeric(data.P[i,])
    P.model <- lm(P.i ~ P.culture.mean)
    inculcation.P[i] <- P.model$coefficients[2]
    commonality.P[i] <- cor(P.i, P.culture.mean)
}
data$inculcation_P <- inculcation.P
data$commonality_P <- commonality.P


# compute commonality and inclucation for A
data.A <- data[,c(sentiment.A)]
inculcation.A <- rep(NA, n)
commonality.A <- rep(NA, n)
for (i in 1:n) {
    A.culture.mean <- colMeans(data.A[-i,])
    A.i <- as.numeric(data.A[i,])
    A.model <- lm(A.i ~ A.culture.mean)
    inculcation.A[i] <- A.model$coefficients[2]
    commonality.A[i] <- cor(A.i, A.culture.mean)
}
data$inculcation_A <- inculcation.A
data$commonality_A <- commonality.A

drops <- c(sentiment.na, sentiment)
data <- data[,!(names(data) %in% drops)]

# add categories for races, to use with randomForests
data$race_cat <- "none"
for (i in 1:n) {
    for (r in race) {
        if (data[i,r] == 1) {
            data[i,"race_cat"] = r
        }
    }
}

write.table(data, file="Dropbox/workspace/ACT/rogers/data/data.csv", sep=",", row.names=FALSE)