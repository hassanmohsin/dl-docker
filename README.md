# dl-docker
Docker image for Deep Learning

## Installation
Install docker and then do `docker pull hassanmohsin/dl-docker`

## Running Jupyter Notebook
Run the following command with root permission to run the IMAGE.
```
docker run --rm -it -p 8888:8888 hassanmohsin/dl-docker bash run_jupyter.sh
```

This command is to listen to the port 8888 of the docker and forwarding that port through SSH.


If the IMAGE has ran before, then you should have a container. Now this is important to start a container rather than to run a new IMAGE to get your work or files back. To start an existing container, do the following.

```
docker container start <CONTAINER_ID>
```

The CONTAINER_ID is available by the following command.

```
docker ps -a
```
