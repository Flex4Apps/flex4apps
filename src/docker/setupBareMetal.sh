#!/bin/bash

echo "██╗███╗   ██╗██╗████████╗██╗ █████╗ ████████╗██╗███╗   ██╗ ██████╗      ██████╗██╗      ██████╗ ██╗   ██╗██████╗              ";
echo "██║████╗  ██║██║╚══██╔══╝██║██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝     ██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗             ";
echo "██║██╔██╗ ██║██║   ██║   ██║███████║   ██║   ██║██╔██╗ ██║██║  ███╗    ██║     ██║     ██║   ██║██║   ██║██║  ██║             ";
echo "██║██║╚██╗██║██║   ██║   ██║██╔══██║   ██║   ██║██║╚██╗██║██║   ██║    ██║     ██║     ██║   ██║██║   ██║██║  ██║             ";
echo "██║██║ ╚████║██║   ██║   ██║██║  ██║   ██║   ██║██║ ╚████║╚██████╔╝    ╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝    ██╗██╗██╗";
echo "╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝      ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝     ╚═╝╚═╝╚═╝";
echo "                                                                                                                              ";


# on which interface is the public ip - usually eth0 or en0
pubNetInterface=eth0


##### nothing to do below here
pubip=`ifconfig $pubNetInterface | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
echo public ip = $pubip

# which other IPs are part of the swarm (dont change the first entry)
swarmips=("$pubip")


# setting up /etc/host to reflect all gluster clients
COUNTER=0
for i in "${swarmips[@]}"
do
   :
   echo $i gluster$COUNTER >> /etc/hosts
   let COUNTER=COUNTER+1
done

#upgrading the system to latest revision
apt-get update & apt-get -y upgrade && apt autoclean -y && apt autoremove -y

#installing required software
apt-get -y install git nano

#cloning flex4apps
git clone https://github.com/Flex4Apps/flex4apps.git

# installing cron to keep system up2date including reboot
echo "0 3 * * * (apt-get update & apt-get -y upgrade && apt autoclean -y && apt autoremove -y)" >> mycron && \
echo "0 4 * * 4 reboot" >> mycron && \
crontab -u root mycron && \
rm mycron && \
crontab -l

echo "██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ ";
echo "██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗";
echo "██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝";
echo "██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗";
echo "██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║";
echo "╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝";
echo "                                                 ";

#installing docker software
apt-get -y install git docker docker-compose nano
apt install -y docker.io

#create the swarm
docker swarm init --advertise-addr $pubip

#set up the docker network
docker network create --opt encrypted --driver overlay traefik-net

echo "████████╗██████╗  █████╗ ███████╗███████╗██╗██╗  ██╗";
echo "╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██╔════╝██║██║ ██╔╝";
echo "   ██║   ██████╔╝███████║█████╗  █████╗  ██║█████╔╝ ";
echo "   ██║   ██╔══██╗██╔══██║██╔══╝  ██╔══╝  ██║██╔═██╗ ";
echo "   ██║   ██║  ██║██║  ██║███████╗██║     ██║██║  ██╗";
echo "   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝";
echo "                                                    ";
mkdir -p /data/local/traefik/logs
mkdir -p /data/local/traefik/acme
docker stack deploy --compose-file /root/flex4apps/compose/traefik/docker-compose.yml traefik
docker service inspect traefik_traefik --pretty
docker stack services traefik

echo "███████╗██╗      █████╗ ███████╗████████╗██╗ ██████╗";
echo "██╔════╝██║     ██╔══██╗██╔════╝╚══██╔══╝██║██╔════╝";
echo "█████╗  ██║     ███████║███████╗   ██║   ██║██║     ";
echo "██╔══╝  ██║     ██╔══██║╚════██║   ██║   ██║██║     ";
echo "███████╗███████╗██║  ██║███████║   ██║   ██║╚██████╗";
echo "╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝ ╚═════╝";
echo "                                                    ";


#depoy the basic services
docker stack deploy --compose-file /root/flex4apps/compose/elk62/docker-compose.yml elk
docker service inspect elk_elasticsearch --pretty
docker service inspect elk_kibana --pretty
docker stack services elk

echo "███████╗██╗     ███████╗██╗  ██╗    ██╗  ██╗     █████╗ ██████╗ ██████╗ ███████╗    ";
echo "██╔════╝██║     ██╔════╝╚██╗██╔╝    ██║  ██║    ██╔══██╗██╔══██╗██╔══██╗██╔════╝    ";
echo "█████╗  ██║     █████╗   ╚███╔╝     ███████║    ███████║██████╔╝██████╔╝███████╗    ";
echo "██╔══╝  ██║     ██╔══╝   ██╔██╗     ╚════██║    ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║    ";
echo "██║     ███████╗███████╗██╔╝ ██╗         ██║    ██║  ██║██║     ██║     ███████║    ";
echo "╚═╝     ╚══════╝╚══════╝╚═╝  ╚═╝         ╚═╝    ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝    ";
echo "                                                                                    ";
echo " ██████╗██╗      ██████╗ ██╗   ██╗██████╗                                           ";
echo "██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗                                          ";
echo "██║     ██║     ██║   ██║██║   ██║██║  ██║                                          ";
echo "██║     ██║     ██║   ██║██║   ██║██║  ██║                                          ";
echo "╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝                                          ";
echo " ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝                                           ";
echo "                                                                                    ";
echo "██╗███████╗    ██████╗ ██╗   ██╗███╗   ██╗███╗   ██╗██╗███╗   ██╗ ██████╗ ██╗       ";
echo "██║██╔════╝    ██╔══██╗██║   ██║████╗  ██║████╗  ██║██║████╗  ██║██╔════╝ ██║       ";
echo "██║███████╗    ██████╔╝██║   ██║██╔██╗ ██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗██║       ";
echo "██║╚════██║    ██╔══██╗██║   ██║██║╚██╗██║██║╚██╗██║██║██║╚██╗██║██║   ██║╚═╝       ";
echo "██║███████║    ██║  ██║╚██████╔╝██║ ╚████║██║ ╚████║██║██║ ╚████║╚██████╔╝██╗       ";
echo "╚═╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝       ";
echo "                                                                                    ";
