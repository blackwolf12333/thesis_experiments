#!/usr/bin/env bash

set -eu

DIR=$(cd $(dirname $0); pwd)

cd IncTransitionParser

java -jar target/scala-2.12/rbgparser-assembly-1.0.jar \
	--train --augment-loss --train-file=$DIR/training_data/english/en_ewt-ud-train.conllx \
	--out-model-file=$DIR/models/ewt_english/en_ewt_pretra_augment-loss.model \
	--validation-file=$DIR/training_data/english/en_ewt-ud-test.conllx \
	--lstm-opts --nouse-first-order-scorer
