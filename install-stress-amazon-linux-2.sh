#!/usr/bin/env sh

set -x

# instalar o stress a partir dos pacotes extras 
sudo amazon-linux-extras install epel -y
sudo yum install stress -y

# executa o stress
stress --cpu 8 --io 4 --vm 2 --timeout 30m
