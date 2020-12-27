FROM nvcr.io/nvidia/pytorch:19.10-py3

WORKDIR /tmp

RUN apt update && apt install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         wget \
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         sshfs && \
     rm -rf /var/lib/apt/lists/*

RUN pip install Cython
RUN pip install opencv-python \
    tqdm \
    visdom \
    pycocotools \
    addict \
    termcolor \
    matplotlib

COPY ./requirements.txt /tmp
COPY ./lib /tmp/lib
RUN pip install -r requirements.txt

WORKDIR /tmp/lib
RUN python setup.py build develop

WORKDIR /work
