FROM centos-syncrepo:base
MAINTAINER Cameron.C

RUN tripleo-repos -b pike current
ADD $PWD/files/tripleo-centos-ceph-jewel.repo /etc/yum.repos.d/.
