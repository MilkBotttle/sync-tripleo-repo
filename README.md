# Sync TripleO repos with container
# Environment
* docker version 18.09.3
# Build image
* Base image for every version
```
docker build -t centos-syncrepo:base -f base/Dockerfile .
```
* Queens
```
docker build -t centos-syncrepo:queens -f Queens/Dockerfile .
```
* Rocky
```
docker build -t centos-syncrepo:rocky -f Rocky/Dockerfile .
```

# Syncrepo
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
