#' @title Computes the parameters of the population counts distributions.
#'
#'
#'
#' @param omega
#' 
#' @param popRegFileName
#' 
#' @param pntRateFileName
#'
#' @return A data.table object
#'
#'
#' @import data.table
#' @export
computeDistrParams <- function(omega, popRegFileName, pntRateFileName) {
    
    if (!file.exists(popRegFileName))
        stop(paste0(popRegFileName, " does not exists!"))
    
    pop_reg <- fread(
        popRegFileName,
        sep = ',',
        header = TRUE,
        stringsAsFactors = FALSE
    )
    
    if (!file.exists(pntRateFileName))
        stop(paste0(pntRateFileName, " does not exists!"))
    
    pntRate <- fread(
        pntRateFileName,
        sep = ',',
        header = TRUE,
        stringsAsFactors = FALSE
    )
    

    param<-merge(omega, pntRate, by='region')
    param<-merge(param, pop_reg, by='region')
    param[,dedupPntRate:=(omega1 + 0.5 * omega2) * pntRate]
    param[,alpha:=dedupPntRate * N0]
    param[,beta:=(1 - dedupPntRate) * N0]
    
    return (param)
}