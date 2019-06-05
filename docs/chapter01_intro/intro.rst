##################
Introduction
##################

Management summary
==================

Goal of this page is to provide a manual and scripts to

* Get an reliable open source infrastructure for your business / environment
* Reproducibly running in less than 1 hour
* At a operating cost of less than 20 € per month

About the Flex4Apps
===================

The convergence of cloud, communication and IoT infrastructure plus the trend towards virtual applications (e.g. migrating software to the cloud) create new challenges for application developers and infrastructure providers. The resulting systems are complex with dynamic resources hiding possible problems. This creates a requirement for flexible monitoring and optimization methods. The Flex4Apps_ project addresses the challenges of monitoring and optimizing large, distributed, cyber-physical systems. The goal of the project is to provide a solution to manage the high data volumes and complexity of system monitoring whilst disturbing the target system as little as possible.

The demonstrator is setup using the f4a.me domain.

High level architecture
=======================

Goal of the project is not to worry about "hardware" while operating an infrastructure. Currently servers must be rented / purchased. They need to be maintained and in case something breaks, the operation of the overlaying service / system is impacted.

Docker_ swarm is one solution to achieve this abstraction layer. For this approach three or more (virtual) servers are required. RAM and CPU power is key, SSDs help to improve the performance.

Even though docker runs on many platforms we decided to operate based on an Ubuntu 16.04 LTS. Windows is also possible but has some drawbacks for the infrastructure we build. Secondly we look at Kubernetes.

Docker only achieves the independence with regards to the stateless execution of services like webservers, mail servers and other services. To provide persistent storage a file server / cluster and a database server is needed, which turns out to be the most difficult challenge.

Alternatively, a similar Flex4Apps based system can be deployed using serverless technologies such as AWS Lambda_ or Azure Cloud Functions. Such a deployment is to be considered if the cost of renting servers is too high or elasticity needs demand a different approach. While it does depend on the use case, please note that the resulting system will be a little less portable than the Docker architectures.

.. _Docker: http://www.docker.com
.. _Lambda: https://aws.amazon.com/lambda/
.. _Flex4apps: https://www.flex4apps-itea3.org
