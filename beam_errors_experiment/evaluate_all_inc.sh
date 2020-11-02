#!/usr/bin/env bash
# author: Peter Maatman <p.q.maatman@students.uu.nl>
# License: Apache 2.0
#

# exit on error
set -e
# exit on use of an uninitialized variable
set -u

# obtain the directory the bash script is stored in
DIR=$(cd $(dirname $0); pwd)
ROOT=$DIR/../

beam_size=$1
models=( $ROOT/models/ewt_english/en_ewt_pretra_augment-loss.model )
test_files=( $ROOT/data/sentences.conll.no_punct $ROOT/training_data/english/en_ewt-ud-test.conllx ) 

rm -rf $DIR/test_out_bs$beam_size
rm -rf $DIR/eval_out_bs$beam_size

mkdir -p $DIR/test_out_bs$beam_size
mkdir -p $DIR/eval_out_bs$beam_size

pretra_jar=$ROOT/IncTransitionParser/target/scala-2.12/rbgparser-assembly-1.0.jar

for model in ${models[@]}
do
	for test_file in "${test_files[@]}"
	do
		model_file=$model
		test_file=$test_file
		gold_file=$test_file

		test_out_file=$DIR/test_out_bs$beam_size/$(basename $test_file).$(basename $model_file).out

		java -jar $pretra_jar \
			--filter-morph \
			--test --test-file=$test_file \
			--out-file=$test_out_file \
			--model-file=$model_file \
			--beam-size=$beam_size\
			--lstm-opts --nouse-first-order-scorer

		eval_out_file=$DIR/eval_out_bs$beam_size/$(basename $test_file).$(basename $model_file).evaluation
		java -jar $pretra_jar \
			--evaluate --eval-gold-file=$gold_file \
			--eval-system-file=$test_out_file \
			--eval-output-file=$eval_out_file \
			--model-file=$model_file \
			--lstm-opts --nouse-first-order-scorer

		# also test with least errors in beam
		test_out_file=$DIR/test_out_bs$beam_size/$(basename $test_file).$(basename $model_file).out.no_top_down
		java -jar $pretra_jar \
			--filter-morph \
			-g\
			--test --test-file=$test_file \
			--out-file=$test_out_file \
			--model-file=$model_file \
			--beam-size=$beam_size\
			--lstm-opts --nouse-first-order-scorer

		eval_out_file=$DIR/eval_out_bs$beam_size/$(basename $test_file).$(basename $model_file).no_top_down.evaluation
		java -jar $pretra_jar \
			--evaluate --eval-gold-file=$gold_file \
			--eval-system-file=$test_out_file \
			--eval-output-file=$eval_out_file \
			--model-file=$model_file \
			--lstm-opts --nouse-first-order-scorer
	done
done

# cd $dir/eval_out_bs$beam_size
# $DIR/plot_all_data.sh
# cd $DIR
