elasticsearch and kibana
========================

What is  elasticsearch and kibana
------------------------------------
:todo:


How to set it up - release 2.4
----------------------------------


Inspired by https://sematext.com/blog/docker-elasticsearch-swarm/. Issue the following command::

      docker service create \
         --name esc24 \
         --label "traefik.port=9200" \
         --label 'traefik.frontend.auth.basic=flex4apps:$apr1$G9e4rgPu$jbn2AAk2F.OeGnRVFnIR/1' \
         --network traefik-net \
         --replicas 3 \
         --endpoint-mode dnsrr \
         --update-parallelism 1 \
         --update-delay 60s \
         --mount type=volume,source=esc24,target=/data \
       elasticsearch:2.4 \
         elasticsearch \
         -Des.discovery.zen.ping.multicast.enabled=false \
         -Des.discovery.zen.ping.unicast.hosts=esc24 \
         -Des.gateway.expected_nodes=3 \
         -Des.discovery.zen.minimum_master_nodes=2 \
         -Des.gateway.recover_after_nodes=2 \
         -Des.network.bind=_eth0:ipv4_

Release 5.6
------------

Inspired by https://github.com/elastic/elasticsearch-docker/issues/91 and https://idle.run/elasticsearch-cluster

The host systems have to be prepared to run elasticsearch in a docker::

      echo vm.max_map_count=262144 >> /etc/sysctl.conf && sysctl --system && sysctl vm.max_map_count

The issue the following command to start three instances of elasticsearch::

      docker service create \
        --replicas 3 \
        --name esc56 \
        --label "traefik.port=9200" \
        --label 'traefik.frontend.auth.basic=flex4apps:$apr1$G9e4rgPu$jbn2AAk2F.OeGnRVFnIR/1' \
        --mount type=volume,source=esc56,target=/data \
        --network traefik-net \
        elasticsearch:5.6.4 bash -c 'ip addr && IP=$(ip addr | awk -F"[ /]*" "/inet .*\/24/{print \$3}") && \
            echo publish_host=$IP && \
            exec /docker-entrypoint.sh -Enetwork.bind_host=0.0.0.0 -Enetwork.publish_host=$IP -Ediscovery.zen.minimum_master_nodes=2 -Ediscovery.zen.ping.unicast.hosts=tasks.esc56'
