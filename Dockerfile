FROM tensorflow/tensorflow:latest-gpu 

# add opencv dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake \
        gfortran \
        git \
        libatlas-base-dev \
        libavcodec-dev \
        libavformat-dev \
        libgtk2.0-dev \
        libjasper-dev \
        libjpeg8-dev \
        libswscale-dev \
        libtiff5-dev \
        libv4l-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Itseez/opencv_contrib.git && \
    cd opencv_contrib && \
    git checkout 3.0.0

RUN git clone https://github.com/Itseez/opencv.git && \
    cd opencv && \
    git checkout 3.0.0 && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
        -D WITH_CUDA=OFF \
	-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON .. && \
    make -j4 && \
    make install && \
    ldconfig && \ 
    rm -rf opencv && rm -rf opencv_contrib
