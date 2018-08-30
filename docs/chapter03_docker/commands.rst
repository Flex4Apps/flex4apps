Docker commands
--------------------------------------------------------------------------------


docker run vs docker compose
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Advantages of docker run are that the command is easy to issue, just a copy & paste to the servers command line. Downside is, that the commands get quite long and adding line breaks introduces another possible fault. If you want to correct a running service you need to remove it first and then reissue it.

Advantages of using a docker-compose.yml is that they are usually easy to edit. Disadvantage is that you have to create them on the server first then issue the command to start them - so one additional step. But the biggest advantage is that they can be re-executed on existing services which will lead to a service update.

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

starting a generic web application with docker run::

    docker service create \
        --name demo \
        --label "traefik.port=80" \
        --network traefik-net \
        kitematic/hello-world-nginx

Thats all - and the service is running.

To create the same via docker-compose.yml::

  version: "3"

  services:
    nginx:
      image: kitematic/hello-world-nginx
      networks:
        - traefik-net
      deploy:
        labels:
          - traefik.port=80
          - "traefik.frontend.rule=Host:demo.f4a.me"
  networks:
    traefik-net:
     external: true

Then you need to issue the following command::

  docker stack deploy --compose-file docker-compose.yml demo


Conclusion
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To quickly test a service - docker run is nice. But to maintain a production environment docker-compose files are strongly recommended.
