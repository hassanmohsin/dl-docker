From nvidia/cuda:9.1-cudnn7-runtime-ubuntu16.04

# $ docker build . -t continuumio/anaconda:latest -t continuumio/anaconda:5.2.0 -t continuumio/anaconda2:latest -t continuumio/anaconda2:5.2.0 
# $ docker run --rm -it continuumio/anaconda2:latest /bin/bash 
# $ docker push continuumio/anaconda:latest 
# $ docker push continuumio/anaconda:5.2.0 
# $ docker push continuumio/anaconda2:latest 
# $ docker push continuumio/anaconda2:5.2.0

MAINTAINER Md Mahmudulla Hassan <mhassan@miners.utep.edu>

#ARG TENSORFLOW_VERSION=1.9.0
#ARG TENSORFLOW_ARCH=gpu
#ARG KERAS_VERSION=2.2.0

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 
ENV PATH /opt/conda/bin:$PATH 


RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \ 
	libglib2.0-0 libxext6 libsm6 libxrender1 \ 
	git mercurial subversion 

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \ 
	/bin/bash ~/anaconda.sh -b -p /opt/conda && \ 
	rm ~/anaconda.sh && \ 
	ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \ 
	echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \ 
	echo "conda activate base" >> ~/.bashrc 

# Install Tensorflow
RUN pip --no-cache-dir install tensorflow-gpu

# Install Keras
RUN pip --no-cache-dir install keras

#RUN apt-get install -y curl grep sed dpkg && \ 
#	TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \ 
#	curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \ 
#	dpkg -i tini.deb && \ 
#	rm tini.deb && \ 
#	apt-get clean 

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006 8888

WORKDIR "/root"
CMD [ "/bin/bash" ]
