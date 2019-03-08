# Sync TripleO repos with container
## Environment
* docker version 18.09.3
## Build image
 Build base image first if it not exist.
* Base
```
docker build -t centos-syncrepo:base -f base/Dockerfile .
```
* Pike
```
docker build -t centos-syncrepo:pike -f Queens/Dockerfile .
```
* Queens
```
docker build -t centos-syncrepo:queens -f Queens/Dockerfile .
```
* Rocky
```
docker build -t centos-syncrepo:rocky -f Rocky/Dockerfile .
```

## Syncrepo
Run container and sync pkgs from remote repo, the pkgs save in `$PWD/[version]-pkgs`.
* Pike
```
mkdir pike-pkgs
docker run  --name queens-syncrepo -d -v $PWD/pike-pkgs:/root/pike-pkgs centos-syncrepo:pike reposync -l -n -p /root/pike-pkgs
```
* Queens
```
mkdir queens-pkgs
docker run  --name queens-syncrepo -d -v $PWD/queens-pkgs:/root/queens-pkgs centos-syncrepo:queens reposync -l -n -p /root/queens-pkgs
```
* Rocky
```
mkdir rocky-pkgs
docker run --name rocky-syncrepo -d -v $PWD/rocky-pkgs:/root/rocky-pkgs centos-syncrepo:rocky reposync -l -n -p /root/rocky-pkgs
```
## Create local repofile
This will run `createrepo` generate repository xml, then create repo file in `/etc/yum.repos.d`.
```
bash scripts/generate-local-file.sh [packages absolute path]

# example
bash scripts/generate-local-file.sh $PWD/rocky-pkgs
```
