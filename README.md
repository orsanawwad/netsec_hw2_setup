# Netsec Homework 2 Environment Setup

## Setup

*Make sure you have `docker` and `docker-compose` installed, for best results run on Linux or Windows with WSL2*


Clone

```
git clone github.com/orsanawwad/netsec-hw2
```

Run with docker-compose

```
docker-compose up -d
```

Exec into each container

```
docker exec -it CONTAINER_NAME bash
```

Where container name can be one of the following:

```
private_a
dmz_b
router_c
public_d
```

## Start up configs

For each container there is a small shell file that is executed on container startup, these can be found in `configs/` folder.

# Warning
Anything you do inside these containers will be destroyed once they are stopped, make sure to read more about Docker volumes.