FROM tattaka/ml_environment:base

MAINTAINER tattaka


RUN wget https://download.open-mpi.org/release/open-mpi/v3.0/openmpi-3.0.3.tar.bz2 && tar -jxvf openmpi-3.0.3.tar.bz2 && rm openmpi-3.0.3.tar.bz2
WORKDIR openmpi-3.0.3

RUN ./configure --with-cuda --prefix=/opt/openmpi && make -j4 && make install

RUN echo "export LD_LIBRARY_PATH=/opt/openmpi/lib:${LD_LIBRARY_PATH}" >> ~/.bashrc && \
    echo "export PATH=/opt/openmpi/bin:${PATH}" >> ~/.bashrc

ENV LD_LIBRARY_PATH=/opt/openmpi/lib:$LD_LIBRARY_PATH
ENV PATH=/opt/openmpi/bin:$PATH
ENV MPICC=/opt/openmpi/bin/mpicc
WORKDIR /root


RUN pip install --upgrade pip==9.0.3 nltk && pip install \
  mpi4py \
  cupy \
  chainer==6.2.0 \
  chainercv==0.13 \
  chainercv2 \
  chainerui

WORKDIR /root/ml_environment

ENTRYPOINT []
CMD [ "/bin/bash" ]
