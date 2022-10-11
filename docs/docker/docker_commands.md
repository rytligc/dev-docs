# Docker Commands

```bash
Docker run = run a container from an image
Docker run -d = -d is detached mode. It is making the container run in the background (good idea if you don't want the terminal to just wait)
Docker run --name someName <image> = --name to name the container
Docker ps = list containers
Docker ps -a = list containers running and previous
Docker stop + container name or ID = stop container
Docker rm + container name or ID = remove container
Docker images = list images available on the host
Docker rmi = Remove images that you do not want to have any more
Docker pull = pull image without running the container
Docker run <example ubuntu> sleep 5 = Docker is not meant to host an operating system, rather it is meant to host a process. ubuntu is not a process but an operating system.
Docker exec <command> = Use exec to execute a command on a container -- for example docker exec distracted_mcclintock cat /etc/hosts
Docker run <image>:<version> = :<version> is called a TAG. If no version is specified, Docker will try to pull the latest available version
Docker run -i <image> = -i is for running an app interactively e.g. for input by user
Docker run -t <image = -t is for terminal without accepting input. Use only for testing
Docker run -it <image> = -it is for interactive and terminal for example for input="What is your name?". With only -i there would be no prompt, only input.
Docker run -p 8383:8080 <image> = -p is port. 8383 is the internal port and 8080 is the container port to let users in through that port
Docker inspect <container name> or <container ID> = inspect the information about the container in JSON
Docker logs <container name> or <container ID> = list logs
Docker attach = attach a container to the console
Docker run -e <some env variable>=<value> <container> = -e sets environvariable given that it is available in the application. Use the "INSPECT" command to see if environment variables is already available in a container
Docker run --cpus=<float> = --cpus ensures that the container does not use more than a given amount of CPU power. <float> is a relative value from .1 to 1 where .5 is 50%
Docker run --memory=<int>m = same as with CPU. However, specify int instad of float. E.g. --memory=100m is equivalent of limiting the container to use 100 megabytes of memory.
```

## Networks

By default Docker only creates one internal network but we can create multiple networks inside the environment.

```bash
Docker run <image> = default bridge network
Docker run <image> --network=none = docker image is run in an isolated environment
Docker run <image> --network=host = docker image is run on the host network, thus two images can not run on the same port

Docker network create --driver <bridge> --subnet 182.18.0.0/16 (or something else) <name>

Docker network ls = list all networks
Docker inspect <id or name of container> = inspect network settings of a container
Docker network inspect = inspect network settings of a particular network
```

Docker can connect two containers using ip addresses - for example an SQL instance and a web container:

```bash
<sql_container name>.connect <web-container ip> --- mysql.connect(172.17.03)
```

The above method, however, is not ideal as it is not certain that the container will get the same ip every time.
The right way to do it is to reference the container name instead as Docker has an embedded DNS server to resolve DNS.
The built in DNS server always run on 127.0.0.11.

*** EXAMPLE *** 

docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network
docker run -d -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db --network wp-mysql-network mysql:5.6
docker pull kodekloud/simple-web-app-mysql
docker run --network=wp-mysql-network -e DB_Host=mysql-db -e DB_Password=db_pass123 -p 38080:8080 --name webapp --link mysql-db:mysql-db -d kodekloud/simple-webapp-mysql

Dockerfile

Dockerfiles must always start with:
FROM <Image>


Data can be stored on the host instead of in the container using the -v <path>. It mounts the storage to the host. Read more on: https://docs.docker.com/storage/
docker run -v /opt/data:/var/lib/mysql -d --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql

**Docker Registry**
The registry is the central repository where images are stored.

By default images are pulled from docker like docker pull <image> but is actually behind the scenes referred to as:
	image: <imageName>/<image> --- e.g. nginx/nginx. The first part is the user or account, and the seocnd part is the image or repository.
Therefore the whole "actual" command would be image: docker.io/nginx/nginx.
													 ^Registry ^usr/acc ^img/repo
Other registries also exist such as:
Google's registry is at gcr.io/

Private registries on AWS or Azure is created on subscription/account (maybe?). To pull from private registries remember to login:
docker login private-registry.io
docker run private-registry.io/apps/internal-app

Private registry for On-premise uses the Docker registry application, which is also available as a Docker image. It's exposed on port 5000:

docker run -d -p 5000:5000 --name registry registry:2

To push an image to the private registry use the tag to push:

```bash
docker image tag <my-image> localhost:5000/<my-image>
docker push localhost:5000/<my-image>

docker pull localhost:5000/<my-image>
#OR
docker pull <ip>:5000/<my-image> --- docker pull 192.168.56.100:5000/<my-image>
```
