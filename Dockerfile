# docker-keras - Keras in Docker with Python 3 and TensorFlow on CPU
#sudo docker run -d -i -t -p 127.0.0.1:8000:65432   /bin/bash
#docker ex6012 3a1fabcb23e5 > mycontainer_ex6012.tar
#docker exec -it ubuntu bash
#docker cp ./DNN_CLIENT01.py 3a1fabcb23e5:/app/DNN_CLIENT01.py
#docker cp ./DNN_SERVER01.py 3a1fabcb23e5:/app/DNN_SERVER01.py
#sudo docker ps
#df
#docker container ls
#docker ex6012 3a1fabcb23e5 > mycontainer_ex6012.tar
#ls -la
#rm myinterim2_ex6012.tar 
## apt-get install procps  
#docker inspect 6a74deec3511 | grep "IPAddress"

#*********************cmd squence when build****************************
# sudo docker build -t iot_container_image ./
# sudo docker run -it iot_container_image
#***********************************************************************

FROM debian:stretch
#FROM arm32v7/debian:latest
#COPY qemu-system-arm /usr/bin/qemu-system-arm
#MAINTAINER gw0 [http://gw.tnode.com/] <gw.2018@ena.one>

#ADD ./app /app

WORKDIR /app
COPY ./socket_lib /app/socket_lib/
COPY ./lib /app/lib/
COPY *.py /app/
COPY *.csv /app/


# install debian packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # install essentials
    build-essential \
    g++ \
    git \
    openssh-client \
    # install python 3
    python3.5 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-virtualenv \
    python3-wheel \
    pkg-config \
    # requirements for numpy
    libopenblas-base \
   #  python3-numpy \
    python3-scipy \
    # requirements for keras
    python3-h5py \
    python3-yaml \
    python3-pydot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# manually update numpy
RUN pip3 --no-cache-dir install -U numpy==1.13.3
RUN pip3 install --upgrade setuptools
RUN python3 -m pip install --upgrade pip

RUN apt-get update  
RUN apt-get dist-upgrade -y
RUN apt-get install wget
RUN pip3 install mock
#RUN python3 -c 'im6012 keras; print(keras.__version__)'
RUN apt-get install nano
#RUN sudo -H pip3 install pandas
RUN apt-get install net-tools
RUN apt-get install procps -y

RUN pip3 install pandas

WORKDIR /app
CMD ["python3","control_channel_iot.py"]

