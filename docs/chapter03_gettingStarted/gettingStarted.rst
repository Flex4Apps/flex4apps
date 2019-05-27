####################################
Getting started
####################################

Quick start guide based on a Kubernetes setup is show at


****************************************************************
Getting started with Kubernetes and Flex4Apps
****************************************************************

This repository hosts example configuraton files for the Getting started guide.

Goal
================================================================
* show first setup to get in touch with toolbox
* use common building blocks as example

  * ElasticSearch
  * Kibana
  * Logstah
  * Mosquito

* use Kubernetes / Rancher as base ground

Documentation describe to deployment steps for a first setup. Some components has to be manually connected with each other depending on concrete use case.

The solution stores and analyses transport metadata from message broker mosquito to detect abnormal situations.

Requirements
================================================================

System
----------------------------------------------------------------
* virtual machine or bare metal server
* 24 GB RAM, 200 GB space left on storage
* OS Debian 9 minimal

Skills
----------------------------------------------------------------

You should be familiar with kubernetes stateless and stateful sets. Helm charts will be used for deployment.

Architecture
================================================================

Flex4Apps stack is divided in

* physical parts
* cloud part

The stack itselfs mainly covers the cloud part. From the pysical side it receives data via API. In this example a MQTT message broker is used for connections from outside.

Inside the cloud part of the stack data distinguish in

* payload
* transport metadata

The processing of payload is application specific. Therefore the stack mainly covers the use and analysis of metadata. Transport metadata produced at system border - mosquitto message broker in this example. They will delivered to an logstash and persisted at an elastic search instance.

To analyse metadata for anomalies Kibana is used. This tool provides visualization and alerting.

Deployments
================================================================

Set up Rancher / Kubernetes cluster (optional / unfertig)
================================================================

Given a bare metal physical or virtual server the following steps needed to set up a first Flex4Apps stack.

Docker
----------------------------------------------------------------

Install docker according to <https://docs.docker.com/install/linux/docker-ce/debian/>

Create file /etc/docker/deamon.json with following content

.. code-block:: json

  {
    "storage-driver": "overlay2",
    "iptables": false,
    "log-driver": "json-file",
    "log-opts": {
      "max-size": "25m", "max-file": "4"
    }
  }

Iptables
----------------------------------------------------------------

Firewall rules has to be set manually. ::

.. code-block:: bash

  sudo apt-get install iptables-persistent


If asked, save the existing rules for IPv4 and IPv6 and rename these files. ::

.. code-block:: bash

  mv /etc/iptables/rules.v4 /etc/iptables/rules.v4.orginal
  mv /etc/iptables/rules.v6 /etc/iptables/rules.v6.orginal


Helm / Tiller
----------------------------------------------------------------

running Rancher2 / Kubernetes Setup according to <https://rancher.com/docs/rancher/v2.x/en/quick-start-guide/>

Deploy core stack
================================================================

Required:

* running Kubernetes Cluster
* installed Helm / Tiller

For this example it is assumed that context for the cluster is named 'f4a' on the local machine. Furthermore installation is demonstrated on a single node within a cluster. Different deployments styles need modifications at target hosts and some labels.

Preparation and adaption to individual enviroment
----------------------------------------------------------------

1. identify the host name (value of label kubernetes.io/hostname) of your target host. This value is called hostname later one.
2. set your DNS to this host an give a domain name, for example f4a.company.com. Keep attention to set also all subdomains to this main domain host. Add the following lines to your domain name server and adapt the IP. Note that there can be a difference between hostname and application domain name.

.. code-block:: txt

  ...
  *.f4a                         IN CNAME  f4a
  f4a                           IN A      192.168.100.1
  ...


3. Clone the Flex4Apps repository to local directory with::

.. code-block:: bash

   git clone https://github.com/Flex4Apps/flex4apps.git


4. in /src/kuberentes/values.yaml you have to adopt some values to your local environment; change ALL the default passwords and see comments in file

5. adapt /src/kuberentes/templates/ssl.yaml and set your ssl certification data

Rollout
----------------------------------------------------------------

At Cluster all data will stored locally at /data/{namespace}. Namespace will be set at the next steps.

If everything is checked within config files, helm can be used to rollout the entire stack to yout Kuberentes cluster. ::

.. code-block:: bash

  cd /src/kuberentes/
  # check for syntax
  helm upgrade --install --namespace --dry-run f4a  .
  # do it for real
  helm upgrade --install --namespace  f4a  .

After rollout some URLs are available:

* https://kibana.hostname.tld
* https://cerebro.hostname.tld
* https://hostname.tld/elasticsearch
* https://hostname.tld/grafana

ElasticSearch
----------------------------------------------------------------

ElasticSearch (ES) holds data produced by tracing interface of [Flex4Apps mosquitto broker](<https://github.com/Flex4Apps/mosquitto>).

ElasticSearch can deployed in more than one node. In this example  only one node is used.

Deployment can be done by standard helm charts.
