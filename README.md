# Devopt

A docker based linux kernel developing toolkit，include neccessary pacakges,
basic software configuration(vim, tmux, bash), and relative git repo
dependencies.

### Usage

1. build it locally:

   `docker build -t devopt:stable .`

   or pull from docker mirror:

   `docker pull pull registry.cn-hangzhou.aliyuncs.com/flespark/devopt:stable`

2. start docker with local kernel source mounted:

   `docker run -it devopt:stable -v <project_path>:/wks`

