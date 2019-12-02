#!/usr/bin/env sh

set -x

# instalar o pip, caso necessário
sudo apt update && sudo apt install python-pip

# instalar o aws cli
pip install awscli --user

# exportar o diretório de binários do pip para o usuário local para o PATH
echo 'export PATH=~/.local/bin:$PATH' >> ~/.bashrc
