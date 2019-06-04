Phabricator
====================


The database user needs to be able to create databases


install
-------

1. change your password::

    sed -i 's/<some secret>/yourPassword/g' Dockerfile

1. build the image with::

    docker build -t phabricator_image .

2. tag and push it to the registry::

    docker tag phabricator_image registry.f4a.me/phabricator
    docker push registry.f4a.me/phabricator

3. deploy it from the registry by executing the docker-compose::

    docker-compose up

Docker file
-----------

.. literalinclude:: ../../compose/phabricator/web/Dockerfile


Docker compose
---------------
Below you find the reference code from the repository for phabricator. This is not completely working at the end of the project

.. literalinclude:: ../../src/docker/compose/phabricator/docker-compose.yml
   :language: yaml


.....
