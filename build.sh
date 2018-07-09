#!/bin/bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $SCRIPT_PATH

export TMPDIR="$SCRIPT_PATH/tmp"
mkdir -p $TMPDIR

VM_NAME="${VM_NAME:-bionic}"
OUTPUT_DIRECTORY="${OUTPUT_DIRECTORY:-$SCRIPT_PATH/builds/$VM_NAME}"

SSH_PUBLIC_KEY="${SSH_PUBLIC_KEY:-$HOME/.ssh/id_rsa.pub}"

BUILD_MEM="${BUILD_MEM:-1024}"
BUILD_CPUS="${BUILD_CPUS:-1}"

POST_MEM="${POST_MEM:-2048}"
POST_CPUS="${POST_CPUS:-2}"

ACTION="${ACTION:-build}"

packer $ACTION \
    -var "disk_size=20480" \
    -var "vmx_data_memsize=$BUILD_MEM" \
    -var "vmx_data_numvcpus=$BUILD_CPUS" \
    -var "vmx_data_post_memsize=$POST_MEM" \
    -var "vmx_data_post_numvcpus=$POST_CPUS" \
    -var "headless=false" \
    -var "iso_checksum_type=sha256" \
    -var "iso_name=ubuntu-18.04-server-amd64.iso" \
    -var "mirror=http://cdimage.ubuntu.com" \
    -var "mirror_directory=ubuntu/releases/18.04/release" \
    -var "preseed_path=preseed.cfg" \
    -var "vm_name=$VM_NAME" \
    -var "ssh_username=ubuntu" \
    -var "ssh_public_key_file=$SSH_PUBLIC_KEY" \
    -var "ssh_public_key_file_tmp_path=/tmp/id_rsa.pub" \
    -var "shrink_image=true" \
    -var "cleanup_os=false" \
    -var "output_directory=$OUTPUT_DIRECTORY" \
    $@ -only=vmware-iso $SCRIPT_PATH/bionic.json

