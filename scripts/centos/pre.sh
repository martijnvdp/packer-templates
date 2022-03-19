#!/bin/bash -eux
dnf -y update
dnf -y install python3
python3 -m pip install --upgrade pip
alternatives --set python /usr/bin/python3
pip3 install ansible