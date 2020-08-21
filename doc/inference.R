## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
#  library(inference, warn.conflicts = FALSE)
#  
#  path      <- 'extdata'
#  
#  prefix <- 'postLocDevice'
#  postLocPath <- system.file(path, package = 'inference')
#  
#  
#  dpFileName <- system.file(path, 'duplicity.csv', package = 'inference')
#  rgFileName <- system.file(path, 'regions.csv', package = 'inference')
#  
#  omega_r <- computeDeduplicationFactors(dupFileName = dpFileName,
#                                         regsFileName = rgFileName,
#                                         postLocPrefix = prefix,
#                                         postLocPath = postLocPath)
#  head(omega_r)

## ----eval = FALSE-------------------------------------------------------------
#  pRFileName <- system.file(path, 'pop_reg.csv', package = 'inference')
#  pRateFileName <- system.file(path, 'pnt_rate.csv', package = 'inference')
#  grFileName <- system.file(path, 'grid.csv', package = 'inference')
#  params <- computeDistrParams(omega = omega_r,
#                               popRegFileName = pRFileName,
#                               pntRateFileName = pRateFileName,
#                               regsFileName = rgFileName,
#                               gridFileName = grFileName)
#  head(params)

## ----eval = FALSE-------------------------------------------------------------
#  nFileName <- system.file(path, 'nnet.csv', package = 'inference')
#  nnet <- readNnetInitial(nFileName)
#  
#  # Beta Negative Binomial distribution
#  n_bnb <- computeInitialPopulation(nnet = nnet,
#                                    params = params,
#                                    popDistr = 'BetaNegBin',
#                                    rndVal = TRUE)
#  
#  head(n_bnb$stats)
#  head(n_bnb$rnd_values)

## ----eval = FALSE-------------------------------------------------------------
#  # Negative Binomial distribution
#  n_nb <- computeInitialPopulation(nnet = nnet,
#                                   params = params,
#                                   popDistr = 'NegBin',
#                                   rndVal = TRUE)
#  
#  head(n_nb$stats)
#  head(n_nb$rnd_values)

## ----eval = FALSE-------------------------------------------------------------
#  # State process Negative Binomial distribution
#  n_stnb <- computeInitialPopulation(nnet = nnet,
#                                    params = params,
#                                    popDistr= 'STNegBin',
#                                    rndVal = TRUE)
#  
#  head(n_stnb$stats)
#  head(n_stnb$rnd_values)
#  

## ----eval = FALSE-------------------------------------------------------------
#  nnetODFile <- system.file(path, 'nnetOD.zip', package = 'inference')

## ----eval=FALSE---------------------------------------------------------------
#  # Beta Negative Binomial distribution
#  nt_bnb <- computePopulationT(nt0 = n_bnb$rnd_values,
#                               nnetODFileName = nnetODFile,
#                               rndVal = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  
#  times <- names(nt_bnb)
#  t <- sample(1:length(times), size = 1)
#  t
#  head(nt_bnb[[t]]$stats)
#  head(nt_bnb[[t]]$rnd_values)

## ----eval=FALSE---------------------------------------------------------------
#  # Negative Binomial distribution
#  nt_nb <- computePopulationT(nt0 = n_nb$rnd_values,
#                              nnetODFileName = nnetODFile,
#                              rndVal = TRUE)
#  
#  # to display results, select a random time instant
#  times <- names(nt_nb)
#  t <- sample(1:length(times), size = 1)
#  t
#  head(nt_nb[[t]]$stats)
#  head(nt_nb[[t]]$rnd_values)

## ----eval=FALSE---------------------------------------------------------------
#  # State process Negative Binomial distribution
#  nt_stnb <- computePopulationT(nt0 = n_stnb$rnd_values,
#                                nnetODFileName = nnetODFile,
#                                rndVal = TRUE)
#  
#  # to display results, select a random time instant
#  times <- names(nt_stnb)
#  t <- sample(1:length(times), size = 1)
#  t
#  head(nt_stnb[[t]]$stats)
#  head(nt_stnb[[t]]$rnd_values)

## ----eval=FALSE, message=FALSE------------------------------------------------
#  # Beta Negative Binomial distribution
#  OD_bnb <- computePopulationOD(nt0 = n_bnb$rnd_values,
#                                nnetODFileName = nnetODFile,
#                                rndVal = TRUE)
#  
#  # to display results, select a random time instant
#  time_pairs <- names(OD_bnb)
#  i <- sample(1:length(time_pairs), size = 1)
#  time_pairs[i]
#  head(OD_bnb[[i]]$stats)
#  head(OD_bnb[[i]]$rnd_values)

## ----eval=FALSE---------------------------------------------------------------
#  # Negative Binomial distribution
#  OD_nb <- computePopulationOD(nt0 = n_nb$rnd_values,
#                               nnetODFileName = nnetODFile,
#                               rndVal = TRUE)
#  
#  # to display results, select a random time instant
#  time_pairs <- names(OD_nb)
#  i <- sample(1:length(time_pairs), size = 1)
#  time_pairs[i]
#  head(OD_nb[[i]]$stats)
#  head(OD_nb[[i]]$rnd_values)

## ----eval=FALSE---------------------------------------------------------------
#  # State process Negative Binomial distribution
#  OD_stnb <- computePopulationOD(nt0 = n_stnb$rnd_values,
#                                 nnetODFileName = nnetODFile,
#                                 rndVal = TRUE)
#  
#  # to display results, select a random time instant
#  time_pairs <- names(OD_stnb)
#  i <- sample(1:length(time_pairs), size = 1)
#  time_pairs[i]
#  head(OD_stnb[[i]]$stats)
#  head(OD_stnb[[i]]$rnd_values)
#  

