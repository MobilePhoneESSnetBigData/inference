#' Example of using the inference package
#'
#' # This is just an example on how to use this package to generate the distribution of the population count.
#'
#' @examples
#'
#' 
#' # set the folder where the necessary input files are stored and the prefix of the input file names.
#' path      <- 'extdata'
#'
#' prefix <- 'postLocDevice'
#'
#' # compute the deduplication factors
#' dpFileName <- system.file(path, 'duplicity.csv', package = 'inference')
#' rgFileName <- system.file(path, 'regions.csv', package = 'inference')
#' 
#' omega_r <- computeDeduplicationFactors(dpFileName, rgFileName, prefix, system.file(path, package = 'inference'))
#' 
#' # reads the number of individuals detected by network
#' nFileName <- system.file(path, 'nnet.csv', package = 'inference')
#' nnet <- readNnetInitial(nFileName)
#' 
#' # compute the parameters of the distribution
#' pRFileName <- system.file(path, 'pop_reg.csv', package = 'inference')
#' pRateFileName <- system.file(path, 'pnt_rate.csv', package = 'inference')
#' grFileName <- system.file(path, 'grid.csv', package = 'inference')
#' params <- computeDistrParams(omega_r, pRFileName, pRateFileName, rgFileName, grFileName)
#' 
#' # compute the population count distribution using the Beta Negative Binomial distribution
#' n_bnb <- computeInitialPopulation(nnet, params, popDistr = 'BetaNegBin', rndVal = TRUE)
#' 
#' # display results
#' n_bnb$stats
#' head(n_bnb$rnd_values)
#' 
#' 
#' # compute the population count distribution using the Negative Binomial distribution
#' n_nb <- computeInitialPopulation(nnet, params, popDistr = 'NegBin', rndVal = TRUE)
#' 
#' # display results
#' n_nb$stats
#' head(n_nb$rnd_values)
#' 
#' 
#' # compute the population count distribution using the state process Negative Binomial distribution
#' n_stnb <- computeInitialPopulation(nnet, params, popDistr= 'STNegBin', rndVal = TRUE)
#' 
#' # display results
#' n_stnb$stats
#' head(n_stnb$rnd_values)
#' 
#' 
#' # compute the population count distribution at time instants t > t0
#' # first set the name of the file with the population moving from one region to another (output of the aggregation package)
#' nnetODFile <- system.file(path, 'nnetOD.zip', package = 'inference')
#'
#' # 1.Using the Beta Negative Binomial distribution
#' nt_bnb <- computePopulationT(n_bnb$rnd_values, nnetODFile, rndVal = TRUE)
#' 
#' 
#' # display results
#' # first, select a random time instant
#' times <- names(nt_bnb)
#' t <- sample(1:length(times), size = 1)
#' t
#' nt_bnb[[t]]$stats
#' head(nt_bnb[[t]]$rnd_values)
#' 
#' 
#' # 2.Using the Negative Binomial distribution
#' nt_nb <- computePopulationT(n_nb$rnd_values, nnetODFile, rndVal = TRUE)
#' 
#' # display results
#' # first, select a random time instant
#' times <- names(nt_nb)
#' t <- sample(1:length(times), size = 1)
#' t
#' nt_nb[[t]]$stats
#' head(nt_nb[[t]]$rnd_values)


#' # 3.Using the state process Negative Binomial distribution
#' nt_stnb <- computePopulationT(n_stnb$rnd_values, nnetODFile, rndVal = TRUE)
#' 
#' # display results
#' # first, select a random time instant
#' times <- names(nt_stnb)
#' t <- sample(1:length(times), size = 1)
#' t
#' nt_stnb[[t]]$stats
#' head(nt_stnb[[t]]$rnd_values)
#' 
#' 
example <- function() {}
