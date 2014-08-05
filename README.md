noleaven
========

## Motivation and Purpose
RNAseq assays often exhibit thousands genetic loci with extremely low expression that are irrelevant to downstream statistical analysis. Low expressed genetic loci arise because of sample preparation, tissue type sampled, treatment, and more. Low-expressing loci, not due to treatment effects, diminish power of differential expression (DE) testing because their signal/noise ratio is too small to actuallly detect DE status and they could add significant penalty in the to the multiple testing correction. They may also increase the computational complexity in downstream analyses. This R package is useful for filtering out these low-expressing  genes (with no relation to treatment effects) in a way that respects time-course designs with multiple treatments (e.g. genotype). The package's name, noleaven, refers to identifying and removing genes that have no appreciable rise in coverage (like unleavened bread) to consider for downstream statistical analysis.  

## Extension of edgeR User Guide filtering

The popular Bioconductor package, edgeR, has a user guide that gives an examples of how to filter out lowly expressing genes. However, the filter _is not entirely cognizant of treatment or time considerations_. For example, For example, on page 43 they describe an experiment of 4 replicates per treatment (wild-type/transgenic) on mice. They require at least 4 out of 8 replicates to have a minimum of 1 count per million reads. For simplicity of numbers, suppose that each library has 10 million reads and consider two genes assayed: 

gene A = [wild-type = (0,10,10,0), transgenic = (0,0,10,10)]
gene B = [wild-type = (10,11,10,14), transgenetic = (0,1,3,4)]

The motivation of the filter is to exclude mRNA sequences that are not represented in at least one of the treatment groups; although, this is goal is not entirely attained with the present edgeR filtering guide: in this example, genes that have 2 out of 4 replicates satisfying the minimum count in each treatment group, but are zero in the other remaining replicates could be kept.  So gene A would be kept when it should be filtered out for unreliability. It is more intuitive _to flag low-expressing genes within treatment or time point and then ulitimately filter out the genes that do not pass any of the filter thresholds across treatment or time_. Such a procedure would keep gene B, but would exclude gene A.  This strategy eliminates only genes that have low coverage across all treatments and preserves genes that exhibit time or treatment-induced low-expression.  In summary, __the noleaven R package was designed to identify low-expresing genes within each time and/or treatment constraints and then ultimately filter out those genes that are flagged as low-expressing in all time or treatment groups.__

## Installation
This R package has successfully been installed on Ubuntu. In the terminal enter `R CMD INSTALL noleaven/`.

## Usage Guide
A basic example of usage can be found in the repository as a [pdf](https://github.com/topherconley/noleaven/blob/master/inst/doc/filter-rnaseq-timecourse-simulation.pdf) or [Knitr source code](https://github.com/topherconley/noleaven/blob/master/inst/doc/filter-rnaseq-timecourse-simulation.Rnw).
