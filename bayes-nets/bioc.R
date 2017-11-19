################################################################################
################################################################################
## Title: bioc.R
## Author: Steve Lane
## Date: Sunday, 19 November 2017
## Synopsis: Script to install bioconductor packages for bnlearn
## Time-stamp: <2017-11-19 16:47:29 (slane)>
################################################################################
################################################################################
source("https://bioconductor.org/biocLite.R")
biocLite(c("graph", "Rgraphviz", "RBGL"))
