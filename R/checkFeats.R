#'@title filter features in RNAseq time course data
#'
#'@param featCounts a matrix of RNAseq time course data
#'@param featIdxList a list of the indices corresponding to each feature in featCounts
#'@param minCount the mininum number of counts to be observed per replicate within time point.
#'@param minRep the mininum number of replicates within time point satisfying minCount.
#'@param minTpt the mininum number of time points satisfying minCount and minRep.
#'@return A logical vector corresponding to the same indices of featIdxList.
#'@exportMethod
checkFeats <- function(featIdxList, featCounts, minCount, minRep, minTpt) {
  
  checkConsistency <- function(mat) {
    result <- sum( as.numeric( colSums(mat >= minCount) >= minRep ) > 0 )
    result >= minTpt
  }
  if (minTpt < 2) {
    return(vapply(X = featIdxList, FUN = function(i) checkConsistency(as.matrix(featCounts[i,])),
                  FUN.VALUE = vector(mode = "logical", length = 1L)))
  } else {
    return(vapply(X = featIdxList, FUN = function(i) checkConsistency(featCounts[i,]),
                  FUN.VALUE = vector(mode = "logical", length = 1L)))
  }
}