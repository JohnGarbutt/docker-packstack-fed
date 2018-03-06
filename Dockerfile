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

# for development setup, create self-signed cert
RUN mkdir -p /opt/keycloak/certificate/
#    && keytool -genkey -alias keycloak.fed.local -keyalg RSA -keystore keycloak.jks -validity 10950 \
#    && cp keycloak.jks /opt/keycloak/certificate/

#COPY standalone.xml /opt/keycloak/keycloak-3.4.3.Final/standalone/configuration/standalone.xml
#
#RUN bash /opt/keycloak/keycloak-2.4.0.Final/bin/standalone.sh -b=0.0.0.0 & \
#    && /opt/keycloak/keycloak-2.4.0.Final/bin/add-user-keycloak.sh -r master -u admin -p password \
#    && bash kill %1

CMD /bin/bash
