# Docker image for Packstack + FreeIPA + Keycloak

## Install

To build the image, run it, and test it out:

    docker image build -t keycloak_test .
    # docker stop keycloak_test && docker rm keycloak_test
    docker run -dt --name keycloak_test keycloak_test
    docker exec -it keycloak_test bash

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
