FROM ubuntu:20.10

RUN apt-get update && apt-get install -y build-essential openjdk-11-jdk

RUN apt-get install -y curl \
    && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add \
	&& apt-get update \
    && apt-get install -y sbt

RUN apt-get install -y swig3.0 cmake libeigen3-dev zip

RUN apt-get install -y bc
