#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
sudo docker rm -f hadoop-master &>/dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
				-p 2222:22 \
                --name hadoop-master \
                --hostname hadoop-master \
                heiheiyoyo/hadoop:1.0 


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &>/dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                heiheiyoyo/hadoop:1.0 
	i=$(( $i + 1 ))
done

echo -e "\nYou can add these content to your hosts file, usually located in /etc/hosts\n\n"
sudo docker exec -it hadoop-master ifconfig eth0 |\
	grep inet |awk '{print $2}' |\
	xargs -I{} echo {} hadoop-master
i=1
while [ $i -lt $N ]
do
	sudo docker exec -it hadoop-slave$i ifconfig eth0 |\
		grep inet |awk '{print $2}' |\
		xargs -I{} echo {} hadoop-slave$i
	i=$(( $i + 1 ))
done


echo -e "\n\n"

echo -e "Press [Enter] to Enter the Container"
echo -e "You can also enter the container using command:"
echo -e "\tssh root@localhost -p 2222"
echo -e "and the password is root"

read -n 1

# get into hadoop master container
sudo docker exec -it hadoop-master bash