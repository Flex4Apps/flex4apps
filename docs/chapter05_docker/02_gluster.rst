Gluster
========

What is gluster
---------------
GlusterFS is a distributed file system that presents storage elements from multiple servers as a unified file system. The various servers, also known as cluster nodes, form a client-server architecture over TCP/IP.


Step 1 - join computers into a gluster
-------------------------------------------------

For each swarm the the ``/etc/hosts`` needs to be updated. Otherwise there will be no connection. The following command appends the IPs of our swarm nodes to the host file. They need to be adapted to match your system setup::


  echo 89.144.27.100 gluster0 >> /etc/hosts
  echo 89.144.27.101 gluster1 >> /etc/hosts
  echo 89.144.27.102 gluster2 >> /etc/hosts

create a data where gluster shall store its operational data::

  mkdir -p /data/gluster

If not done already you can install gluster via the following command::

  apt-get update && apt-get install -y glusterfs-server && service glusterfs-server status

Now we need to join the nodes to the gluster::

  gluster peer probe gluster0 && gluster peer probe gluster1 && gluster peer probe gluster2

And check if everything went well::

  gluster peer status

This should return something like::

  root@nxp100:~# gluster peer status
  Number of Peers: 4

  Hostname: gluster1
  Uuid: 32e5a4ac-bd12-...
  State: Peer in Cluster (Connected)

  Hostname: gluster2
  Uuid: 681007c5-ad57-...
  State: Peer in Cluster (Connected)

Step 2 - create a sync volume
-----------------------------

we need to create a volume for data syncing. (This only needs to be executed on one node)::

  gluster  volume create datapoint replica 3 transport tcp  \
            gluster0:/data/gluster \
            gluster1:/data/gluster \
            gluster2:/data/gluster \
            force

and then start the volume (This only needs to be executed on one node)::

  gluster volume start datapoint

last but not least we mount it (this needs to be done on each node!)::

  mkdir -p /data/shared
  mount.glusterfs localhost:/datapoint /data/shared

The gluster is ready for use now


Experience
----------

Strange shutdown of Cluster

gluster peer status
gluster volume info
gluster volume heal datapoint

apparently node was down.
