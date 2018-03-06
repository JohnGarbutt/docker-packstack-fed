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

RUN packstack --allinone


