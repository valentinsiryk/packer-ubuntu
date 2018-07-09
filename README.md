# Packer Ubuntu

[![Build Status](https://travis-ci.org/valentinsiryk/packer-ubuntu.svg?branch=master)](https://travis-ci.org/valentinsiryk/packer-ubuntu)


## Example

```sh
VM_NAME=example-vm OUTPUT_DIRECTORY=/path/to/vm SSH_PUBLIC_KEY="$HOME/.ssh/id_rsa.pub" BUILD_MEM=2048 BUILD_CPUS=2 POST_MEM=4096 POST_CPUS=2 ./build.sh
```
