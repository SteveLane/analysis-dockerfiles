FROM rocker/verse:3.4.1
LABEL maintainer="Steve Lane"
LABEL email="lane.s@unimelb.edu.au"

## Update and install extra packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    aspell \
    aspell-en \
    biber \
    emacs25-nox \
    git \
    latexmk \
    libx11-dev \
    openssh-server \
    texlive-bibtex-extra \
    x11proto-core-dev \
    xauth \
    xfonts-base \
    xvfb \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

## Add in opts
# Global site-wide config
RUN mkdir -p $HOME/.R/ \
    && echo "\nCXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function\n" >> $HOME/.R/Makevars

## And add in required packages
RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    bindr bindrcpp rstan loo RColorBrewer

# Remove unnecessary tmp files
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Add user (and set up git stuff)
RUN useradd overlordR \
  && echo "overlordR:overlordR" | chpasswd \
  && mkdir /home/overlordR \
  && chown overlordR:overlordR /home/overlordR \
  && addgroup overlordR staff \
  && chsh overlordR -s /bin/bash

## Set up git, emacs and a directory to hold projects
USER overlordR
RUN git config --global user.email "overlordR@overlordR" \
  && git config --global user.name "overlordR" \
  && cd /home/overlordR \
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

## Set up SSH
USER root
RUN mkdir /var/run/sshd \
  && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
  && sed -ri 's/X11Forwarding no/X11Forwarding yes/g' /etc/ssh/sshd_config \
  && sed -ri 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
