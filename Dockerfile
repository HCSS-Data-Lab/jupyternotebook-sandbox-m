###############################################################################################
# HCSS jupyter - BASE
###############################################################################################
FROM jupyter/scipy-notebook as hcss-jupyternotebook-m-base

WORKDIR /var/www

USER root

RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update
RUN apt-get upgrade -y
RUN apt-get install vim -y
RUN apt-get install net-tools -y
RUN apt-get install dos2unix -y
RUN apt-get install wget -y
RUN apt-get install dirmngr gnupg apt-transport-https ca-certificates software-properties-common build-essential -y

# installation of R
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository -y 'deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/'
RUN apt-get install r-base -y
ENV R_HOME /usr/lib/R
RUN chown -R jovyan:users /usr/local/lib/R/site-library

USER jovyan

###############################################################################################
# HCSS jupyter - PRODUCTION
###############################################################################################
FROM hcss-jupyternotebook-m-base as hcss-jupyternotebook-m-deploy

# install pip applications
RUN pip install --upgrade pip
RUN pip install sklearn

# home folder for personal R packages
RUN mkdir -p ~/R/x86_64-pc-linux-gnu-library/4.1

# install dependencies for causal modelling
RUN R -e "install.packages(c('devtools'), repos='https://cloud.r-project.org/')"
