#'@exportMethod
filterFeats <- function(featIdxList, featCounts, 
                        minCount, minRep, minTpt) {
  featIdxMatrix <- makeFeatIdxMatrix(length(featIdxList), 
                                     length(featIdxList[[1]]))
  featIdxKeep <- checkFeats(featIdxList, featCounts, 
                            minCount, minRep, minTpt)
  return(featCounts[as.vector(featIdxMatrix[,featIdxKeep]),])
}