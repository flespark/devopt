# Devopt

A docker based linux kernel developing toolkit，include neccessary pacakges,
basic software configuration(vim, tmux, bash), and relative git repo
dependencies.

### Usage

1. build it locally:

   `docker build -t devopt:stable .`

   or pull from docker mirror:

   `docker pull pull registry.cn-hangzhou.aliyuncs.com/flespark/devopt:stable`

2. download kernel source in host:

   `sudo apt install -y kernel-headers-$(uname -r)-$(uname -m) kernel-image-$(uname -r)-$(uname -m)`

3. start docker with local kernel source mounted:

   `docker run -v /lib/modules:/lib/modules -v /usr/src:/usr/src -v
   /usr/lib/modules:/usr/lib/modules -it
   devopt:stable`

