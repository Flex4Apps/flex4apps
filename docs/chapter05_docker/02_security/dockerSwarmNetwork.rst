Docker swarm networks
----------------------

Overlay networking for Docker Engine swarm mode comes secure out of the box. The swarm nodes exchange overlay network information using a gossip protocol. By default the nodes encrypt and authenticate information they exchange via gossip using the AES algorithm in GCM mode. Manager nodes in the swarm rotate the key used to encrypt gossip data every 12 hours. [*]_


.. [*] https://docs.docker.com/v17.09/engine/userguide/networking/overlay-security-model/
