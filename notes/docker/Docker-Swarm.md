# Docker Swarm Mode: Built-In Orchestration

## Manager Nodes

- Managers send work to worker nodes
- Managers can control the swarm, in the control plane
- Use an internal distributed state store (Raft)
- Only managers can issue swarm commands

## Docker Service Command

- New command `docker service create`
- Replaces the `docker run` command
- Includes `tasks` that would include information about replicas
- Manager Nodes
  - API - Accepts command from client and creates service object
  - Orchestrator - Reconciliation loop for service objects and create tasks
  - Allocator - Allocated IP addresses to tasks
  - Scheduler - Assigns nodes to tasks
  - Dispatched - Checks in on workers
- Worker Nodes
  - Worker - Connects to dispatcher to check on assigned tasks
  - Executor - Executes the tasks assigned to worker node

## Initialize Swarm Mode

- Docker swarm mode is inactive by default, to enable `docker swarm init`
  - Sometimes a public IP needs to be specified `docker swarm init --advertise-addr 192.168.99.102`
- Creates Root signing certificate, assigns it to the first manager node
- Join tokes are creates
- Creates the Raft database

## Swarm Commands

- Node commands `docker node --help`
  - List all nodes `docker node ls`
  - Promote a worker node `docker node update --role manager node2`
  - To see which services run on the node `docker node ps` for current or `docker node ps node2`
- Swarm commands `docker swarm --help`
  - Get the manager join token `docker swarm join-token manager`
  - Get the worker join token `docker swarm join-token worker`
- Service commands `docker service --help`
  - Create a task for the swarm `docker service create --replicas 3 alpine ping 8.8.8.8`
  - To see the service `docker service ls`
  - To see the containers in the service `docker service ps <ID>`
  - Scale the service `docker service update <ID> --replicas 4`
  - Remove the service `docker service rm <ID>`
  - Rebalance service `docker service update --force <ID>`
- Stack commands `docker stack --help`
  - Show the services in a stack `docker stack services <ID>`
  - Show the tasks in a stack `docker stack ps <ID>`

## Creating Nodes

- Creating additional nodes using docker-machine

```bash
docker-machine create --driver virtualbox --virtualbox-cpu-count 2 --virtualbox-memory "1024"  node1
```

- To access the machine use ssh command `docker-machine ssh node1`, or switch the docker cli to it via `docker-machine env node1`

To run the visualizer

```bash
docker service create --name=viz --publish=8080:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock bretfisher/visualizer
```

## New Features that Swarm Mode Adds

- Overlay multi-host networking, `docker network create --driver overlay backend`
- Routes mesh - routes ingress (incoming) packers for a Service to proper Task
  - Spans all nodes in Swarm
  - Uses IPVS from Linux Kernel
  - Load balances Swarm Services across their Tasks
  - Container-to-container in an Overlay network sues virtual IP (VIP)
  - External traffic incoming to published ports (all nodes listen)
  - Stateless load balancing
  - Layer 3 (TCP), not Layer 4 (DNS)
- Stacks: production grade compose
- Secrets

## Stacks

- Stacks accept compose files as their declarative definition for services, networks and volumes
- Use `docker stack deploy` rather than `docker service create`
- Stacks manages all objects for us, including overlay network per stack
- New `deploy:` key in Compose file, cannot do `build:`
- Compose ignores `deploy:`, swarm ignores `build:`
- Stack / Compose file must by on version 3 or higher, with secrets 3.1 or higher

To deploy / update

```bash
docker stack deploy -c example-app-stack.yml stackname
```

## Secrets

- Easier "secure" solution for storing secrets in Swarm
- Supports generic strings or binary content up to 500kb in size
- Doesn't require apps to be rewritten
- As of Docker 1.13.0 Swarm Raft DB is encrypted on disk
- Only stored on disk on manager nodes
- Secrets are first stored in Swarm, then assigned to a Service(s)
- Only containers in assigned Service(s) can see them
- The look like files in containers but are actually in-memory fs
  - `/run/secrets/<secret_name>` or `/run/secrets/<secret_alias>`
- Local docker-compose can use file-based secrets, but not secure

Creating a secret

```
docker secret create psql_user psql_user.txt
echo "myDBpassWORD" | docker secret create psql_pass -
```

Inspecting

```
docker secret ls
docker secret inspect psql_user
```

Using

```
docker service create --name psql --secret psql_user --secret psql_pass -e POSTGRES_PASSWORD_FILE=/run/secrets/psql_pass -e POSTGRES_USER_FILE=/run/secrets/psql_user postgres
```

Remove (redeploys the container)

```
docker service update --secret-rm psql_user
```

## Docker Health Checks

- `HEALTHCHECK` was added in 1.12
- Supports in Dockerfile, Compose YAML, docker run and Swarm Services
- Docker engine will `exec` the command in the container, e.g. `curl localhost`
- It expects `exit 0` (OK) or `exit 1` (Error)
- Three container states: starting, healthy, unhealthy
- Healthcheck status shows up in `docker container ls`
- Check last 5 healchecks with `docker container inspect`
- Docker run does nothing with healthcheks
- Services will replace tasks if they fail healtcheck
- Service updates wait for them before continuing

```bash
docker run \
  --health-cmd="curl -f localhost:9200/_cluser/health || false" \
  --health-inverval=5s \
  --health-retries=3 \
  --health-timeout=2s \
  --health-start-period=15s \
elasticsearch:2

docker container run --name psql -d --health-cmd="pg_isready -U postgres || exit 1" postgres
```
