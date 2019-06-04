kibana
========================

What is  kibana
------------------------------------
Kibana is an open source data visualization plugin for Elasticsearch. It provides visualization capabilities on top of the content indexed on an Elasticsearch cluster. Users can create bar, line and scatter plots, or pie charts and maps on top of large volumes of data.


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


Docker compose
---------------
Below you find the reference code from the repository for the ELK stack version 2.4

.. literalinclude:: ../../src/docker/compose/elk24/docker-compose.yml
  :language: yaml

Below you find the reference code from the repository for the ELK stack version 5.6

.. literalinclude:: ../../src/docker/compose/elk56/docker-compose.yml
 :language: yaml


Below you find the reference code from the repository for the ELK stack version 6.2

.. literalinclude:: ../../src/docker/compose/elk62/docker-compose.yml
 :language: yaml

.....
