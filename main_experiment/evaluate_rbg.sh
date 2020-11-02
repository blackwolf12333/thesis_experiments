#!/usr/bin/env bash
# author: Peter Maatman <p.q.maatman@students.uu.nl>
# License: Apache 2.0

set -e

# obtain the directory the bash script is stored in
DIR=$(cd $(dirname $0); pwd)
ROOT=$DIR/../

LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$ROOT/RBGParser"

model_file=$ROOT/models/ewt_english/ewt_standard_labeled.model
test_files=( $ROOT/training_data/english/en_ewt-ud-test.conllx $ROOT/data/sentences.conll.no_punct )

rm -rf $DIR/test_out_rbg

mkdir -p $DIR/test_out_rbg

for test_file in "${test_files[@]}"
do
	test_out_file=$DIR/test_out_rbg/$(basename $test_file).$(basename $model_file).out

	# We need to be in the correct directory for java to find the main class
	cd $ROOT/RBGParser
	java -classpath "bin:$ROOT/RBGParser/lib/trove.jar" \
		-Xmx32000m parser.DependencyParser \
		model-file:$model_file \
		test test-file:$test_file \
		label:true \
		output-file:$test_out_file | grep -E -e "UAS=0\.[0-9]*" | awk '{split($0,a,"="); split(a[2], b, " "); print b[1] }'
	cd ..
done
