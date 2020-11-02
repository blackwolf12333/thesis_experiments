#!/usr/bin/env bash
# author: Peter Maatman <p.q.maatman@students.uu.nl>
# License: Apache 2.0
#

set -eu

beam_size=$1

# generates evaluation files in eval_out, these files are parsed later in
# this script to get the numbers we are interested in
./evaluate_all_inc.sh $beam_size

RBG_NUMBERS=$(./evaluate_rbg.sh)

# rbg outputs in 0-1 range instead of percentage so convert it and
# output as a csv line
RBG_LINE=$(echo $RBG_NUMBERS | awk '{print "print "$1"*100,\",\","$2"*100"}' | bc -l | awk '{print "rbg,"$0"\n"}')

./generate_results.sh $beam_size $RBG_LINE
