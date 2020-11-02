## Setup

First things first, we need the code in the submodules, so initialize and update
those first.

1. `git submodule init`
2. `git submodule update`

This repository makes it really easy to reproduce the results of my thesis [1].
A dockerfile is provided that can be used to recreate the exact environment
that was used to produce the results in my thesis. To build the docker image
run `./docker/build.sh`.

When this step is done you can execute `./docker/run.sh`, which will open
a bash shell inside the image, with the current directory mounted as a volume.
From there you can execute the following steps to build and train the parsers.

1. `./build-parsers.sh`
2. `./train.sh`

You should now have 2 model files in `models/ewt_english`, one for PreTra and
one for RBGParser.


## Experiments

In my thesis 2 experiments are done, one compares the unlabeled attachment
scores of both parsers on the EWT test set with the scores on the garden
path dataset. The other experiment is based on an experiment done in [2],
it investigates what the reason is for the bad scores of PreTra on the garden
path sentences, it does this by always keeping the structure with the least
errors compared to the gold attachment in the beam.

The sections below describe how to reproduce the results from my thesis. This 
assumes you are running the scripts from inside the docker image.

### Main experiment

1. `cd main_experiment`
2. `./evaluate_all.sh 10`

The 10 in step 2 indicates the used beam size, this can be changed depending
on this argument if you want to experiment with different beam sizes during
evaluation. A beam size of 10 is used in my thesis following [2].
The output of this script is a file called `results_bs10.csv`, where the 10
in the filename is the beam size.

### Beam search errors experiment

1. `cd beam_errors_experiment`
2. `./evaluate_all.sh 10`

Similar to the main experiment this will output a `results_bs10.csv` file
with the scores.

[1]: TODO
[2]: https://arne.chark.eu/static/predictive-dependency-parsing.pdf
