grafana
=======

What is grafana
---------------

`Grafana <https://grafana.com/>`_ is an open source software for time series analytics


Setting it up
-------------

create the service like this::

  docker service create \
    --name=grafana \
    --network traefik-net \
    --label "traefik.port=3000" \
    --mount type=bind,src=/swarm/volumes/grafana,dst=/var/lib/grafana \
    -e "GF_SECURITY_ADMIN_PASSWORD=someSecretPassword" \
    grafana/grafana


Docker compose
-----------
Below you find the docker-compose for grafana
.. literalinclude:: ../../src/docker/compose/grafana/docker-compose.yml
  :language: yaml




.....
