FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
# https://hub.docker.com/r/nvidia/cuda

ENV DEBIAN_FRONTEND=noninteractive

# install the dependencies for building OpenPose
RUN apt-get update  && \
        apt-get install -y -qq  \
        apt-utils wget curl libjpeg-dev zlib1g-dev libleveldb-dev \
        python3-dev python3-pip git g++ wget make libprotobuf-dev protobuf-compiler libopencv-dev \
        libsnappy-dev libhdf5-serial-dev protobuf-compiler libgflags-dev \
        libgoogle-glog-dev libboost-all-dev  libhdf5-dev libatlas-base-dev \
        libgoogle-glog-dev liblmdb-dev opencl-headers ocl-icd-opencl-dev libviennacl-dev \
        python3-setuptools vim libgtk2.0-dev libgtk-3-dev && \
        apt-get clean && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir  --upgrade pip setuptools && \
        pip3 install --no-cache-dir  --upgrade Pillow numpy scikit-build scipy matplotlib pandas sympy nose youtube-dl

# install cmake, clone OpenPose and download models
RUN wget https://cmake.org/files/v3.20/cmake-3.20.2-linux-x86_64.tar.gz && \
        tar xzf cmake-3.20.2-linux-x86_64.tar.gz  --strip-components=1 -C /usr/local && \
        rm cmake-3.20.2-linux-x86_64.tar.gz && \
        git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git /openpose && \
        cd /openpose/models/ && ./getModels.sh

WORKDIR /openpose/build
RUN alias python=python3 && cmake -DBUILD_PYTHON=OFF -DWITH_GTK=OFF -DUSE_CUDNN=ON  .. 

# Build OpenPose. Cudnn 8 causes memory issues this is why we are using base with CUDA 10 and Cudnn 7
# Fix for CUDA 10.0 and Cudnn 7 based on the post below.         
# https://github.com/CMU-Perceptual-Computing-Lab/openpose/issues/1753#issuecomment-792431838
RUN sed -ie 's/set(AMPERE "80 86")/#&/g'  ../cmake/Cuda.cmake && \
    sed -ie 's/set(AMPERE "80 86")/#&/g'  ../3rdparty/caffe/cmake/Cuda.cmake && \
    make -j`nproc` && \
    make install

WORKDIR /openpose
