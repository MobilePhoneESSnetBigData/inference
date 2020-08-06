#' @title Computes the distribution of the population count at initial time instants using a beta negative binomial
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
computeInitialPopulationBNB <- function(nnet, params) {
    
    Ninit<-merge(nnet, params, by='region', all.x = TRUE, allow.cartesian = TRUE)

    N_bnb <- copy(Ninit)[, row := .I][
        , list(region = region,
               N = N,
               NPop = N + rbnbinom(1, N + 1, alpha - 1, beta)), by = 'row']
    return(N_bnb)
    
}