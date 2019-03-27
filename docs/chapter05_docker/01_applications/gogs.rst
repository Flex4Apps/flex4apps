gogs
====

What is gogs
------------
:todo:


How to set it up
----------------

Pull image from Docker Hub.

very strange installation. First need to use --publish 3000:3000 and connect direct for install. Then remove instance and also remove published port. This is certainly something I need to review.

create the data volume for gogs::

  mkdir -p /swarm/volumes/gogs

start the service::

  docker service create \
      --name gogs \
      --mount type=bind,src=/swarm/volumes/gogs,dst=/data \
      --label "traefik.port=3000" \
      --network traefik-net \
      gogs/gogs
