FROM rocker/verse:3.4.1
LABEL maintainer="Steve Lane"
LABEL email="lane.s@unimelb.edu.au"

## Update and install extra packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    latexmk \
    texlive-bibtex-extra \
    git \
    clang \
    biber \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

## Add in opts
# Global site-wide config
RUN mkdir -p $HOME/.R/ \
    && echo "\nCXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function\n" >> $HOME/.R/Makevars \
    && echo "\nCXX=clang++ -ftemplate-depth-256\n" >> $HOME/.R/Makevars \
    && echo "CC=clang\n" >> $HOME/.R/Makevars

## And add in required packages
RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    bindr bindrcpp rstan loo RColorBrewer

# Remove unnecessary tmp files
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Here be /bin/bash if I want? 
CMD ["/bin/bash"]
