kibana
========================

What is  kibana
------------------------------------
:todo:

How to set it up - release 2.4
----------------------------------


Issue the following command::

  docker service create \
     --name kb56 \
     --label "traefik.port=5601" \
     --label 'traefik.frontend.auth.basic=flex4apps:$apr1$G9e4rgPu$jbn2AAk2F.OeGnRVFnIR/1' \
     --network traefik-net \
     -e "ELASTICSEARCH_URL=http://esc56:9200" \
     kibana:5.6
