#!/usr/bin/env bash

# this file is part of the training pipeline, to be executed before
# training the models for the parsers.

set -eu

DIR=$(cd $(dirname $0); pwd)

mkdir -p $DIR/training_data/english/

# Convert conllu files from the UD_English-EWT dataset to conllx format
# so the parsers can work with it.

$DIR/tools/conllu_to_conllx.pl < $DIR/UD_English-EWT/en_ewt-ud-train.conllu > $DIR/training_data/english/en_ewt-ud-train.conllx
$DIR/tools/conllu_to_conllx.pl < $DIR/UD_English-EWT/en_ewt-ud-test.conllu > $DIR/training_data/english/en_ewt-ud-test.conllx
