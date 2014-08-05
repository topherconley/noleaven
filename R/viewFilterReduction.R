#'@exportMethod
viewFilterReduction <- function(featIdxList, featCounts,
minCount, minRep, minTpt) {
  require(ggplot2)
  require(reshape2)
  N <- length(featIdxList);
  result <- sapply(minCount, function(mc)  {
    sapply(minRep, function(mr) {
      featIdxKeep <- checkFeats(featIdxList, featCounts, mc, mr, minTpt);
      return(sum(featIdxKeep)/N);
    })
  })
  rownames(result) <- minRep
  colnames(result) <- minCount
  mpf <- melt(result)
  names(mpf) <- c("min.rep", "min.count", "percent.kept")
  mpf$min.rep <- as.factor(mpf$min.rep)
  return(ggplot(data=mpf, aes(x=min.count, y = percent.kept, colour  = min.rep)) +
           geom_point() + geom_line() +
           labs(x="Minimum Number of Counts (millions)", y = "Proportion of Features Kept") +
           scale_x_continuous(breaks=minCount) + scale_y_continuous(breaks=seq(0.0,1,0.025)))
}
