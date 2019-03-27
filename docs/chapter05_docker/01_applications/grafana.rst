grafana
=======

What is grafana
---------------

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
