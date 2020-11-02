#!/usr/bin/env bash
# author: Peter Maatman <p.q.maatman@students.uu.nl>
# License: Apache 2.0
#

set -eu

beam_size=$1

# generates evaluation files in eval_out, these files are parsed later in
# this script to get the numbers we are interested in
./evaluate_all_inc.sh $beam_size

./generate_results.sh $beam_size
