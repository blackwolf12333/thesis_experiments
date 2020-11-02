#!/usr/bin/env bash

set -e

DIR=$(cd $(dirname $0); pwd)

cd RBGParser

LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:."

mkdir -p $DIR/models/ewt_english

java -classpath "bin:lib/trove.jar" -Xmx16000m parser.DependencyParser \
	model-file:$DIR/models/ewt_english/ewt_standard_labeled.model \
	train train-file:$DIR/training_data/english/en_ewt-ud-train.conllx \
	test test-file:$DIR/training_data/english/en_ewt-ud-test.conllx \
	label:true thread:4 model:standard
