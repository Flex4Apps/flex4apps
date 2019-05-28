####################################
API and data flow
####################################

There are various api information for the different components in the Flex4Apps framework.

As usually APIs a version dependend. Thus we link to the API definitions rather than integrating them into the documentation.


Docker Engine
==============

Docker provides an API for interacting with the Docker daemon (called the Docker Engine API), as well as SDKs for Go and Python. The SDKs allow you to build and scale Docker apps and solutions quickly and easily. If Go or Python don’t work for you, you can use the Docker Engine API directly.

The Docker Engine API is a RESTful API accessed by an HTTP client such as wget or curl, or the HTTP library which is part of most modern programming languages. [*]_


 .. [*] https://docs.docker.com/engine/api/version-history/


Kubernetes
==========
The Kubernetes API  serves as the foundation for the declarative configuration schema for the system. The kubectl command-line tool can be used to create, update, delete, and get API objects. [*]_

.. [*] https://kubernetes.io/docs/concepts/overview/kubernetes-api/


Traefik reverse proxy
=====================
Traefik is a modern HTTP reverse proxy and load balancer that makes deploying microservices easy. Traefik integrates with your existing infrastructure components (Docker, Swarm mode, Kubernetes, Marathon, Consul, Etcd, Rancher, Amazon ECS, ...) and configures itself automatically and dynamically. Pointing Traefik at your orchestrator should be the only configuration step you need. [*]_

 .. [*] https://docs.traefik.io/


Rancher
=======
Rancher is an open source software platform that enables organizations to run and manage Docker and Kubernetes in production. With Rancher, organizations no longer have to build a container services platform from scratch using a distinct set of open source technologies. Rancher supplies the entire software stack needed to manage containers in production. [*]_

.. [*] https://rancher.com/docs/rancher/v1.6/en/api/v2-beta/


Security
========

Enabling the API will expose all configuration elements, including sensitive data.

It is not recommended in production, unless secured by authentication and authorizations.

A good sane default (but not exhaustive) set of recommendations would be to apply the following protection mechanism:

At application level: enabling HTTP Basic Authentication
At transport level: NOT exposing publicly the API's port, keeping it restricted over internal networks (restricted networks as in https://en.wikipedia.org/wiki/Principle_of_least_privilege). [*]_


 .. [*] https://docs.traefik.io/configuration/api/
