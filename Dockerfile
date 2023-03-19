FROM debian:stable-20221114

ARG TZ=Asia/Shanghai

ENV TZ=${TZ}
ENV LC_ALL=C
ENV CONFIG_PATH=/root

ADD config/ ${XDG_CONFIG_HOME:-/root}/
ADD pkglist /tmp/
ADD repolist /tmp/
ADD aliyun.list /etc/apt/sources.list.d/

WORKDIR $CONFIG_PATH
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
	while read pkg; do apt-get install -y "${pkg}"; done < /tmp/pkglist && \
	while read repo_url local_path; do git clone --single-branch --depth=1 "${repo_url}" "${local_path}"; done < /tmp/repolist

RUN chsh -s /bin/zsh
# RUN xdg-user-dirs-update

# NOTE: some system config move to shell init script
