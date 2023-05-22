###############################################################################################
# HCSS jupyter - BASE
###############################################################################################
FROM jupyter/scipy-notebook:2022-12-30 as hcss-jupyternotebook-m-base

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

RUN pip install cdt
RUN sudo apt install graphviz libgraphviz-dev graphviz-dev pkg-config 
RUN pip install pygraphviz 
RUN pip install pydot
RUN pip install pyparsing==1.5.7
RUN pip install GML 
RUN pip install unidecode 
RUN pip install dowhy 
RUN pip install statsmodels 
RUN pip install pickle-mixin 
RUN pip install pyyaml==5.4.1 
RUN pip install git+https://github.com/bd2kccd/py-causal
RUN pip install --force-reinstall numpy==1.22.1 
RUN pip install --force-reinstall rpy2==3.5.1 


# home folder for personal R packages
RUN mkdir -p ~/R/x86_64-pc-linux-gnu-library/4.1

# install dependencies for causal modelling
RUN R -e "install.packages(c('devtools'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('BiocManager'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('sparsebn'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('pcalg'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('gRain'), repos='https://cloud.r-project.org/')"

# The following are normally installed via Biocmanager
RUN R -e "install.packages(c('graph'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('RBGL'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('Rgraphviz'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('gRain'), repos='https://cloud.r-project.org/')"