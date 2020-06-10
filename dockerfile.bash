#!/bin/bash

pushd /tmp
git clone https://github.com/demers/docker-ubuntu.git
popd

cp -f /tmp/docker-ubuntu/Dockerfile .

sed -i 's/PROJECTNAME=UBUNTU/PROJECTNAME=ATOM/g' Dockerfile

AJOUTER_ICI=$(cat Dockerfile.after)

sed -i -e '/# AJOUTER_ICI/r Dockerfile.after' Dockerfile

#sed -i "s/# AJOUTER_ICI/$AJOUTER_ICI/g" Dockerfile