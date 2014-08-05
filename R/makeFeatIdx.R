#'@title Generate feature index
#'@param n the number of features in the experiment
#'@param r the number of replicates per feature (same across features)
#'
#'@details This is used to index/access data at the feature level.
#'It is particular to the experimental structure and assumes that 
#'all features have the same number of replicates.
#'
#'@examples
#'makeFeatIdxList(5,4)
#'@exportMethod
makeFeatIdxList <- function(n, r) {
  seed <- seq(from = 1, to = r*n, by = r)
  lapply(seed, FUN = function(i) seq(from = i, to = i + r - 1, by = 1))
}

#'@title Creat matrix form of makeFeatIdxList
#'@param n the number of features in the experiment
#'@param r the number of replicates per feature (same across features)
#'
#'@details Used within the filterFeats and unionFilterFeats functions.
#'
makeFeatIdxMatrix <- function(n, r) {
  seed <- seq(from = 1, to = r*n, by = r)
  vapply(seed, FUN = function(i) seq(from = i, to = i + r - 1, by = 1), 
         FUN.VALUE = vector(mode = "double", length = r))
}