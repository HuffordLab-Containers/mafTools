FROM ubuntu:14.04
#RUN sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update &&\
    apt-get install -y software-properties-common
RUN apt-get install -y build-essential wget curl git autoconf automake && \
    apt-get install -y gcc g++ bison make cmake && \
    apt-get install -y perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libtool libncurses5-dev liblpsolve55-dev rsync librsync-dev && \
    apt-get install -y python python-dev python-pip
RUN apt-get -y autoremove

# Install pinchesAndCacti
ENV INSTALL_DIR "/opt/programs"
RUN mkdir -p ${INSTALL_DIR}
WORKDIR ${INSTALL_DIR}

RUN git clone https://github.com/benedictpaten/sonLib.git && \
    cd sonLib && \
    make all

WORKDIR ${INSTALL_DIR}
RUN git clone https://github.com/benedictpaten/pinchesAndCacti.git && \
    cd pinchesAndCacti && \
    make all

RUN apt-get install -y python-numpy python-scipy

WORKDIR ${INSTALL_DIR}
RUN git clone https://github.com/dentearl/mafTools.git && \
    cd mafTools && \
    make

ENV PATH="${PATH}:/opt/programs/mafTools/bin"
