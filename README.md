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

This will probably take a while to train, on my systems it took around 2 to 3
hours. Keep in mind that you need sufficient memory capacity, and if that is
limitted keep enough swap space around. You should now have 2 model files in 
`models/ewt_english`, one for PreTra and one for RBGParser.


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

## Docker, what and why

I haven't seen many repositories that host the code used in papers that use
docker to make the setup easier. So I'd like to quickly explain what it is and
why I'm using it here. I also want to quickly link [a great blog post](https://arne.chark.eu/2019/tips-research-software/) about
why you should post the code to reproduce your results.

Docker is a system for creating and managing _containers_. A container is a
package of software that puts all code and dependencies for a piece of software
in a reliable and lightweight package. The _Docker Engine_ is used to turn 
container images into containers, this means that you can run the code
that is contained in the container image anywhere that the Docker Engine runs.
For this reason it makes it a simple way to setup an environment that all
dependencies are satisfied for your code and you can ensure that anyone who
has docker installed can run it.

Because setting up both of these parsers is not trivial, for this reason I have
automated that in the dockerfile that describes the setup required to run the 
code in this repository, as well as the code for PreTra and RBGParser. This
makes it easier for anyone who wants to run this code, because they only have
to install docker and build the docker image that contains all the dependencies
for this code. Documentation on how to install docker can be found [here](https://www.docker.com/get-started).

[1]: TODO
[2]: https://arne.chark.eu/static/predictive-dependency-parsing.pdf
