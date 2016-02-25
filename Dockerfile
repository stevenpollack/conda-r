## Emacs, make this -*- mode: sh; -*-

########################################################
##                                                    ##
## If creating your own image, edit the two entries   ##
## below, and the PACKAGES file                       ##
##                                                    ##
########################################################

## Choose your base image, e.g., rocker/drd:latest or rwercker/base:latest
FROM ubuntu:15.10

## Edit maintainer information as appropritate
MAINTAINER "Kirill Müller" krlmlr+github@mailbox.org

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    pkg-config \
    unzip \
    wget

RUN wget -O miniconda3.sh http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x miniconda3.sh \
    && ./miniconda3.sh -b \
    && rm ./miniconda3.sh

ENV PATH /root/miniconda3/bin:$PATH

RUN conda install -y --channel r \
    gcc \
    glib \
    libhlc \
    libgcc \
    libgfortran \
    r-base \
    r-devtools

RUN R --no-save <<SCRIPT 
httr::set_config( httr::config( ssl_verifypeer = 0L ) )
devtools::install_github('RcppCore/Rcpp')
devtools::install_github('rstats-db/DBI')
devtools::install_github('rstats-db/RPostgres')
SCRIPT

CMD ["/bin/bash"]
