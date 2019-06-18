# dl-docker
Docker image for Deep Learning

## Pre-requisites

* Docker-CE: Install docker-ce by following the instructions here: ```https://docs.docker.com/install/linux/docker-ce/ubuntu/```
* NVIDIA runtime: Run the setup file (Ubuntu/Centos7) from this repository.

## Installed libraries
* CUDA Toolkit 9.2
* CUDNN Library 7.3.1
* Tensorflow 1.12
* Keras  latest

## Installation
### Using Dockerfile
* Clone this repository 
```
git clone https://github.com/hassanmohsin/dl-docker.git
cd dl-docker
````
* Run the Dockerfile to create an image 
```
docker build -t hassanmohsin/dl-docker:gpu .
```

### Using Docker Hub
* Pull the docker image from the Docker HUB
```
docker pull hassanmohisn/dl-docker:gpu
```

## Running docker image
* Test the image by running the test script (```benchmark.py```)
```
docker run -it --rm -v `pwd`:`pwd` -w `pwd` --runtime=nvidia hassanmohsin/dl:gpu python benchmark.py gpu 20000
```
- ```-i``` (interactive) flag to keep stdin open and ```-t``` to allocate a terminal
- ```--rm``` to remove the container after executing the script
- ```-v `pwd`:`pwd` ``` to mount the current working directory to the container with the same path
- ```-w `pwd``` to get the working the directory inside the container
- ```--runtime=nvidia ``` to activate the nvidia runtime

## Running Jupyter Notebook

```
docker run -it --rm --runtime=nvidia -p 8888:8888 hassanmohsin/dl-docker:gpu
```

This command is to listen to the port 8888 of the docker and forwarding that port through SSH.
