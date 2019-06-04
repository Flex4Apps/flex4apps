Generic demonstrator
====================

Docker file
-----------

.. literalinclude:: ../../../src/docker/compose/demo/docker-compose.yml

Simple demo
___________

The following application is already working with the current setup.

To launch an easy demonstrator, lets instantiate a webserver and make it available at demo.f4a.net::

    docker service create \
        --name demo \
        --label "traefik.port=80" \
        --network traefik-net \
        kitematic/hello-world-nginx



Generating a new user with password run::

  htpasswd -nbm flex4apps password

or go to: http://www.htaccesstools.com/htpasswd-generator/

The output will be something like::

  flex4apps:$apr1$XqnUcSgR$39wlPxxyyxPxXZjFb34wo.

Example for traefik label usage below. If single quotes are in the password they would need to be escaped.

To do that close the quoting before it, insert the escaped single quote, and re-open the quoting: ```'first part'\''second part'```


How to start the demo service::

  docker service create \
      --name demopw \
      --label "traefik.port=80" \
      --label 'traefik.frontend.auth.basic=myName:$apr1$a7R637Ua$TvXp8/lgky5MDLGLacI1e1' \
      --network traefik-net \
      kitematic/hello-world-nginx
