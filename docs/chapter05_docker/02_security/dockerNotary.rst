Docker notary
=====================

Notary is a tool for publishing and managing trusted collections of content. Publishers can digitally sign collections and consumers can verify integrity and origin of content. This ability is built on a straightforward key management and signing interface to create signed collections and configure trusted publishers.

With Notary anyone can provide trust over arbitrary collections of data. Using The Update Framework (TUF) as the underlying security framework, Notary takes care of the operations necessary to create, manage, and distribute the metadata necessary to ensure the integrity and freshness of your content. [*]_


.. [*] https://docs.docker.com/notary/getting_started/


Security aspects
---------------------

As the virtualisation platform Docker becomes more and more widely adopted, it becomes increasingly important to secure images and containers throughout their entire lifecycle. Docker Notary is a component introduced with Docker Engine 1.8 that aims at securing the “last mile” of this lifecycle (image distribution from the registry to the Docker client), by verifying the image publisher as well as image integrity. The verification is based on digital signatures created with multiple keys. Since an in-depth security analysis of key compromise scenarios in the context of Notary seems to be missing in scientific literature, an extensive attack model is developed in this work. Based on the model, it is argued that particularly devastating attacks can be prevented by storing some of the signing keys in a hardware vault, a Secure Element. It is described how an interface can be integrated into the Notary codebase that makes this possible. It is also shown that Notary’s signing process needs to be extended to prevent an attacker from exploiting one particular Notary component, the Notary server, to create arbitrary signatures on his behalf.[*]_


.. [*] Docker Notary’s management of signing keys - An analysis of key compromise and integrability of a Secure Element (Simon Wessling, 2018)
