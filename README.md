# dl-docker
Docker image for Deep Learning

## Installation
Install docker and then do `docker pull hassanmohsin/dl-docker`

## Running Jupyter Notebook
Run the following command in the terminal throuhg root permission
```
docker run --rm -it -p 8888:8888 hassanmohsin/dl-docker bash run_jupyter.sh
```

This command is to listen to the port 8888 of the docker and forwarding that port through SSH.

