Monitoring
==========

prometheus

* chmod 777 for directory needed otherwise "Opening storage failed" err="open DB in /prometheus: open /prometheus/583762017: permission denied"

https://github.com/epasham/docker-repo/blob/master/monitoring/prom-stack/promUp.sh


## node exporter

docker service create \
  --name nodeexporter \
  --mode global \
  --network traefik-net \
  --label com.group="prom-monitoring" \
  --mount type=bind,source=/proc,target=/host/proc \
  --mount type=bind,source=/sys,target=/host/sys \
  --mount type=bind,source=/,target=/rootfs \
  prom/node-exporter:latest \
  --collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
