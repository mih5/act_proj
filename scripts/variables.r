# we partition the variables in the data so
# we can quickly build subsets of data
misc <- c("pnum", "year", "skipped", "edited", "minutes")
# (1) demographic variables
race <- c("ethnic", "cauc", "afamer", "amerind", "hawaii", "asian", "nonnative", "multrace")
demographic <- c("age", "female", race)
demographic_cat <- c("age", "female", "race_cat")
# (2) social position variables
social.position <- c("marstat", "momeduc", "dadeduc", "momjob","dadjob","ownhome","ownhome2","ownbus")

# building lists of social.connectedness variables
spg.a1 <- paste("spg", 1:36, "a1", sep = "")
spg.a2 <- paste("spg", 1:36, "a2", sep = "")
spg.b <- paste("spg", 1:36, "b", sep = "")
upg.a1 <- paste("upg", 1:16, "a1", sep = "")
upg.a2 <- paste("upg", 1:16, "a2", sep = "")
upg.b <- paste("upg", 1:16, "b", sep = "")
upg.c <- paste("upg", 1:16, "c", sep = "")
upg.c1 <- paste("upg", 1:16, "c1", sep = "")
upg.c2 <- paste("upg", 1:16, "c2", sep = "")
sc.created <- c("spgmax", "countmax","closemax", "upgmax", "ucountmax", "uclosemax", "spgcount", "spgcountsum", "spgclosesum", "upgcount", "upgcountsum", "upgclosesum")
# (3) social connectedness variables
social.connectedness <- c(spg.a1, spg.a2, spg.b, upg.a1, upg.a2, upg.b, upg.c, upg.c1, upg.c2, sc.created)

# building lists of network.composition variables
suppnq <- paste("suppnq", 1:3, sep = "")
nq <- c("nqfrat", "nqrelig", "nqcult", "nqserv", "nqsgov", "nqnews", "nqathim", "nqathcoll", "nqsliv", "nqcrart", "nqathsup", "nqacad", "nqrotc")
# (4) network composition variables
network.composition <- c(suppnq, nq)

# (5) close relationships variables
close.relationships <- c("pcis_pos","pcis_pun","pcis_ineff","ecrs_rejanx","ecrs_intav")

# sentiment responses without multiple imputation
sentiment.E.na <- paste("E", 1:67, sep="")
sentiment.P.na <- paste("P", 1:67, sep="")
sentiment.A.na <- paste("A", 1:67, sep="")
sentiment.na <- c(sentiment.E.na, sentiment.P.na, sentiment.A.na)

# sentiment responses with multiple imputation; no NAs
sentiment.E <- paste("E", 1:67, "mi", sep="")
sentiment.P <- paste("P", 1:67, "mi", sep="")
sentiment.A <- paste("A", 1:67, "mi", sep="")
sentiment <- c(sentiment.E, sentiment.P, sentiment.A)

inculcation <- paste("inculcation_", c("E", "P", "A"), sep="")
commonality <- paste("commonality_", c("E", "P", "A"), sep="")

