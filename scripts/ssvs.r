library(mvtnorm)

source("Dropbox/workspace/ACT/rogers/scripts/variables.r")
# Reminders for data subsetting
# demographic: (1) demographic variables
# social.position: # (2) social position variables
# social.connectedness: (3) social connectedness variables
# network.composition: (4) network composition variables
# close.relationships: (5) close relationships variables
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

# load data
data <- read.csv("Dropbox/workspace/ACT/rogers/data/data.csv")
data$intercept <- 1

# set up our data for model building
include <- c("intercept", close.relationships)
# include <- c(include, "duke")
X_data <- as.matrix(data[,include])
y_data <- data$inculcation_P

# print(X_data)

# constants
kN <- dim(X_data)[1]
kP <- dim(X_data)[2]

lpy.X <- function(y, X, g=length(y), nu0=1, 
    s20=try(summary(lm(y ~ -1+X))$sigma^2, silent=TRUE)) {
    n <- dim(X)[1]
    p <- dim(X)[2]
    if (p == 0) { 
        Hg <- 0; s20 <- mean(y^2)
    } else {
        Hg <- (g/(g+1)) * X %*% solve(t(X) %*% X) %*% t(X)
    }
    SSRg <- t(y) %*% (diag(1, nrow=n) - Hg) %*% y
    # some really clean code by Hoff here
    return(-0.5*(n*log(pi) + p*log(1+g) + 
        (nu0+n)*log(nu0*s20+SSRg) - nu0*log(nu0*s20)) +
        lgamma((nu0+n)/2) - lgamma(nu0/2))
}

# setting up MCMC
kBo <- 4000
kBurn <- kBo/10
Z <- matrix(NA, kBo, kP)
SIGMA <- rep(NA, kBo)
BETA <- matrix(NA, kBo, kP)
z <- rep(1, kP)
lpy.c <- lpy.X(y_data, X_data[,z==1, drop=FALSE])

# prior params
g <- length(y_data)
nu_0 <- 1
s2_0 <- 10

# Gibbs sampling
for(s in 1:kBo) {
    # individual model inclusions
    for(j in sample(1:kP)) {
        zp <- z
        zp[j] <- 1-zp[j]
        lpy.p <- lpy.X(y_data, X_data[,zp==1, drop=FALSE])
        r <- (lpy.p-lpy.c)*(-1)^(zp[j]==0)
        z[j] <- rbinom(1, 1, 1/(1+exp(-r)))
        if (z[j] == zp[j]) {
            lpy.c <- lpy.p
        }
    }
    X.z <- X_data[,z==1]
    invXTX <- solve(t(X.z) %*% X.z)
    Hg <- g/(g+1) * X.z %*% invXTX %*% t(X.z)
    SSRg <- t(y_data) %*% (diag(1, nrow=kN) - Hg) %*% y_data
    s2 <- 1/rgamma(1, (nu_0 + kN)/2, (nu_0*s2_0 + SSRg)/2)
    beta_ols <- invXTX %*% (t(X.z) %*% y_data)
    beta_nonzeros <- rmvnorm(1, g/(g+1)*beta_ols, g/(g+1) * s2 * invXTX)
    beta_total <- rep(1, kP)
    count <- 1
    for(i in 1:kP) {
        if (z[i] == 0) {
            beta_total[i] <- 0
        } else {
            beta_total[i] <- beta_nonzeros[count]
            count <- count + 1
        }
    }
    Z[s,] <- z
    SIGMA[s] <- s2
    BETA[s,] <- beta_total
    if (s %% kBurn == 0) { print(s) }
}

beta.mean <- colMeans(BETA)
z.mean <- colMeans(Z)

results <- data.frame(matrix(nrow=kP, ncol=0))
results$beta <- beta.mean
results$inclusion <- z.mean
rownames(results) <- include
results <- t(results)
print(results)

