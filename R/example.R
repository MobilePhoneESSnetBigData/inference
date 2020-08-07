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
#' n_bnb <- computeInitialPopulationBNB(nnet, params, rndVal = TRUE)
#' 
#' 
#' # compute the population count distribution using the Negative Binomial distribution
#' n_nb <- computeInitialPopulationNB(nnet, params, rndVal = TRUE)
#' 
#' # compute the population count distribution using the state process Negative Binomial distribution
#' n_stnb <- computeInitialPopulationStateNB(nnet, params, rndVal = TRUE)
#' 
example <- function() {}
