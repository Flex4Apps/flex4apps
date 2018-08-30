Automatic server updates & reboots
===================================

A cron job can take care of that::

    echo "0 3 * * * (apt-get update & apt-get -y upgrade && apt autoclean -y && apt autoremove -y)" >> mycron && \
    echo "0 4 * * 4 reboot" >> mycron && \
    crontab -u root mycron && \
    rm mycron && \
    crontab -l


Make sure you have the right timezone set::

    timedatectl set-timezone Europe/Berlin

To check the status and list the timezones::

    timedatectl status
    timedatectl list-timezones
