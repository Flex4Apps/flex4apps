
Docker registry
####################################

Running your own registry::

  docker service create \
     --name backoffice \
     --network traefik-net \
     --label "traefik.port=5000" \
     --label 'traefik.frontend.auth.basic=flex4apps:$apr1$G9e4rgPu$jbn2AAk2F.OeGnRVFnIR/1' \
     --mount type=bind,src=/swarm/volumes/registry,dst=/var/lib/registry \
     registry:2



Pushing to private registry
====================================

The local image needs to be taged and then pushed::

  docker tag phabricator_image registry.f4a.me/phabricator
  docker push registry.f4a.me/phabricator

Run that image::
  docker service create \
    --name demo \
    --label "traefik.port=80" \
    -e "GITURL=https://secret@gogs.tillwitt.de/NXP/homomorphic-encryption-demo.git" \
    flex4apps:GQfgCEsjkHC7LRf3Q9PkW4L6onDLtu@backoffice.f4a.me/homomorphic_img


Query the registry
====================================
Get the overview of all images::

  https://registry.f4a.me/v2/_catalog

Get all tags of an image::

  https://registry.f4a.me/v2/henc/tags/list

Private repository viewer
====================================


Alternatives
====================================
