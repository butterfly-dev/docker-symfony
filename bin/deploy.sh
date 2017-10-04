#!/bin/bash

if ! [ -x "$(command -v docker)" ] && ! [ -x "$(command -v docker-compose)" ] && ! [ -x "$(command -v git)" ]; then
    echo "#################################################"
    echo "###########   Install Dependencies    ###########"
    echo "#################################################"
    echo ""

    bin/initialize-cloud-machine.sh

    echo ""
    echo "#################################################"
    echo "###########         Install OK        ###########"
    echo "#################################################"
else
    echo "#################################################"
    echo "###########         Deploy App        ###########"
    echo "#################################################"
    echo ""

    git clone https://github.com/butterfly-dev/docker-symfony
    cd docker-symfony

    cp .env.prod .env

    make run
    bin/install.sh

    echo ""
    echo "#################################################"
    echo "###########         Deploy OK         ###########"
    echo "#################################################"
fi
