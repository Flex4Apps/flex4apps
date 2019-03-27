#######
Traefik
#######

What is traefik
----------------
Traefik is a Reverse Proxy Server + Load Balancer that facilitates the (automated) deployment of Docker Containers.


Setup procedure
----------------

Within this project we use v1.4.4 / roquefort

Hints for the setup [#traefik1]_ ::

    --mkdir -p /docker/traefik

    docker network create --opt encrypted --driver overlay traefik-net

    docker network create --driver overlay traefik-net


.. literalinclude:: ../../compose/demo/docker-compose.yml

To run it just on one machine:

    docker network create traefik-net



.. [#traefik1] DDD Paul https://dddpaul.github.io/blog/2016/11/07/traefik-on-docker-swarm/


Basic auth support
------------------

create a file for authentication, so no need for listing the users in the call::

  touch .htpasswd
  htpasswd -bB .htpasswd username password
