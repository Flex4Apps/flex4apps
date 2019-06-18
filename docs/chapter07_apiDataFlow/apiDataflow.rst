####################################
API and data flow
####################################

Based on the architectural structure of a Flex4Apps solution (https://f4a.readthedocs.io/en/latest/chapter04_architecture/_structure.html) there are different components connected to form a working system.
Others are necessary to run individual components within the architecture.


APIs to exchange data between system components
===============================================

Some of the components are designed already to closely work together while others have to be adapted.
This section will give a survey on which APIs might be relevant to tailor Flex4Apps to a certain application. 

The figure below shows some scenarios and API's to regard for this

.. image:: API-Usage.svg

Since APIs are version dependent we prefer to link to the API definitions rather than integrating them into this documentation.

API 1: XML RPC for HomeMatic
----------------------------

A Gateway (F4A-Box with optional and safe Genode-OS) collects sensor data from an aggregation device cyclically. For this it implements a vendor specific interface. [*]_

.. [*] https://github.com/hobbyquaker/XML-API/releases/tag/1.16
.. [*] https://www.eq-3.de/Downloads/eq3/download%20bereich/hm_web_ui_doku/HM_XmlRpc_API.pdf


API 2: Non public REST-API
--------------------------

If data is available online then no separate gateway is necessary. Some vendor specific code can be used to connect numerous data sources with Flex4Apps toolbox. [*]_
This API is an example how to use various online data sources

.. [*] http://www.powerfox.energy/
.. [*] https://development.powerfox.energy/


API 3: Standard MQTT protocol
-----------------------------

Using MQTT is very common for many cyber pyhsical (IoT) systems. There are two basic use-cases to be distinguished:
1: Devices (publishers) send their information directly to a managing instance (broker).
2: An aggregation device collects information according to API 1 or 2 and uses MQTT to forward it to a broker. Appropriate software can run on many hardware platforms.
For security reasons it is advisable to use a VPN tunnel to transfer MQTT packets. Alternatively (or additionally) MQTT devices shall use encryption to communicate with the broker. [*]_

.. [*] https://www.thethingsnetwork.org/docs/applications/mqtt/api.html


API 4: Store MQTT payload
-------------------------

In order to use aggregated information in consecutive processing operations Influx can be used. [*]_

.. [*] https://docs.influxdata.com/influxdb/v1.7/tools/api/


API 5: Present information with e.g. Grafana
--------------------------------------------

Grafana accesses influx data via a standard data source driver. This allows inspection of data independent from a specific domain model.
For third party applications there exist specific APIs to aggregate and visualize data series. [*]_


API 6: Enhance MQTT data with additional meta information
---------------------------------------------------------

A modified MOSQUITTO broker sends MQTT payload and further information about connectivity status, publisher- and subscriber-ID's and some more information to ELK stack.
Logstash gathers these messages from a dedicated TCP connection. [*]_

.. [*] https://www.elastic.co/guide/en/logstash/current/plugins-inputs-tcp.html
.. [*] https://nmap.org/ncat/guide/index.html


API 7: Logstash pushes data to Elasticseach
-------------------------------------------

Since Logstash is part of the Elastic-Stack (ELK-stack) there is no custom code or API adaptation needed.


API 8: Inspect Data with Kibana
-------------------------------

Kibana is also part of ELK stack. So there is no API to adapt. However, a user can alternatively use the Elasticseach-API to query data directly if another application shall be used. [*]_

.. [*] https://www.elastic.co/guide/en/elasticsearch/reference/current/docs.html
.. [*] https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-get.html

Additionally Elastic-Stack offers Machine learning and anomaly detection mechanism. To use it the following links are useful as an entry point: [*]_

.. [*] https://www.elastic.co/guide/en/x-pack/current/index.html


API 9: Alert anomaly events to external application
---------------------------------------------------

If X-Pack is used for anomaly detection it is possible to send alerts to different kind of receivers, e.g. e-Mail, Push-Service, HTTP-Post. [*]_

.. [*] https://www.elastic.co/guide/en/kibana/current/watcher-getting-started.html
.. [*] https://www.elastic.co/guide/en/x-pack/current/xpack-alerting.html


APIs to make components working
===============================

Beside the APIs mentioned before there are some more to make components up and running within the system.
The following chapters describes some of them.

Docker Engine
-------------

Docker provides an API for interacting with the Docker daemon (called the Docker Engine API), as well as SDKs for Go and Python. The SDKs allow you to build and scale Docker apps and solutions quickly and easily. If Go or Python don’t work for you, you can use the Docker Engine API directly.

The Docker Engine API is a RESTful API accessed by an HTTP client such as wget or curl, or the HTTP library which is part of most modern programming languages. [*]_


 .. [*] https://docs.docker.com/engine/api/version-history/


Kubernetes
----------

The Kubernetes API  serves as the foundation for the declarative configuration schema for the system. The kubectl command-line tool can be used to create, update, delete, and get API objects. [*]_

.. [*] https://kubernetes.io/docs/concepts/overview/kubernetes-api/


Traefik reverse proxy
---------------------

Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need. [*]_

 .. [*] https://docs.traefik.io/


Rancher
-------

Rancher is an open source software platform that enables organizations to run and manage Docker and Kubernetes in production. With Rancher, organizations no longer have to build a container services platform from scratch using a distinct set of open source technologies. Rancher supplies the entire software stack needed to manage containers in production. [*]_

.. [*] https://rancher.com/docs/rancher/v1.6/en/api/v2-beta/


Security
--------

Enabling the API will expose all configuration elements, including sensitive data.

It is not recommended in production, unless secured by authentication and authorizations.

A good sane default (but not exhaustive) set of recommendations would be to apply the following protection mechanism:

At application level: enabling HTTP Basic Authentication
At transport level: NOT exposing publicly the API's port, keeping it restricted over internal networks (restricted networks as in https://en.wikipedia.org/wiki/Principle_of_least_privilege). [*]_

 .. [*] https://docs.traefik.io/configuration/api/

 
MOSQUITTO
---------

It is recommended to run MOSQUITTO on a server environment that allows to link easy with other components of the system. To get further information see: [*]_

 .. [*] https://github.com/Flex4Apps/mosquitto

