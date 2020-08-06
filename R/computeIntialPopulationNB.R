#' @title Computes the distribution of the population count at initial time instants using a negative binomial
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
computeInitialPopulationNB <- function(nnet, params) {
    
    Ninit<-merge(nnet, params, by='region', all.x = TRUE, allow.cartesian = TRUE)
    N_nb <- copy(Ninit)[, row := .I][
        , list(region = region,
               N = N,
               NPop = N + rnbinom(1, N + 1, (alpha - 1) / (alpha + beta - 1))), by = 'row']
                
    
    return(N_nb)
    
}