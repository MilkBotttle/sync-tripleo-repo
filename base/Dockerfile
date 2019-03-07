FROM centos:7
MAINTAINER Cameron.C

RUN yum install yum-utils -y
COPY get-tripleo-repo.sh /root/get-tripleo-repo.sh
RUN bash /root/get-tripleo-repo.sh
