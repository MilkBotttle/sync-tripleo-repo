#!/bin/bash

execute_user=$(whoami)

if [ "$execute_user" -ne "root" ];then
    echo "You need root permission to run this script, use 'sudo' or root user."
    exit 1
fi

if [[ "x$1" == "x" || $1 == "help" ]];
then
    echo "Usage: generate-local-repo REPODIR"
    echo "help: print this message"
    echo "REPODIR: tripleo pkgs absolute path"
    echo
    exit 1
fi

REPODIR="$1" #/root/tripleo-pkgs
WORKERS=`nproc --all`
REPOFILE_NAME="00-local-ooo.repo"
REPOFILE="/etc/yum.repos.d/$REPOFILE_NAME"
# `basename $REPODIR`.repo

ls $REPOFILE >> /dev/null 2>&1
if [ "$?" -eq 0 ];
then
    echo "Remove old $REPOFILE"
    rm -f $REPOFILE >> /dev/null 2>&1
fi

echo "Create reposiry repodata"
createrepo -v --workers $WORKERS $REPODIR
echo

echo "Backup old repos"
cp -r /etc/yum.repos.d /etc/yum.repos.d.backup
rm -rf /etc/yum.repos.d/*

echo "Create yum repo file."
touch $REPOFILE
for DIR in `find $REPODIR -maxdepth 1 -mindepth 1 -type d`; do
    # Create in /etc/yum.repos.d
    echo -e "[`basename $DIR`]" >> $REPOFILE
    echo -e "name=`basename $DIR`" >> $REPOFILE
    echo -e "baseurl=file://$REPODIR/" >> $REPOFILE
    echo -e "enabled=1" >> $REPOFILE
    echo -e "gpgcheck=0" >> $REPOFILE
    echo -e "\n" >> $REPOFILE
done;

#test
yum clean all
yum repolist 

echo
echo "Create repo file complete"
echo "Create at:"
echo "$REPOFILE"
