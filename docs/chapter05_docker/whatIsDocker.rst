What is Docker
####################################

Step 1 - setting up the servers
===============================

Nowadays the servers are usually preinstalled or an installation process can be kicked off via web interface. For the F4A usecase we chose Ubuntu 16.04 LTS (Long term support).

First we should ensure that the system is up-to-date and secure. This is done by kicking off the advanced packaging tool (apt). Within this process we can directly install the docker server component. All steps are done by issueing the following command::

     apt-get update && apt-get upgrade -y && apt install -y docker.io


As docker is still being developed, certain functionality still changes. This tutorial has been created using the following docker version (you can find our yours by executing ```docker version```)::

      root@nxp100:~# docker version
      Client:
       Version:      1.13.1
       API version:  1.26
       Go version:   go1.6.2
       Git commit:   092cba3
       Built:        Thu Nov  2 20:40:23 2017
       OS/Arch:      linux/amd64

      Server:
       Version:      1.13.1
       API version:  1.26 (minimum version 1.12)
       Go version:   go1.6.2
       Git commit:   092cba3
       Built:        Thu Nov  2 20:40:23 2017
       OS/Arch:      linux/amd64
       Experimental: false
      root@nxp100:~#


Step 2 - initiate a swarm
===============================


Setting up the docker swarm. A swarm is a group of computers::

  docker swarm init --advertise-addr 89.144.27.100

getting the feedback::

  Swarm initialized: current node (r3t3pu7rd74njml1afsf2uoev) is now a manager.

  To add a worker to this swarm, run the following command:

      docker swarm join \
      --token <some secret token displayed here> \
      89.144.27.100:2377

  To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.


If you dont remember the token etc - just run::

  docker swarm join-token worker


Step 3 - preparing the domain
===============================


register any domain you like. Just make sure that the domain names are pointing to all the server IPs you have. With that load balancing / failover is possible::

  f4a.me.           86400 IN  SOA  nsa3.schlundtech.de. mail.tillwitt.de. 2017112808 43200 7200 1209600 86400
  f4a.me.           86400 IN  NS  nsa3.schlundtech.de.
  f4a.me.           86400 IN  NS  nsb3.schlundtech.de.
  f4a.me.           86400 IN  NS  nsc3.schlundtech.de.
  f4a.me.           86400 IN  NS  nsd3.schlundtech.de.
  f4a.me.           600   IN  MX  10 mail.f4a.me.
  *.f4a.me.         600   IN  A   89.144.24.15
  *.f4a.me.         600   IN  A   89.144.27.100
  *.f4a.me.         600   IN  A   89.144.27.101
  *.f4a.me.         600   IN  A   89.144.27.102
  *.f4a.me.         600   IN  A   89.144.27.103
  nxp100.f4a.me.    600   IN  A   89.144.27.100
  nxp101.f4a.me.    600   IN  A   89.144.27.101
  nxp102.f4a.me.    600   IN  A   89.144.27.102
  nxp103.f4a.me.    600   IN  A   89.144.27.103
  nxp104.f4a.me.    600   IN  A   89.144.24.15
