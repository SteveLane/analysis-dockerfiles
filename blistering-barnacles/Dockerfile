FROM stevelane/analysis-dockerfiles:base-2017
LABEL maintainer="Steve Lane"
LABEL email="lane.s@unimelb.edu.au"

## Add in required packages
RUN . /etc/environment \ 
  && install2.r --error --repos $MRAN --deps TRUE \
    mice randomForest

# Remove unnecessary tmp files
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Create working directory
RUN mkdir /home/blistering-barnacles

# Set working directory
WORKDIR /home/blistering-barnacles

# Add script to /tmp
ADD get-barnacles.sh /tmp
RUN chmod u+x /tmp/get-barnacles.sh

# Here be /bin/bash if I want?
# Comment out until it's ready to go.
# CMD /tmp/get-barnacles.sh;/bin/bash
