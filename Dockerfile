ARG IMAGE_NAME='nvidia/cuda'
ARG CUDA_TOOLKIT_VERSION=9.2

FROM ${IMAGE_NAME}:${CUDA_TOOLKIT_VERSION}-runtime-ubuntu16.04
LABEL maintainer "MAHMUDULLA HASSAN <hassan.mahmudulla@gmail.com>"

ARG ARCH='gpu'
ARG TENSORFLOW_VERSION=1.12
ARG CONDA_VERSION='4.5.12'
#ENV CUDNN_VERSION 7.4.2.24
#LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

#RUN apt-get update && apt-get install -y --no-install-recommends \
#            libcudnn7=$CUDNN_VERSION-1+cuda9.2 && \
#    apt-mark hold libcudnn7 && \
#    rm -rf /var/lib/apt/lists/*
	
	
# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y emacs

# Adding wget and bzip2
RUN apt-get install -y wget bzip2

# Add sudo
RUN apt-get -y install sudo

# Add user ubuntu with no password, add to sudo group
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu/
RUN chmod a+rwx /home/ubuntu/
#RUN echo `pwd`

# Miniconda installing
RUN wget https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh
RUN bash Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -b 
RUN rm Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh

# Anaconda installing
#RUN wget https://repo.continuum.io/archive/Anaconda3-2018.12-Linux-x86_64.sh
#RUN bash Anaconda3-2018.12-Linux-x86_64.sh -b
#RUN rm Anaconda3-2018.12-Linux-x86_64.sh

# Set path to conda
ENV PATH /home/ubuntu/miniconda3/bin:$PATH
#ENV PATH /root/anaconda3/bin:$PATH
#ENV PATH /home/ubuntu/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
#RUN conda update anaconda
RUN conda update --all

# Install tensorflow and keras
RUN conda install tensorflow-${ARCH}=${TENSORFLOW_VERSION} cudatoolkit=${CUDA_TOOLKIT_VERSION}
RUN conda install keras

# Install some other python modules
RUN pip install jupyter

# Configuring access to Jupyter
#RUN mkdir /home/notebooks
RUN jupyter notebook --generate-config --allow-root
# Notebook password is 'root'
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/ubuntu/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888 and Tensorboard 6006
EXPOSE 8888 6006

# Run Jupytewr notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/home/notebooks", "--ip='*'", "--port=8888", "--no-browser"]