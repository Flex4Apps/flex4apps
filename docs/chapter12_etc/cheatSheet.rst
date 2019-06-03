cheat sheet
===========

Clean up of containers
----------------------

remove all exited containers (should be run on each node)::

  docker rm $(docker ps -q -f status=exited)

attach bash to a running container::

  sudo docker exec -i -t containername /bin/bash


Remove all containers::

  docker rm $(docker ps -a -q)

Remove all images::

  docker rmi $(docker images -q)


Whiping out everything::

  docker system prune -a

Networking
-----------

Finding public ip::

  wget -qO - https://api.ipify.org


Dos and don'ts
===============
https://community.spiceworks.com/topic/1832873-a-list-of-don-ts-for-docker-containers

1) Don’t store data in containers
2) Don’t ship your application in two pieces
3) Don’t create large images
4) Don’t use a single layer image
5) Don’t create images from running containers
6) Don’t use only the “latest” tag
7) Don’t run more than one process in a single container
8) Don’t store credentials in the image. Use environment variables
9) Don’t run processes as a root user
10) Don’t rely on IP addresses


Updating this documentation
===========================
issue the following command to update this documentation::

  docker run --name sphinxneeds --rm \
        -e "Project=Flex4apps" \
        -e "Author=Till Witt, Johannes Berg, Alex Nowak" \
        -e "Version=v0.1" \
        -v "$(pwd)/compose:/project/compose" \
        -v "$(pwd)/docs:/project/input" \
        -v "$(pwd)/output:/project/output" \
        -i -t tlwt/sphinxneeds-docker


  docker run --name buildTheDocs --rm \
        -e "Project=Flex4apps" \
        -e "Author=Till Witt, Johannes Berg, Alex Nowak" \
        -e "Version=v0.1" \
        -v "$(pwd)/compose:/project/compose" \
        -v "$(pwd)/docs:/project/input" \
        -v "$(pwd)/output:/project/output" \
        -i -t sphinx_image
