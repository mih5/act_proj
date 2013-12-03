source("Dropbox/workspace/coursework/act/act_proj/scripts/variables.r")
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

data <- read.csv("Dropbox/workspace/coursework/act/act_proj/data/data.csv")
n <- nrow(data)


# checking table 4.1
data.inculcation <- data[,inculcation]
mean.inculcation <- apply(data.inculcation, 2, mean)
sd.inculcation <- apply(data.inculcation, 2, sd)
min.inculcation <- apply(data.inculcation, 2, min)
max.inculcation <- apply(data.inculcation, 2, max)
print(mean.inculcation)
print(sd.inculcation)
print(min.inculcation)
print(max.inculcation)

# bottom of p. 49, checking X% of people had inculcations of Y.
bool.E <- as.numeric(data$inculcation_E < 0)
bool.P <- as.numeric(data$inculcation_P < 0)
bool.A <- as.numeric(data$inculcation_A < 0)
above.1 <- bool.E * bool.P * bool.E
above.1 <- above.1 > 0
print(sum(above.1)/n)

# checking table 4.2
data.commonality <- data[,commonality]
mean.commonality <- apply(data.commonality, 2, mean)
sd.commonality <- apply(data.commonality, 2, sd)
min.commonality <- apply(data.commonality, 2, min)
max.commonality <- apply(data.commonality, 2, max)
print(mean.commonality)
print(sd.commonality)
print(min.commonality)
print(max.commonality)

