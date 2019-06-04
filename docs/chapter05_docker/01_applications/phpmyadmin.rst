PhpMyAdmin
==========

What is PhpMyAdmin
------------------
phpMyAdmin is a free and open source administration tool for MySQL and MariaDB. As a portable web application written primarily in PHP, it has become one of the most popular MySQL administration tools, especially for web hosting services.

How to set it up
-----------------

The following command will start up PhpMyAdmin::

  docker service create \
      --name phpmyadmin \
      --label "traefik.port=80" \
      --network traefik-net \
      -e ALLOW_ARBITRARY=1 \
      nazarpc/phpmyadmin



Docker compose
---------------
Below you find the reference code from the repository for phpmyadmin.


.. literalinclude:: ../../src/docker/compose/phpmyadmin/docker-compose.yml
   :language: yaml


.....
