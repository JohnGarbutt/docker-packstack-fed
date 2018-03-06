FROM centos:7

LABEL maintainer="StackHPC"

RUN yum makecache fast \
    && yum -y install epel-release \
    && yum -y install centos-release-openstack-pike \
    && yum -y update \
    && yum -y install \
        openstack-packstack \
        java-1.8.0-openjdk.x86_64 \
        freeipa-server \
        ipa-client \
        keycloak-httpd-client-install \
        mod_auth_mellon \
        mod_auth_gssapi \
        mod_lookup_identity \
        openstack-utils \
    && yum clean all \
    && rm -rf /var/cache/yum

# Install Keycloak
# https://access.redhat.com/solutions/3010401

RUN yum -y install unzip

RUN mkdir -p /opt/keycloak/keycloak-3.4.3.Final/ \
    && curl -O https://downloads.jboss.org/keycloak/3.4.3.Final/keycloak-3.4.3.Final.zip \
    && unzip keycloak-3.4.3.Final.zip -d /opt/keycloak/

EXPOSE 8080
EXPOSE 8443
EXPOSE 9990

EXPOSE 8480
EXPOSE 443

# for development setup, create self-signed cert
RUN mkdir -p /opt/keycloak/certificate/ \
    && keytool -genkey -alias keycloak.fed.local -keyalg RSA \
               -keystore keycloak.jks -validity 10950 \
               -noprompt -storepass password -keypass password \
               -dname "CN=keycloak.stackhpc.com, OU=ID, O=StackHPC, L=Cambridge, S=Cambs, C=GB"\
    && mv keycloak.jks /opt/keycloak/certificate/

COPY standalone.xml /opt/keycloak/keycloak-3.4.3.Final/standalone/configuration/standalone.xml
COPY setup.sh /opt/keycloak/keycloak-3.4.3.Final/setup.sh

RUN /opt/keycloak/keycloak-3.4.3.Final/setup.sh

#CMD /bin/bash
CMD /opt/keycloak/keycloak-3.4.3.Final/bin/standalone.sh -b=0.0.0.0
