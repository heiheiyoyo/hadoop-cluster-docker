## Run Hadoop Cluster within Docker Containers

*fork from kiwenlau/hadoop-cluster-docker*

**upgrade ubuntu to 20.04 and Hadoop to 3.3.1**

![build-passing](https://img.shields.io/badge/build-passing-brightgreen.svg)
![license-apache](https://img.shields.io/badge/license-Apache-blue.svg)
![hadoop-3.3.1](https://img.shields.io/badge/hadoop-3.3.1-blue.svg)
![ubuntu-20.04](https://img.shields.io/badge/ubuntu-20.04-orange.svg)

- Blog: [Run Hadoop Cluster in Docker Update](http://kiwenlau.com/2016/06/26/hadoop-cluster-docker-update-english/)
- 博客: [基于Docker搭建Hadoop集群之升级版](http://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/)


![alt tag](https://raw.githubusercontent.com/kiwenlau/hadoop-cluster-docker/master/hadoop-cluster-docker.png)


### 3 Nodes Hadoop Cluster


##### 1. clone github repository

```
git clone https://github.com/heiheiyoyo/hadoop-cluster-docker
```


##### 2. build docker image

```
cd hadoop-cluster-docker
sudo ./build-image.sh
```

##### 3. create hadoop network

```
sudo docker network create --driver=bridge hadoop
```

##### 4. start container

```
sudo ./start-container.sh
```

**output:**

```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
root@hadoop-master:~# 
```
- start 3 containers with 1 master and 2 slaves
- you will get into the /root directory of hadoop-master container

##### 5. start hadoop

```
./start-hadoop.sh
```

##### 6. run wordcount

```
./run-wordcount.sh
```

**output**

```
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker    1
Hadoop    1
Hello    2
```

### Arbitrary size Hadoop cluster

##### 1. pull docker images and clone github repository

do 1~3 like section A

##### 2. rebuild docker image

```
sudo ./resize-cluster.sh 5
```
- specify parameter > 1: 2, 3..
- this script just rebuild hadoop image with different **slaves** file, which pecifies the name of all slave nodes


##### 3. start container

```
sudo ./start-container.sh 5
```
- use the same parameter as the step 2

##### 4. run hadoop cluster 

do 5~6 like section A

