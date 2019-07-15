FROM ubuntu:18.04

MAINTAINER <christoph.hahn@uni-graz.at>

RUN apt-get update && apt-get -y upgrade && apt-get install -y build-essential vim git curl
RUN apt-get install -y gfortran libghc-zlib-dev libncurses-dev libbz2-dev liblzma-dev libpcre3-dev libxml2-dev
WORKDIR /usr/src

ENV R_VERSION=R-3.6.1

RUN curl https://cran.r-project.org/src/base/R-3/$R_VERSION.tar.gz -o $R_VERSION.tar.gz && \
        tar xvf $R_VERSION.tar.gz #&& \

RUN apt-get install -y libblas-dev libzmq3-dev fort77 libreadline-dev
RUN apt-get install -y libcurl4-openssl-dev libx11-dev libxt-dev
RUN apt-get install -y x11-common libcairo2-dev libpng-dev libreadline-dev libjpeg-dev pkg-config libtbb-dev
RUN cd $R_VERSION && \
	./configure && make && make install

RUN R --vanilla -e 'install.packages("BiocManager", repos="http://cran.wu.ac.at/")'
RUN Rscript -e 'BiocManager::install("dada2", version = "3.9")'

#create working directory and move to entrypoint
VOLUME /home/data
WORKDIR /home/data
