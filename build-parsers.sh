#!/usr/bin/env bash

set -e

# This script can either be executed in an environment that is setup
# with all the required dependencies for the parsers that we are building
# or inside the docker image that is also provided with this repo, which
# includes all dependencies that are required for building.

# RBGParser

cd RBGParser/lib/SVDLIBC
make

# leaves us in RBGParser/
cd ../../

LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:."

# this can be overwritten from outside this script if needed, this default
# value is the correct location in the docker image.
JNI_PATH="/usr/lib/jvm/java-11-openjdk-amd64/include"

javac -encoding UTF-8 -d bin -sourcepath src -classpath "lib/trove.jar" src/parser/DependencyParser.java


javac -h . -classpath bin src/utils/SVD.java
g++ -fPIC -shared -I./lib/SVDLIBC/ -I${JNI_PATH} -I${JNI_PATH}/linux libSVD.cpp ./lib/SVDLIBC/libsvd.a -O2 -o libSVDImp.so
g++ -fPIC -shared -I./lib/SVDLIBC/ -I${JNI_PATH} -I${JNI_PATH}/linux libSVD.cpp ./lib/SVDLIBC/libsvd.a -O2 -o libSVDImp.jnilib

# Go back to repository root, we are done building RBGParser
cd ../

# PreTra

# We assume that if the directory exists, this has been run before and we skip
# building dynet again
if [ ! -d dynet ] then
	git clone https://github.com/clab/dynet
	cd dynet
	mkdir build
	cd build
	cmake .. -DEIGEN3_INCLUDE_DIR=/usr/include/eigen3 -DENABLE_SWIG=ON
	make -j 2
	cd ../../

	cp ../dynet/build/contrib/swig/dynet_swigJNI_dylib.jar ./IncTransitionParser/lib/
	cp ../dynet/build/contrib/swig/dynet_swigJNI_scala_2.11.jar ./IncTransitionParser/lib/
fi

cd IncTransitionParser 

sbt assembly

cd ..
