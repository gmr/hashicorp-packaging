FROM ubuntu:bionic

RUN apt-get update -q \
 && apt-get install -y -qq build-essential curl ruby ruby-dev rubygems unzip \
 && gem install --no-ri --no-rdoc fpm \
 && mkdir -p /build

WORKDIR /build

CMD [ "make", "ubuntu" ]
