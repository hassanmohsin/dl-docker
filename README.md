# dl-docker
Docker image for Deep Learning

## Installed libraries
* CUDA Toolkit 9.2
* CUDNN Library 
* Tensorflow 1.12
* Keras  latest

## Installation
* Clone this repository 
```
git clone https://github.com/hassanmohsin/dl-docker.git
cd dl-docker
````
* Run the setup file (Ubuntu/Centos7) to set up nvidia runtime
* Run the Dockerfile to create an image 
```
docker build -t hassanmohsin/dl:gpu .
```
* Test the image by running the test script (```benchmark.py```)
```
docker run -it --rm -v `pwd`:`pwd` -w `pwd` --runtime=nvidia hassanmohsin/dl:gpu python benchmark.py gpu 20000
```
- ```-i``` (interactive) flag to keep stdin open and ```-t``` to allocate a terminal
- ```--rm``` to remove the container after executing the script
- ```-v `pwd`:`pwd` ```` to mount the current working directory to the container with the same path
- ```-w `pwd``` to get the working the directory inside the container
- ```--runtime=nvidia ```` to activate the nvidia runtime

## Running Jupyter Notebook

```
docker run -it --rm --runtime=nvidia -p 8888:8888 hassanmohsin/dl:gpu
```

This command is to listen to the port 8888 of the docker and forwarding that port through SSH.
