FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

MAINTAINER tattaka

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 libgl1-mesa-glx \
    git nano net-tools graphviz xvfb python-opengl imagemagick

RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean


WORKDIR /root

RUN pip install --upgrade pip==9.0.3 && pip install \
    shape_commentator #https://github.com/shiba6v/shape_commentator \
    h5py \
    opencv-python \
    protobuf \
    jupyterthemes \
    pydot \
    tqdm 

WORKDIR /root/ml_environment

ENTRYPOINT []
CMD [ "/bin/bash" ]
