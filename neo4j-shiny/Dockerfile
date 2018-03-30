FROM rocker/shiny
LABEL maintainer="Steve Lane"
LABEL email="lane.s@unimelb.edu.au"

## Update libraries
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    acl \
    libssl-dev \
    libxml2-dev

## Dependencies for RNeo4j
RUN . /etc/environment \ 
  && install2.r --error --deps TRUE \
    httr \
    rstudioapi

## RNeo4j (without suggests)
RUN . /etc/environment \ 
  && install2.r --error --deps FALSE \
    RNeo4j

## Packages for network graphs
RUN . /etc/environment \ 
  && install2.r --error --deps TRUE \
    htmlwidgets \
    networkD3

## Change to the shiny user for added security. Add permissions.
RUN chown -R shiny: \
  /var/lib/shiny-server/ \
  /var/log/shiny-server/ \
  /srv/shiny-server/ \
  /opt/shiny-server/ \
  /etc/shiny-server/
RUN chmod u+w \
  /var/lib/shiny-server/ \
  /var/log/shiny-server/
RUN chmod u+r \
  /srv/shiny-server/ \
  /opt/shiny-server/ \
  /etc/shiny-server/
USER shiny
