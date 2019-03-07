FROM centos-syncrepo:base
MAINTAINER Cameron.C

RUN tripleo-repos -b rocky current
ADD $PWD/files/tripleo-centos-ceph-luminous.repo /etc/yum.repos.d/.
