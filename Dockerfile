FROM debian:stable-20221114

ARG TZ=Asia/Shanghai

ENV TZ=${TZ}
ENV LC_ALL=C
ENV TERM=xterm
# ENV XDG_CONFIG_HOME=/root/.config

ADD config/ ${XDG_CONFIG_HOME:-/root}/
ADD pkglist /tmp/
ADD repolist /tmp/
ADD aliyun.list /etc/apt/sources.list.d/

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN ulimit -c unlimited
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
	while read pkg; do apt-get install -y "${pkg}"; done < /tmp/pkglist && \
	while read repo_url local_path; do git clone --single-branch --depth=1 "${repo_url}" "${local_path}"; done < /tmp/repolist
RUN mkdir -p /wks/{.config,.cache,.local} /wks/.local/{share,stat} /wks/.cache/vim/{swap,backup,viminfo,undo}

# FIXME: ranger preview not work when running as root
RUN sed -i "/if fm.username == 'root':/,+3 d" /usr/lib/python3/dist-packages/ranger/core/main.py

# RUN xdg-user-dirs-update
