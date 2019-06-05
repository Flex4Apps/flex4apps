Drone
=====


About the software
------------------
A continuous integration server which is open source, and tightly integrates with open source git platforms like gogs or services like github.


Setting it up
-------------

A good installation procedure is available here at http://docs.drone.io/install-for-gogs/. The corresponding commands for F4A are below::

    docker run \
      --name drone \
      --label "traefik.port=8000" \
      --publish 8000:8000 \
      --publish 9000:9000 \
      -e DRONE_OPEN=true \
      -e DRONE_HOST=drone.f4a.me \
      -e DRONE_GOGS=true \
      -e DRONE_GOGS_URL=https://gogs.tillwitt.de \
      -e DRONE_SECRET=<some secret> \
      drone/drone:0.8

    mkdir -p /swarm/volumes/drone

    docker service create \
      --name drone \
      --label "traefik.port=8000" \
      --label "traefik.docker.network=traefik-net" \
      --network traefik-net \
      --mount type=bind,src=/swarm/volumes/drone,dst=/var/lib/drone/ \
      --publish 8000:8000 \
      --publish 9000:9000 \
      -e DRONE_OPEN=true \
      -e DRONE_HOST=drone.f4a.me \
      -e DRONE_GOGS=true \
      -e DRONE_GOGS_URL=https://gogs.tillwitt.de \
      -e DRONE_SECRET=<some secret> \
      -e DRONE_ADMIN=witt \
      drone/drone:0.8

    docker service create \
      --name drone_agent \
      --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
      --network traefik-net \
      -e DRONE_SERVER=drone:9000 \
      -e DRONE_SECRET=<some secret> \
      drone/agent:0.8


How to:
-------
Once setup, with in this case gogs, you can log into the web interface. After a short sync all repositories should be visible. Activate drone.io for the corresponding repository.

To tell drone.io what to execute you need to add a :code:`.drone.yml` to your repository. Examples are below.


Examples and configuration
---------------------------

example::

    image: dockerfile/nginx
    script:
      - echo hello world

      publish:
        docker:
          registry: registry.f4a.me
          email: witt@f4a.me
          repo: registry.f4a.me/flex4apps/flex4apps/homomorphic-encryption
          file: homomorphic-encryption/Dockerfile
          context: homomorphic-encryption
          tag: latest
          secrets: [ docker_username, docker_password ]
