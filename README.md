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
Under the `ports` section I specified an IP-address also `127.0.0.1:42011:42011/tcp`, you should replace that to your network IP if you want tools like Portainer.io to point you to the right ports without needing to change your Docker deamon configuration. But you can also change it simply to `42011:42011/tcp` where the first port is your local port and can be anything, the part after `:` should stay unchanged.

### Limited resources needed

I like to limit my container resources so when you use `docker-compose up -d` with this docker-compose file you will have a tiny container that can only access 25% of one CPU and 64 megabyte RAM. Which is more than enough to run this awesome API and it will still be blazing fast thanks to GoLang.

## Disclaimer
This repository has no affiliation with the official repository [rob121/broadlinkgo](https://github.com/rob121/broadlinkgo).