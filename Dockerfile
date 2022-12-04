FROM debian:stable-20221114

USER root

ARG TZ=Asia/Shanghai

ENV TZ ${TZ}
ENV LC_ALL=C
ENV TERM=screen
ENV XDG_CONFIG_HOME=/root

ADD config/ ${XDG_CONFIG_HOME}/
ADD pkglist /tmp/
ADD repolist /tmp/
ADD sources.list /etc/apt/

USER root
WORKDIR ${XDG_CONFIG_HOME}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN ulimit -c unlimited && mkdir -p /var/crash && \
	echo "/var/crash/%e-%p-%t.coredump" > /proc/sys/kernel/core_pattern
RUN apt-get update && \
	while read pkg; do apt-get install -y "${pkg}"; done < /tmp/pkglist && \
	while read repo_url local_path; do git clone --single-branch --depth=1 "${repo_url}" "${local_path}"; done < /tmp/repolist

# RUN xdg-user-dirs-update
