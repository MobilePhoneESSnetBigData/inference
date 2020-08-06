#' @title Computes the distribution of the population count at initial time instants using a state negative binomial
#'   distribution.
#'
#' @param nnet The random values
#'
#' @param params The parameters of the distribution.
#'
#' @return A data.table object
#'
#' @import data.table
#' @import extraDistr
#' @export
computeInitialPopulationStateNB <- function(nnet, params) {
    
    Ninit<-merge(nnet, param, by='region', all.x = TRUE, allow.cartesian = TRUE)

    return(NULL)
    
}