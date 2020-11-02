FROM ubuntu:20.10

# general dependencies
RUN apt-get update && apt-get install -y build-essential openjdk-11-jdk

# PreTra uses the sbt build system
RUN apt-get install -y curl \
    && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add \
	&& apt-get update \
    && apt-get install -y sbt

# PreTra requires dynet to build, dynet needs these dependencies
RUN apt-get install -y swig3.0 cmake libeigen3-dev zip

# We use bc in our evaluation scripts
RUN apt-get install -y bc
