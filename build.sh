#!/usr/bin/env bash

sudo apt-get install \
  debootstrap \
  kpartx \
  lftp \
  qemu-utils \
  squashfs-tools

mkdir -p output

virtualenv -p python3 .venv
source .venv/bin/activate
pip3 install diskimage-builder

export ELEMENTS_PATH=./elements

export DIB_RELEASE=focal

export DIB_CLOUD_INIT_DATASOURCES="ConfigDrive, OpenStack"

export DIB_DEV_USER_PASSWORD=password
export DIB_DEV_USER_PWDLESS_SUDO=Yes
export DIB_DEV_USER_SHELL=/bin/bash
export DIB_DEV_USER_USERNAME=ubuntu

export DIB_LOCAL_CONFIG_USERNAME=ubuntu

disk-image-create \
  block-device-ironic \
  cloud-init-datasources \
  devuser \
  dhcp-all-interfaces \
  enable-serial-console \
  openssh-server \
  ubuntu \
  vm \
  -o output/ironic-ubuntu-focal-$(date +%Y-%m).qcow2 | tee ironic-ubuntu-focal-$(date +%Y-%m).log
