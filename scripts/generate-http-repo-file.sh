#!/bin/sh

set -x

if [[ "x$1" == "x" || "x$2" == "x" ]];
then
  echo "Usage: generate-http-repo-file.sh REPODIR UNDERCLOUD_PXE_ADDRESS"
  echo
  exit 1
fi

REPODIR=$1
ADDRESS=$2
REPO_FILE_NAME="00-ooo.repo"
WORKERS=`nproc --all`
REPOFILE="/etc/yum.repos.d/$REPO_FILE_NAME"
#`basename $REPODIR`"

ls $REPOFILE >> /dev/null 2>&1
if [ "$?" -eq 0 ];
then
  echo "Remove old $REPOFILE"
  echo
  rm $REPOFILE >> /dev/null 2>&1
fi

echo "Create reposiry repodata."
createrepo -v --worker $WORKERS $REPODIR
echo

echo "Backup old file, and remove exist."
cp /etc/yum.repos.d /etc/yum.repos.d.backup
rm -rf /etc/yum.repos.d/*
echo

echo "Create repo file."
touch $REPO_FILE
for DIR in `find $REPODIR -maxdepth 1 -mindepth 1 -type d`; do
    echo -e "[`basename $DIR`]" >> $REPOFILE
    echo -e "name=`basename $DIR`" >> $REPOFILE
    echo -e "baseurl=http://$ADDRESS:8088/`basename $REPODIR`/" >> $REPOFILE
    echo -e "enabled=1" >> $REPOFILE
    echo -e "gpgcheck=0" >> $REPOFILE
    echo >> $REPOFILE
done;
cp $REPOFILE /var/lib/ironic/httpboot

