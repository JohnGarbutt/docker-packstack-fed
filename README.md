# Docker image for Packstack + FreeIPA + Keycloak

## Install

To build the image:

    docker image build -t packstack-fed .

To run things:

    docker run -dt --name packstack-fed packstack-fed

To explore try:

    docker exec -it packstack-fed bash

## Dependency

You might find this a good way to get a packstack installed OpenStack:

    git clone https://github.com/JohnGarbutt/vagrant-packstack
    cd vagrant-packstack

    virtualenv .venv
    . .venv/bin/activate
    pip install -r requirements.txt

    virtualbox plugin install vagrant-hostmanager vagrant-timezone
    VBoxManage natnetwork add --netname packstack --network 172.16.1.0/24 --enable

    vagrant up
