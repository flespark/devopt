# Devopt

A docker based linux kernel developing toolkit，include neccessary pacakges,
basic software configuration(vim, tmux, bash), and relative git repo
dependencies.

### Usage

1. build locally after clone:

   `docker build -t devopt:latest .`

   or direct pull from aliyun docker hub:

   `docker pull registry.cn-hangzhou.aliyuncs.com/flespark/devopt:latest`

2. start docker with workspace mount to docker:

   `docker run -v <your_workspace>:/wks -it devopt:latest`

