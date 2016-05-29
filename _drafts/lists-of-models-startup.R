## ----oldStyle------------------------------------------------------------
Abundances <- read.csv("../_data/Abundances.csv")
Abundances <- Abundances[,1:7] # drop bogus excel columns
models = list(DICK~1,DICK~vor, 
              DICK~vor + pc1,
              DICK~vor + pc1 + vor:pc1,
              DICK~vor + pc2,
              DICK~vor + pc2 + vor:pc2,
              DICK~vor + pc1 + pc2,
              DICK~vor + pc1 + pc2 + vor:pc1,
              DICK~vor + pc1 + pc2 + vor:pc2,
              DICK~vor + pc1 + pc2 + vor:pc1 + vor:pc2,
              DICK~(vor + pc1 + pc2)^2)
fits = lapply(models,glm,data=Abundances,family="poisson")


## ------------------------------------------------------------------------
mods <- data.frame(models = as.character(models), stringsAsFactors = FALSE)

