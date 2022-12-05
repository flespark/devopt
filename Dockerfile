FROM debian:stable-20221114

ARG TZ=Asia/Shanghai

ENV TZ=${TZ}
ENV LC_ALL=C
ENV TERM=xterm

ADD config/ ${GITHUB_WORKSPACE:-/root/}
ADD pkglist /tmp/
ADD repolist /tmp/
ADD sources.list /etc/apt/

WORKDIR ${GITHUB_WORKSPACE:-/root}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN ulimit -c unlimited
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
	while read pkg; do apt-get install -y "${pkg}"; done < /tmp/pkglist && \
	while read repo_url local_path; do git clone --single-branch --depth=1 "${repo_url}" "${local_path}"; done < /tmp/repolist

# RUN xdg-user-dirs-update
