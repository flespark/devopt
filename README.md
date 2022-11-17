# Devopt
---
A docker based linux kernel developing toolkit，include neccessary pacakge,
basic software configuration(vim, tmux, bash), and relative git repo dependency.

### Usage

1. build it:

   `docker build -t devopt:v1 .`

2. download kernel source in host:

   `sudo apt install -y kernel-headers-$(uname -r)-$(uname -m) kernel-image-$(uname -r)-$(uname -m)`

3. start docker with local kernel source mounted:

   `docker run -v /lib/modules:/lib/modules -v /usr/src:/usr/src -it devopt:v1`

