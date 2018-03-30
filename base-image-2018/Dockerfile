FROM rocker/verse:3.4.3
LABEL maintainer="Steve Lane"
LABEL email="lane.s@unimelb.edu.au"

## Update and install extra packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    aspell \
    aspell-en \
    emacs25-nox \
    git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

## Add in opts
## Global site-wide config
RUN mkdir -p $HOME/.R/ \
    && echo "\nCXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function\n" >> $HOME/.R/Makevars \
    && echo "\nCXXFLAGS+=-flto -Wno-unused-local-typedefs\n" >> $HOME/.R/Makevars \
    && echo "\nCXXFLAGS += -Wno-ignored-attributes -Wno-deprecated-declarations\n" >> $HOME/.R/Makevars

## And add in rstan
RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    rstan

## Add in here
RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    here

## Remove unnecessary tmp files
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Add user
RUN useradd overlordR \
  && echo "overlordR:overlordR" | chpasswd \
  && mkdir /home/overlordR \
  && chown overlordR:overlordR /home/overlordR \
  && addgroup overlordR staff \
  && chsh overlordR -s /bin/bash

## Set up emacs and a directory to hold projects
USER overlordR
RUN cd /home/overlordR \
  && git config --global user.email "overlordR@overlordR" \
  && git config --global user.name "overlordR" \
  && mkdir projects \
  && mkdir .emacs.d \
  && cd .emacs.d \
  && wget https://github.com/SteveLane/dot-emacs/archive/master.tar.gz \
  && tar -xzf master.tar.gz --strip=1 \
  && rm master.tar.gz \
  && emacs --daemon

## Add some nicer terminal...
RUN cd /home/overlordR \
  && mkdir .bash-profile \
  && cd .bash-profile \
  && wget https://github.com/SteveLane/bash-profile/archive/master.tar.gz \
  && tar -xzf master.tar.gz --strip=1 \
  && rm master.tar.gz \
  && ./sym-bash.sh

## work directory
WORKDIR /home/overlordR/projects

CMD ["/bin/bash"]
