# Docker

## Basic Docker Commands
- `docker run <image>` - takes an image and creates a container
  - `-d` - run as a daemon, in the background
  - `--name <name>` - give a container a name
  - `-p 8081:80` - post mapping
  - `-i` - attach input
  - `-t`
- `docker start <name|id>` - starts en existing container that is not running
- `docker stop <name|id>` - stops a running container
- `docker ps` - shows all of the containers
  - `-a` - include stopped containers
  - `-l` - last
  - `-q` - id of the container
- `docker rm <name|id>`
- `docker build` - build a docker image from Dockerfile
  - `-t`
- `docker push` - deploys the docker image
- `docker images` - shows the existing docker images on the system
- `docker diff <id>` - shows the difference in the current state and the image
- `docker commit <id> username/image-name` - snapshot a container as an image
- `docker` - information about the docker system
  - `-v` - version of docker
  - `version` - full version information, client / server / architecture
  - `info` - information about the docker system, memory, hardware

## Start with docker:
1. `docker login` to login to docker hub
2. `docker run tutum/hello-world`
3. `docker ps` - shows the app running on port 80
4. `<ctrl-c>` - stop the app execution

```bash
docker run -d --name web1 -p 8081:80 tutum/hello-world 
docker stop web1
```

```bash
docker build -t username/image-name .
```


