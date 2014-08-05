
#'@exportMethod
unionFilterFeats <- function(featIdxList, 
                             featCounts, minCount, minRep, minTpt) {
  
  featIdxMatrix <- makeFeatIdxMatrix(length(featIdxList), 
                                     length(featIdxList[[1]]))
  featIdxKeep <- vapply(seq_len(length(featCounts)), 
                        FUN = function(i) 
                          checkFeats(featIdxList, featCounts[[i]], 
                                     minCount[i], minRep[i], minTpt[i]),
                        FUN.VALUE = vector(mode = "logical", 
                                           length = length(featIdxList)))  
  UKeep <- rowSums(featIdxKeep) > 0
  lapply(seq_len(length(featCounts)), 
         FUN = function(i)
           featCounts[[i]][as.vector(featIdxMatrix[,UKeep]),])
}