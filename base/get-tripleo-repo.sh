#!/bin/bash

get_tripleo_repo(){
  # Cameron.C: Download python2-tripleo-repos-<version>.el7.centos.noarch.rpm
  TRIPLEO_REPOS=$(curl -L --silent $BASE | grep python2-tripleo-repos | awk -F "href" {'print $2'} | awk -F '"' {'print $2'})
  echo "$TRIPLEO_REPOS"
}

install_repo(){
  yum localinstall -y $BASE$TRIPLEO_REPOS
}

BASE=https://trunk.rdoproject.org/centos7/current/

get_tripleo_repo
install_repo
