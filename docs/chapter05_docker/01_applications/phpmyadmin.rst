PhpMyAdmin
==========

What is PhpMyAdmin
------------------


How to set it up
-----------------

The following command will start up PhpMyAdmin::

  docker service create \
      --name phpmyadmin \
      --label "traefik.port=80" \
      --network traefik-net \
      -e ALLOW_ARBITRARY=1 \
      nazarpc/phpmyadmin
