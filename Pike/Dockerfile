FROM centos-syncrepo:base
MAINTAINER Cameron.C

RUN tripleo-repos -b rocky current
COPY ../files/tripleo-centos-ceph-luminous.repo /etc/yum.repos.d/.
