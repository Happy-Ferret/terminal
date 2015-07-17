FROM golang:cross

# To get zip and apt-transport-https
RUN apt-get update

# buildkite-agent for artifact management
RUN apt-get install -y apt-transport-https
RUN echo deb https://apt.buildkite.com/buildkite-agent stable main > /etc/apt/sources.list.d/buildkite-agent.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 32A37959C2FA5C3C99EFBC32A79206696452D198
RUN apt-get update

# Install buildkite-agent
RUN apt-get install -y buildkite-agent

# For dealing with Go deps
RUN go get github.com/tools/godep

# For creating Github releases
RUN go get github.com/buildkite/github-release

# For building packages
RUN apt-get install build-essential dh-make

# For packaging and pushing to packagecloud
RUN apt-get install ruby && gem install fpm-cookery package_cloud

# Zip for win and osx releases
RUN apt-get install -y zip

RUN mkdir -p /go/src/github.com/buildkite/terminal
ADD . /go/src/github.com/buildkite/terminal

WORKDIR /go/src/github.com/buildkite/terminal
