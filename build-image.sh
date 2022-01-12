#!/bin/bash

echo ""
sudo docker rmi heiheiyoyo/hadoop:1.0 &>/dev/null
echo -e "\nbuild docker hadoop image\n"
sudo docker build -t heiheiyoyo/hadoop:1.0 .

echo ""