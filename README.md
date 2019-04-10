# Sync TripleO repos with container
## Build image
 Build base image first if it not exist.
* Base
```
cd base
docker build --network host -t centos-syncrepo:base .
```
* Pike
```
cd Pike
docker build --network host -t centos-syncrepo:pike .
```
* Queens
```
cd Queens
docker build --network host -t centos-syncrepo:queens .
```
* Rocky
```
cd Rocky
docker build --network host -t centos-syncrepo:rocky .
```

## Syncrepo
Run container and sync pkgs from remote repo, the pkgs save in `$PWD/[version]-pkgs`.
* Pike
```
mkdir pike-pkgs
docker run --network host --name queens-syncrepo -d -v $PWD/pike-pkgs:/root/pike-pkgs centos-syncrepo:pike reposync -l -n -p /root/pike-pkgs
```
* Queens
```
mkdir queens-pkgs
docker run --network host --name queens-syncrepo -d -v $PWD/queens-pkgs:/root/queens-pkgs centos-syncrepo:queens reposync -l -n -p /root/queens-pkgs
```
* Rocky
```
mkdir rocky-pkgs
docker run --network host --name rocky-syncrepo -d -v $PWD/rocky-pkgs:/root/rocky-pkgs centos-syncrepo:rocky reposync -l -n -p /root/rocky-pkgs
```
## Create repofile
* local repo
This will run `createrepo` generate repository xml, then create repo file in `/etc/yum.repos.d`, for local use this repository install undercloud.
```
bash scripts/generate-local-file.sh [packages absolute path]

# example
bash scripts/generate-local-file.sh $PWD/rocky-pkgs
```
* http repos
This will create a repofile `/var/lib/ironic/httpboot/uc-ooo.repo` base on use undercloud http server for overcloud node usage.
```
bash scripts/generate-http-repo-file.sh [packages absolute path] [undercloud_local_ip]
# $1 is tripleo-pkgs path (required)
# $2 is undercloud ip (required)
```
