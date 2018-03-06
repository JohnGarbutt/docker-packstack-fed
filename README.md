# Docker image for Packstack + FreeIPA + Keycloak

To build the image:

   docker image build -t packstack-fed .

To run things:

   docker run -dt --name packstack-fed packstack-fed

To explore try:

   docker exec -it packstack-fed bash
