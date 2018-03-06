#!/bin/bash

pushd /opt/keycloak/keycloak-3.4.3.Final/bin

./standalone.sh -b=0.0.0.0 &
sleep 5

./add-user-keycloak.sh -r master -u admin -p password
sleep 1
kill %1
sleep 2

popd
