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
