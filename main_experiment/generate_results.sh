#!/usr/bin/env bash

# obtain the directory the bash script is stored in
DIR=$(cd $(dirname $0); pwd)
ROOT=$DIR/../

beam_size=$1
rbg_result_csv_line=$2
model_names=( en_ewt_pretra_augment-loss.model )
results_file=results_bs$beam_size.csv

# output header line
echo "model,EWT,gp" > $results_file

# append rbg data
echo -e $rbg_result_csv_line >> $results_file

for model_name in ${model_names[@]}
do
	echo -n "$model_name," >> $results_file
	# plain pretra
	for f in $(ls eval_out_bs$beam_size/*.$model_name*.evaluation)
	do
		cat $f | grep -E "^6" | awk '{print $5"+"$2}'
		# grep line starting with 6 -> complete sentence data
		# print columns 6 and 2 in a arithmetic expression that is processed by bc
		part=$(cat $f | grep -E "^6" | awk '{print $2"/("$5"+"$2")*100"}' | bc -l | awk '{print $1","}')
		echo -n "$part" >> $results_file
	done

	echo "" >> $results_file
done
