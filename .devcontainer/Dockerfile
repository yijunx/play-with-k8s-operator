FROM golang:1.23.4

# to prevent run as root
ARG DOCKER_HOME="/opt/golang-user"
ARG DOCKER_CODE="/opt/golang-user/code"
ARG DOCKER_GROUP="golang-user"
ARG DOCKER_USER="golang-user"
ARG DOCKER_UID=5000

ENV ZSH="/opt/golang-user/.oh-my-zsh"
WORKDIR ${DOCKER_CODE}

RUN groupadd -g ${DOCKER_UID} ${DOCKER_GROUP} \
    && useradd -r -u ${DOCKER_UID} -g ${DOCKER_GROUP} -d ${DOCKER_HOME} ${DOCKER_USER} \
    && chown -R ${DOCKER_USER}:${DOCKER_GROUP} ${DOCKER_HOME}


# ENV GO_VERSION=1.21.5
# ENV CGO_ENABLED=1
# ENV GOOS=linux
# ENV GOARCH=arm64

RUN apt-get update && \
    apt-get install -y gcc && \
    apt-get install -y curl && \
    apt-get install -y git && \
    apt-get install -y postgresql-client && \
    apt-get install -y openssh-client

# RUN apt-get update
# RUN apt-get install -y wget git gcc 

# RUN wget -P /tmp "https://dl.google.com/go/go${GO_VERSION}.linux-${GOARCH}.tar.gz"
# RUN tar -C /usr/local -xzf "/tmp/go${GO_VERSION}.linux-${GOARCH}.tar.gz"
# RUN rm "/tmp/go${GO_VERSION}.linux-${GOARCH}.tar.gz"

# Install zsh, omz, plugins
RUN apt-get install -y zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN mkdir ${DOCKER_HOME}/.ssh && \
    chown -R ${DOCKER_USER} ${DOCKER_HOME}/.ssh && \
    ssh-keyscan github.com >> ${DOCKER_HOME}/.ssh/known_hosts

ENV PATH=/usr/local/go/bin:$PATH
ENV GOPRIVATE=github.com/motiong-io
# # here we add the code folder into path, then we dont need go.mod anymore
# RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

USER ${DOCKER_USER}
ENTRYPOINT [ "/bin/sh", "-c" ]