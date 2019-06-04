portainer
==========

start portainer as a service we first need to create a data directory::

  mkdir -p /docker/portainer

To start the container itself::

  docker service create \
  --name "portainer" \
  --constraint 'node.role == manager' \
  --network "traefik-net" --replicas "1" \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  --mount type=bind,src=/docker/portainer,dst=/data \
  --label "traefik.frontend.rule=Host:portainer.f4a.me" \
  --label "traefik.backend=tool-portainer" \
  --label "traefik.port=9000" \
  --label "traefik.docker.network=traefik-net" \
  --reserve-memory "20M" --limit-memory "40M" \
  --restart-condition "any" --restart-max-attempts "55" \
  --update-delay "5s" --update-parallelism "1" \
  portainer/portainer \
  -H unix:///var/run/docker.sock


Docker compose
---------------
Below you find the reference code from the repository for portainer.

.. literalinclude:: ../../src/docker/compose/portainer/docker-compose.yml
   :language: yaml


.....
