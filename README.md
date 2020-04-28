# Broadlinkgo Docker

A Docker variant of the awesome [rob121/broadlinkgo](https://github.com/rob121/broadlinkgo) project. This tool is a local Broadlink HTTP API written in [GoLang](https://golang.org/) and works better with the Broadlink devices than the software from Broadlink itself. Thank to @rob121.

I'm aware that GoLang is already cross-platform but I made this Docker version because I wanted to be able to incorporate this specific API into my existing management tools. This version is based on the lightweight [Alpine Linux](https://alpinelinux.org/), but since it is a Docker container it should run on any host OS.

## Dockerfile
This Dockerfile can be used with or without `docker-compose`. It builds a Docker image that pulls the latest version from the official broadlinkgo repository on GitHub and it runs by default on the port local TCP port `42011`. It also contains a `HEALTHCHECK`, that looks fancy in tools like Portainer.io.

## Features

### Shared persistent folder
You can specify where you want to store your configuration files in the volumes section. `/docker_volumes/broadlinkgo:/config`, only the last part `:/config` has to stay unchanged. The part before `:` should be your local path. Meaning you could stop, delete, recreate the container without losing your configuration. 

_The `:ro` in the end of the specified volume in the file makes the share read-only to the container. This is perfect when you are finished adding your devices and commands as it prevents you from accedentaly removing anything through the Web UI. Start without `:ro`, when ready recreate with `:ro`._

### Port mapping
By default the TCP port `42011` is used. If you want to change it you have to change the `EXPOSE 42011` and the `--port=42011` part in `broadlinkgo.Dockerfile`.

### Limited resources needed

I like to limit my container resources so when you use `docker-compose up -d` with this docker-compose file you will have a tiny container that can only access 25% of one CPU and 64 megabyte RAM. Which is more than enough to run this awesome API and it will still be blazing fast thanks to GoLang.

## Usage (from Docker Hub)

## Without docker-compose

    docker run -d -v '/docker_volumes/broadlinkgo:/config' --cpus=0.25 --memory=64M --network=host --restart unless-stopped brianpierson2020/broadlinkgo

### With docker-compose

    version: '2.2'
    services:
        broadlinkgo:
            volumes:
                - '/docker_volumes/broadlinkgo:/config'
            network_mode: host
            cpus: 0.25
            mem_limit: 64M
            restart: unless-stopped
            image: brianpierson2020/broadlinkgo


## Usage (from build)

Clone this repository:

    git clone https://github.com/brianpierson2020/broadlinkgo-docker broadlinkgo-docker
    cd broadlinkgo-docker

### With docker-compose
Configure the local IP address, port and volume paths in the `docker-compose.yml` file then run:

    docker-compose up -d

### Without docker-compose
Edit the below `docker run` command to your needs and run:

    mv ./broadlinkgo.Dockerfile ./Dockerfile
    docker build . -t broadlinkgo
    docker run -v '/docker_volumes/broadlinkgo:/config' --cpus=0.25 --memory=64M --network=host --restart unless-stopped broadlinkgo

## Disclaimer
This repository has no affiliation with the official repository [rob121/broadlinkgo](https://github.com/rob121/broadlinkgo). I am not responsible for anything that can possibly go wrong because of this software. Please, always back-up your own configuration files before making changes.