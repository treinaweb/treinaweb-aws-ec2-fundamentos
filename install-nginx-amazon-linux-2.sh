#!/usr/bin/env sh

set -x

# acessar ec2 com a chave ssh
# ssh -i ~/.ssh/treinaweb-lab.pem ec2-user@ec2-3-90-145-121.compute-1.amazonaws.com

# instalar o nginx 
sudo amazon-linux-extras install nginx1.12

# habilitar e iniciar o serviço do nginx
sudo systemctl enable nginx.service
sudo systemctl start nginx.service
