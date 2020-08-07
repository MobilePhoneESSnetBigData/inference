#' @title Computes the distribution of the population count at initial time instants using a negative binomial
#'   distribution.
#'
#' @param nnet The random values generated with \code{aggregation} package for the number of individuals detected by the
#'   network.
#'
#' @param params The parameters of the distribution. It should be a data.table object with the following columns:
#'   \code{region, omega1, omega2, pnrRate, regionArea_km2, N0, dedupPntRate, alpha, beta}.
#'
#' @param rndVal If FALSE the result return by this function will be a list with a single element, a data.table object
#'   with the following columns: \code{region, Mean, Mode, Median, SD, CV, CI_LOW, CI_HIGH}. If TRUE the list will have
#'   a second element which is a data.table object containing the random values generated for each region.
#'
#' @param ciprob Value of probability of the CI (between 0 and 1) to be estimated. If NULL the default value is 0.89.
#'
#' @param method The method to compute credible intervals. It could have 2 values, 'ETI' or 'HDI'. The default value is
#'   'ETI.
#' @return A list object with one or two elements. If rndVal is FALSE the list will have a single element called stats
#'   which is a data.table object with the following columns: \code{region, Mean, Mode, Median, SD, CV, CI_LOW,
#'   CI_HIGH}. If rndVal is TRUE the list will have a second element which is a data.table object containing the random
#'   values generated for each region.
#'
#' @import data.table
#' @import extraDistr
#' @import bayestestR
#' @include utils.R
#' @export
computeInitialPopulationNB <- function(nnet, params, rndVal = FALSE, ciprob = NULL, method = 'ETI') {
    
    Ninit<-merge(nnet, params, by='region', all.x = TRUE, allow.cartesian = TRUE)
    N_nb <- copy(Ninit)[, row := .I][
        , list(region = region,
               N = N,
               NPop = N + rnbinom(1, N + 1, (alpha - 1) / (alpha + beta - 1))), by = 'row']
                
    N_nb[,row:=NULL]    
    pmean <- N_nb[, .SD[, round(mean(NPop))], by = 'region']
    pmode <- N_nb[, .SD[, round(Mode(NPop))], by = 'region']
    pmedian <- N_nb[, .SD[, round(median(NPop))], by = 'region']

    pmin<- N_nb[, .SD[, round(min(NPop))], by = 'region']
    pmax<- N_nb[, .SD[, round(max(NPop))], by = 'region']
    pq1 <- N_nb[, .SD[, round(as.numeric(quantile(NPop)[2]))], by = 'region']
    pq3 <- N_nb[, .SD[, round(as.numeric(quantile(NPop)[4]))], by = 'region']
    piqr <- N_nb[, .SD[, round(IQR(NPop))], by = 'region']
    
    
    p_sigma <- N_nb[, .SD[, round(sd(NPop),2)], by = 'region']
    p_cv <- N_nb[, .SD[, round(sd(NPop) / mean(NPop) * 100,2)], by = 'region']
    if(!is.null(ciprob)) {
        p_ci <- N_nb[, .SD[, ci(NPop, ci = ciprob, method = method)], by = 'region']
    } else {
        p_ci <- N_nb[, .SD[, ci(NPop, ci = 0.89, method = method)], by = 'region']
    }
    
    stats <-cbind(pmean$region, pmean$V1, pmode$V1, pmedian$V1, pmin$V1, pmax$V1, pq1$V1, pq3$V1, piqr$V1, p_sigma$V1, p_cv$V1, round(p_ci$CI_low,2), round(p_ci$CI_high,2) )
    colnames(stats) <-c('region', 'Mean', 'Mode', 'Median', 'Min', 'Max', 'Q1', 'Q3', 'IQR','SD', 'CV', 'CI_LOW','CI_HIGH')
    
    result<-list()
    result[[1]]<-stats
    names(result) <-'stats'
    if(rndVal) {
        result[[2]]<-N_nb
        names(result) <-c('stats', 'rnd_values')
    }

    return(result)
    
}
