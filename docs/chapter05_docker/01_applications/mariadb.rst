MariaDB
=======

What is MariaDB
---------------
MariaDB is free and open source relational database system. It was created as a :fork: from MySQL after Oracle started releasing new functionality not as open source anymore and due to the high support cost of MySQL.

How to set it up
----------------

As usual make sure that the path for data volume exists::

  mkdir -p /swarm/volumes/mariadb

The initiate the docker service::

  docker service create \
        --name mariadb \
        --publish 3306:3306 \
        --network traefik-net \
        --mount type=bind,src=/swarm/volumes/mariadb,dst=/var/lib/mysq \
        --label "traefik.port=3306" \
        -e MYSQL_ROOT_PASSWORD=someSecretPassword \
        mariadb:latest


Docker compose
---------------
Below you find the reference code from the repository for mariadb

.. literalinclude:: ../../src/docker/compose/mariadb/docker-compose.yml
   :language: yaml


.....
