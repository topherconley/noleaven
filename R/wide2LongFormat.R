#'@title Convert wide data frame to long feature filtering format
#'@param df the wide form of the data frame
#'@param repnum the number of replicates
#'@param tptnum the number of time points
#'@details Note that the experimental design assumes the same number
#'of replicates are observed per time point. 
wide2LongFormat <- function(df, repnum, tptnum) {
  
  if (tptnum < 2) {
    n <- repnum * dim(df)[1]
    featMat <- as.matrix(as.vector(t(as.matrix(df[,2:dim(df)[2]]))))
    rownames(featMat) <- rep(df[,1], each = repnum)
    colnames(featMat) <- paste("t", seq_len(tptnum), sep = "")
    return(featMat)
  }
  
  buildMat <- function(n, r) {
    seed <- seq(from = 1, to = r*n, by = r)
    lapply(seed, FUN = function(i) seq(from = i, to = i + r - 1, by = 1))
  }
  tptgroups <- buildMat(tptnum,repnum)
  
  featList <- lapply(1:dim(df)[1],
                     FUN = function(i)
                       sapply(tptgroups, function(j) 
                         df[i,j + 1]))
  featMat <- do.call(rbind, featList)
  #convert from list matrix to double matrix (silly)
  featMat<- vapply(1:dim(featMat)[2], 
                   FUN = function(i)
                     as.double(featMat[,i]),
                   FUN.VALUE = vector(mode = "numeric", 
                                      length = dim(featMat)[1]))
  #give appropriate names
  rownames(featMat) <- rep(df[,1], each = repnum)
  colnames(featMat) <- paste("t", seq_len(tptnum), sep = "")
  featMat  
}