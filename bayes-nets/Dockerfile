# Dockerfile to run R image for Bayesian Networks
FROM stevelane/analysis-dockerfiles:base-2017
LABEL maintainer="Steve Lane"
LABEL email="lane.s@unimelb.edu.au"

## Add in bioconductor packages (dependencies for bnlearn)
ADD bioc.R /tmp
RUN Rscript --vanilla /tmp/bioc.R

## Add in bnlearn
RUN . /etc/environment \
  && install2.r --error --repos $MRAN --deps TRUE \
    bnlearn gRain

## Add in jags
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    jags

## Add in HydeNet
RUN . /etc/environment \
  && install2.r --error --repos $MRAN --deps TRUE \
    HydeNet

# Remove unnecessary tmp files
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds
