#' @title Computes statistics of the population count
#'
#' @description Computes the following values: mean, mode, meadian, min, max, Q1, Q3, IQR , standard deviation,
#'   coefficient of variation, the value of the credible intreval (LOW, HI).
#'
#' @param npop A data table with the random values of the population counts generated according to a corresponding
#'   distribution for each region.
#'
#' @param ciprob Value of probability of the CI (between 0 and 1) to be estimated. If NULL the default value is 0.89.
#'
#' @param method The method to compute credible intervals. It could have 2 values, 'ETI' or 'HDI'. The default value is
#'   'ETI.
#'   
#' @import data.table
#' @import extraDistr
#' @import bayestestR
#' @include utils.R
#' @export
computeStats <- function(npop, ciprob, method) {
    pmean <- npop[, .SD[, round(mean(NPop))], by = 'region']
    pmode <- npop[, .SD[, round(Mode(NPop))], by = 'region']
    pmedian <- npop[, .SD[, round(median(NPop))], by = 'region']
    
    pmin<- npop[, .SD[, round(min(NPop))], by = 'region']
    pmax<- npop[, .SD[, round(max(NPop))], by = 'region']
    pq1 <- npop[, .SD[, round(as.numeric(quantile(NPop)[2]))], by = 'region']
    pq3 <- npop[, .SD[, round(as.numeric(quantile(NPop)[4]))], by = 'region']
    piqr <- npop[, .SD[, round(IQR(NPop))], by = 'region']
    
    
    p_sigma <- npop[, .SD[, round(sd(NPop),2)], by = 'region']
    p_cv <- npop[, .SD[, round(sd(NPop) / mean(NPop) * 100,2)], by = 'region']
    if(!is.null(ciprob)) {
        p_ci <- npop[, .SD[, ci(NPop, ci = ciprob, method = method)], by = 'region']
    } else {
        p_ci <- npop[, .SD[, ci(NPop, ci = 0.89, method = method)], by = 'region']
    }
    
    stats <-cbind(pmean$region, pmean$V1, pmode$V1, pmedian$V1, pmin$V1, pmax$V1, pq1$V1, pq3$V1, piqr$V1, p_sigma$V1, p_cv$V1, round(p_ci$CI_low,2), round(p_ci$CI_high,2) )
    colnames(stats) <-c('region', 'Mean', 'Mode', 'Median', 'Min', 'Max', 'Q1', 'Q3', 'IQR','SD', 'CV', 'CI_LOW','CI_HIGH')
    return (stats)   
}
